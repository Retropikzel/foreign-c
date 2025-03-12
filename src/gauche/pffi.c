#include <math.h>
#include <stdint.h>
#include <gauche.h>
#include <gauche/extend.h>
#include <gauche/module.h>
#include <gauche/load.h>
#include <gauche/number.h>
#include <gauche/string.h>
#include <include/gauche/pffi.h>
#include <ffi.h>
#include <dlfcn.h>

void print_pointer(ScmObj obj, ScmPort* sink, ScmWriteContext* G1788 SCM_UNUSED) {
    void* p = SCM_FOREIGN_POINTER_REF(void*, obj);
    if(p == NULL) {
        Scm_Printf(sink, "<pffi-pointer: (null)>\n");
    } else {
        Scm_Printf(sink, "<pffi-pointer: %i>\n", &p);
    }
}

void dprint_pointer(ScmObj obj, ScmPort* sink, ScmWriteContext* G1788 SCM_UNUSED) {
    void* p = SCM_FOREIGN_POINTER_REF(void*, obj);
    if(p == NULL) {
        Scm_Printf(sink, "<DEBUG pffi-pointer: (null)>\n");
    } else {
        Scm_Printf(sink, "<DEBUG pffi-pointer: %i>\n", &p);
    }
}

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

ScmObj shared_object_load(ScmString* path) {
    const ScmStringBody* body = SCM_STRING_BODY(path);
    const char* c_path = SCM_STRING_BODY_START(body);
    void* shared_object = dlopen(c_path, RTLD_NOW);
    ScmClass* shared_object_class = Scm_MakeForeignPointerClass(module, "pffi-shared-object", print_pointer, NULL, 0);
    ScmObj scm_shared_object = Scm_MakeForeignPointer(shared_object_class, shared_object);
    return scm_shared_object;
}

ScmObj pointer_null() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    ScmObj pointer = Scm_MakeForeignPointer(pointer_class, NULL);
    return pointer;
}

ScmObj is_pointer_null(ScmObj pointer) {
    if(!Scm_TypeP(pointer, SCM_CLASS_FOREIGN_POINTER)) {
        return SCM_FALSE;
    }
    if(SCM_FOREIGN_POINTER_REF(void*, pointer) == NULL) {
        return SCM_TRUE;
    } else {
        return SCM_FALSE;
    }
}

ScmObj pointer_allocate(int size) {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    void* p = malloc(size);
    ScmObj pointer = Scm_MakeForeignPointer(pointer_class, p);
    return pointer;
}

ScmObj pointer_address(ScmObj object) {
    if(!Scm_TypeP(object, SCM_CLASS_FOREIGN_POINTER)) {
        Scm_Error("Can only get pointer address of a pointer");
        return SCM_UNDEFINED;
    }
    void* p = SCM_FOREIGN_POINTER_REF(void*, object);
    return SCM_MAKE_INT(&p);
}

ScmObj is_pointer(ScmObj pointer) {
    if(Scm_TypeP(pointer, SCM_CLASS_FOREIGN_POINTER)) {
        return SCM_TRUE;
    } else {
        return SCM_FALSE;
    }
}

ScmObj pointer_free(ScmObj pointer) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        free(SCM_FOREIGN_POINTER_REF(void*, pointer));
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_int8(ScmObj pointer, int offset, int8_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(int8_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_uint8(ScmObj pointer, int offset, uint8_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(uint8_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_int16(ScmObj pointer, int offset, int16_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(int16_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_uint16(ScmObj pointer, int offset, uint16_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(uint16_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_int32(ScmObj pointer, int offset, int32_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(int32_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_uint32(ScmObj pointer, int offset, uint32_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(uint32_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_int64(ScmObj pointer, int offset, int64_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(int64_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_uint64(ScmObj pointer, int offset, uint64_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(uint64_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_char(ScmObj pointer, int offset, char value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(char*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_unsigned_char(ScmObj pointer, int offset, unsigned char value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(unsigned char*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_short(ScmObj pointer, int offset, short value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(short*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_unsigned_short(ScmObj pointer, int offset, unsigned short value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(unsigned short*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_int(ScmObj pointer, int offset, int value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(int*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_unsigned_int(ScmObj pointer, int offset, unsigned int value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(unsigned int*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_long(ScmObj pointer, int offset, long value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(long*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_unsigned_long(ScmObj pointer, int offset, unsigned long value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(unsigned long*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_float(ScmObj pointer, int offset, float value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(float*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_double(ScmObj pointer, int offset, double value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(double*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_set_pointer(ScmObj pointer, int offset, ScmObj value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* v = SCM_FOREIGN_POINTER_REF(void*, value);
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        char* p1 = (char*)p + offset;
        *(char**)p1 = v;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_int8(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int8_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_uint8(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(uint8_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_int16(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int16_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_uint16(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(uint16_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_int32(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int32_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_uint32(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(uint32_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_int64(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int64_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_uint64(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(uint64_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_char(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(char*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_unsigned_char(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(unsigned char*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_short(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(short*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_unsigned_short(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(unsigned short*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_int(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_unsigned_int(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(unsigned int*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_long(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(long*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_unsigned_long(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(unsigned long*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_float(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return Scm_MakeFlonum(*(float*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_double(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return Scm_MakeFlonum(*(double*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_get_pointer(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        char* p1 = (char*)p + offset;
        ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", dprint_pointer, NULL, 0);
        return Scm_MakeForeignPointer(pointer_class, (void*)*(char**)p1);
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj string_to_pointer(ScmObj string) {
    if(SCM_STRINGP(string)) {
        ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
        return Scm_MakeForeignPointer(pointer_class, Scm_GetString(SCM_STRING(string)));
    } else {
        Scm_Error("Not a string: %S", string);
    }
    return SCM_UNDEFINED;
}

ScmObj pointer_to_string(ScmObj pointer) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        void* string = (char*)p;
        return Scm_MakeString(string, -1, -1, 0);
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

ScmObj pffi_dlerror() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    void* msg = dlerror();
    if(msg == NULL) {
        return Scm_MakeForeignPointer(pointer_class, NULL);
    } else {
        return Scm_MakeForeignPointer(pointer_class, msg);
    }
}

ScmObj pffi_dlsym(ScmObj shared_object, ScmObj c_name) {

    if(!SCM_FOREIGN_POINTER_P(shared_object)) {
        Scm_Error("Not a shared object: %S", shared_object);
        return SCM_UNDEFINED;
    }

    if(!SCM_STRINGP(c_name)) {
        Scm_Error("Not a string: %S", c_name);
        return SCM_UNDEFINED;
    }

    void* handle = SCM_FOREIGN_POINTER_REF(void*, shared_object);
    const ScmStringBody* body = SCM_STRING_BODY(c_name);
    const char* name = SCM_STRING_BODY_START(body);
    void* symbol = dlsym(handle, name);

    if(symbol == NULL) {
        Scm_Error("Could not find function %S", c_name);
        return SCM_UNDEFINED;
    }

    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, symbol);
}

ScmObj get_ffi_type_int8() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint8);
}

ScmObj get_ffi_type_uint8() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint8);
}

ScmObj get_ffi_type_int16() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint16);
}

ScmObj get_ffi_type_uint16() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint16);
}

ScmObj get_ffi_type_int32() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint32);
}

ScmObj get_ffi_type_uint32() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint32);
}

ScmObj get_ffi_type_int64() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint64);
}

ScmObj get_ffi_type_uint64() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint64);
}

ScmObj get_ffi_type_char() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_schar);
}

ScmObj get_ffi_type_unsigned_char() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uchar);
}

ScmObj get_ffi_type_short() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sshort);
}

ScmObj get_ffi_type_unsigned_short() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_ushort);
}

ScmObj get_ffi_type_int() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint);
}

ScmObj get_ffi_type_unsigned_int() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint);
}

ScmObj get_ffi_type_long() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_slong);
}

ScmObj get_ffi_type_unsigned_long() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_ulong);
}

ScmObj get_ffi_type_float() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_float);
}

ScmObj get_ffi_type_double() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_double);
}

ScmObj get_ffi_type_pointer() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pffi-pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_pointer);
}

ScmObj internal_ffi_call(ScmObj nargs, ScmObj rtype, ScmObj atypes, ScmObj fn, ScmObj rvalue, ScmObj avalues) {

    ffi_cif cif;

    unsigned int c_nargs = SCM_INT_VALUE(nargs);
    ffi_type* c_rtype = SCM_FOREIGN_POINTER_REF(ffi_type*, rtype);
    int atypes_length = (int)Scm_Length(atypes);
    ffi_type* c_atypes[atypes_length];
    for(int i = 0; i < atypes_length; i++) {
        c_atypes[i] = SCM_FOREIGN_POINTER_REF(ffi_type*, Scm_ListRef(atypes, i, SCM_UNDEFINED));
    }
    int prep_status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, c_nargs, c_rtype, c_atypes);

    void* c_fn = SCM_FOREIGN_POINTER_REF(void*, fn);
    void* c_rvalue = SCM_FOREIGN_POINTER_REF(void*, rvalue);
    int avalues_length = (int)Scm_Length(avalues);
    void* c_avalues[avalues_length];
    for(int i = 0; i < avalues_length; i++) {
        ScmObj item = Scm_ListRef(avalues, i, SCM_UNDEFINED);
        void* pp = SCM_FOREIGN_POINTER_REF(void*, item);
        char* list_p = (char*)c_avalues + (sizeof(void) * i);
        c_avalues[i] = pp;
    }
    ffi_call(&cif, FFI_FN(c_fn), c_rvalue, c_avalues);

    return SCM_UNDEFINED;
}

/*
ScmObj make_c_function(ScmObj shared_object, ScmObj c_name, ScmObj return_type, ScmObj argument_types) {
    ffi_cif cif;
    //internal_ffi_prep_cif(unsigned int nargs, void* rtype, void* atypes[]) 
    //printf(\"A1: %i, A2: %i, nargs: %i\\n\", &ffi_type_pointer, atypes[0], nargs);
    ffi_prep_cif(&cif, FFI_DEFAULT_ABI, nargs, (ffi_type*)rtype, (ffi_type**)atypes);

    return SCM_UNDEFINED;
}
*/

void Scm_Init_retropikzel_pffi_gauche(void)
{
    SCM_INIT_EXTENSION(retropikzel.pffi.gauche);
    module = SCM_MODULE(SCM_FIND_MODULE("retropikzel.pffi.gauche", TRUE));
    Scm_Init_gauchelib();
}
