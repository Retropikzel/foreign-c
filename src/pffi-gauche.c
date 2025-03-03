#include <math.h>
#include <stdint.h>
#include <gauche.h>
#include <gauche/extend.h>
#include <gauche/module.h>
#include <gauche/load.h>
#include <pffi-gauche.h>
#include <ffi.h>
#include <dlfcn.h>

ScmObj size_of_int8() { return Scm_MakeInteger(sizeof(int8_t)); }
ScmObj size_of_uint8() { return Scm_MakeInteger(sizeof(uint8_t)); }
ScmObj size_of_int16() { return Scm_MakeInteger(sizeof(int16_t)); }
ScmObj size_of_uint16() { return Scm_MakeInteger(sizeof(uint16_t)); }
ScmObj size_of_int32() { return Scm_MakeInteger(sizeof(int32_t)); }
ScmObj size_of_uint32() { return Scm_MakeInteger(sizeof(uint32_t)); }
ScmObj size_of_int64() { return Scm_MakeInteger(sizeof(int64_t)); }
ScmObj size_of_uint64() { return Scm_MakeInteger(sizeof(uint64_t)); }
ScmObj size_of_char() { return Scm_MakeInteger(sizeof(char)); }
ScmObj size_of_unsigned_char() { return Scm_MakeInteger(sizeof(unsigned char)); }
ScmObj size_of_short() { return Scm_MakeInteger(sizeof(short)); }
ScmObj size_of_unsigned_short() { return Scm_MakeInteger(sizeof(unsigned short)); }
ScmObj size_of_int() { return Scm_MakeInteger(sizeof(int)); }
ScmObj size_of_unsigned_int() { return Scm_MakeInteger(sizeof(unsigned int)); }
ScmObj size_of_long() { return Scm_MakeInteger(sizeof(long)); }
ScmObj size_of_unsigned_long() { return Scm_MakeInteger(sizeof(unsigned long)); }
ScmObj size_of_float() { return Scm_MakeInteger(sizeof(float)); }
ScmObj size_of_double() { return Scm_MakeInteger(sizeof(double)); }
ScmObj size_of_string() { return Scm_MakeInteger(sizeof(char*)); }
ScmObj size_of_pointer() { return Scm_MakeInteger(sizeof(void*)); }
ScmObj size_of_void() { return Scm_MakeInteger(sizeof(void)); }

ScmModule* module = NULL;

void print_shared_object(ScmObj obj, ScmPort* sink, ScmWriteContext* G1788 SCM_UNUSED) {
    printf("<pffi-shared-object>\n");
}

ScmObj shared_object_load(ScmString* scm_path) {
    const ScmStringBody* body = SCM_STRING_BODY(scm_path);
    const char* path = SCM_STRING_BODY_START(body);
    void* shared_object = dlopen(path, RTLD_NOW);
    ScmClass* class = Scm_MakeForeignPointerClass(module, "<pffi-shared-object>", print_shared_object, NULL, 0);
    ScmObj scm_shared_object = Scm_MakeForeignPointer(class, shared_object);
    printf("Loading path: %s\n", path);
    return scm_shared_object;
}

void print_pointer(ScmObj obj, ScmPort* sink, ScmWriteContext* G1788 SCM_UNUSED) {
    printf("<pffi-pointer>\n");
}

ScmObj pointer_null() {
    ScmClass* class = Scm_MakeForeignPointerClass(module, "<pffi-pointer>", print_pointer, NULL, 0);
    ScmObj pointer = Scm_MakeForeignPointer(class, NULL);
    return pointer;
}

ScmObj is_pointer_null(ScmObj pointer) {
    if(!SCM_FOREIGN_POINTER_P(pointer)) {
        return SCM_FALSE;
    }
    if(SCM_FOREIGN_POINTER_REF(void*, pointer) == NULL) {
        return SCM_TRUE;
    } else {
        return SCM_FALSE;
    }
}

ScmObj pointer_allocate(int size) {
    ScmClass* class = Scm_MakeForeignPointerClass(module, "<pffi-pointer>", print_pointer, NULL, 0);
    ScmObj pointer = Scm_MakeForeignPointer(class, malloc(size));
    return pointer;
}

ScmObj is_pointer(ScmObj pointer) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        return SCM_TRUE;
    } else {
        return SCM_FALSE;
    }
}

ScmObj pointer_free(ScmObj pointer) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        free(SCM_FOREIGN_POINTER_REF(void*, pointer));
    }
}

ScmObj Spigot_calculate_e(int digits)
{
    int k, i, j, l, b, q, r, *array;
    ScmObj rvec, *relts;

    if (digits <= 0) Scm_Error("digits must be a positive integer");

    /* Scheme vector to keep the result */
    rvec = Scm_MakeVector(digits, SCM_MAKE_INT(0));
    relts = SCM_VECTOR_ELEMENTS(rvec);

    /* Prepare the array for variable base system */
    k = (int)floor(digits * 3.3219280948873626);
    array = SCM_NEW_ATOMIC2(int *, (k+1)*sizeof(int));
    for (i=0; i<k; i++) array[i] = 1;
    array[k] = 2;

    for (i=0, b=1; i<digits; i++) {
        q = 0;
        for (j=k; j>0; j--) {
            q += array[j] * 10;
            array[j] = q % j;
            q /= j;
        }
        r = b + q/10;
        b = q % 10;
        /* Here, we have the i-th digit in r.
           In rare occasions, r becomes more than 10, and we need to back-up
           to increment the previous digit(s).  (It's rarely the case that
           this back-up cascades for more than one digit). */
        if (r < 10) {
            relts[i] = SCM_MAKE_INT(r);
        } else {
            relts[i] = SCM_MAKE_INT(r%10);
            for (l=i-1, r/=10; r && l>=0; l--, r/=10) {
                r += SCM_INT_VALUE(relts[l]);
                relts[l] = SCM_MAKE_INT(r%10);
            }
        }
    }
    return rvec;
}

/*
 * Module initialization function.
 * This is called when math--spigot.so is dynamically loaded into gosh.
 */
void Scm_Init_retropikzel_pffi_gauche(void)
{
    SCM_INIT_EXTENSION(retropikzel.pffi.gauche);
    module = SCM_MODULE(SCM_FIND_MODULE("retropikzel.pffi.gauche", TRUE));
    Scm_Init_gauchelib();
}
