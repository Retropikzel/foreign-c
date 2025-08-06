#include <math.h>
#include <stdint.h>
#include <gauche.h>
#include <gauche/extend.h>
#include <gauche/module.h>
#include <gauche/load.h>
#include <gauche/number.h>
#include <gauche/string.h>
#include <foreign-c-primitives-gauche.h>
#include <ffi.h>
#include <dlfcn.h>

void print_pointer(ScmObj obj, ScmPort* sink, ScmWriteContext* G1788 SCM_UNUSED) {
    void* p = SCM_FOREIGN_POINTER_REF(void*, obj);
    if(p == NULL) {
        Scm_Printf(sink, "<pointer: (null)>\n");
    } else {
        Scm_Printf(sink, "<pointer: %i>\n", &p);
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

ScmObj align_of_int8() { return Scm_MakeInteger(_Alignof(int8_t)); }
ScmObj align_of_uint8() { return Scm_MakeInteger(_Alignof(uint8_t)); }
ScmObj align_of_int16() { return Scm_MakeInteger(_Alignof(int16_t)); }
ScmObj align_of_uint16() { return Scm_MakeInteger(_Alignof(uint16_t)); }
ScmObj align_of_int32() { return Scm_MakeInteger(_Alignof(int32_t)); }
ScmObj align_of_uint32() { return Scm_MakeInteger(_Alignof(uint32_t)); }
ScmObj align_of_int64() { return Scm_MakeInteger(_Alignof(int64_t)); }
ScmObj align_of_uint64() { return Scm_MakeInteger(_Alignof(uint64_t)); }
ScmObj align_of_char() { return Scm_MakeInteger(_Alignof(char)); }
ScmObj align_of_unsigned_char() { return Scm_MakeInteger(_Alignof(unsigned char)); }
ScmObj align_of_short() { return Scm_MakeInteger(_Alignof(short)); }
ScmObj align_of_unsigned_short() { return Scm_MakeInteger(_Alignof(unsigned short)); }
ScmObj align_of_int() { return Scm_MakeInteger(_Alignof(int)); }
ScmObj align_of_unsigned_int() { return Scm_MakeInteger(_Alignof(unsigned int)); }
ScmObj align_of_long() { return Scm_MakeInteger(_Alignof(long)); }
ScmObj align_of_unsigned_long() { return Scm_MakeInteger(_Alignof(unsigned long)); }
ScmObj align_of_float() { return Scm_MakeInteger(_Alignof(float)); }
ScmObj align_of_double() { return Scm_MakeInteger(_Alignof(double)); }
ScmObj align_of_string() { return Scm_MakeInteger(_Alignof(char*)); }
ScmObj align_of_pointer() { return Scm_MakeInteger(_Alignof(void*)); }
ScmObj align_of_void() { return Scm_MakeInteger(_Alignof(void)); }

ScmModule* module = NULL;

ScmObj shared_object_load(ScmString* path, ScmObj options) {
    const ScmStringBody* body = SCM_STRING_BODY(path);
    const char* c_path = SCM_STRING_BODY_START(body);
    void* shared_object = dlopen(c_path, RTLD_NOW);
    ScmClass* shared_object_class = Scm_MakeForeignPointerClass(module, "shared-object", print_pointer, NULL, 0);
    ScmObj scm_shared_object = Scm_MakeForeignPointer(shared_object_class, shared_object);
    return scm_shared_object;
}

/*
ScmObj pointer_null() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    ScmObj pointer = Scm_MakeForeignPointer(pointer_class, NULL);
    return pointer;
}
*/

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

/*
ScmObj pointer_allocate(int size) {
    void* p = malloc(size);
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    ScmObj pointer = Scm_MakeForeignPointer(pointer_class, p);
    return pointer;
}
*/

/*
ScmObj pointer_address(ScmObj pointer) {
    if(!Scm_TypeP(pointer, SCM_CLASS_FOREIGN_POINTER)) {
        Scm_Error("Can only get pointer address of a pointer");
        return SCM_UNDEFINED;
    }
    void* p = SCM_FOREIGN_POINTER_REF(void*, p);
    //ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    //ScmObj address = Scm_MakeForeignPointer(pointer_class, p);
    printf("HERE: %u", (uint64_t)&p);
    return SCM_MAKE_INT((uint64_t)&p);
}
*/

ScmObj is_pointer(ScmObj pointer) {
    if(Scm_TypeP(pointer, SCM_CLASS_FOREIGN_POINTER)) {
        return SCM_TRUE;
    } else {
        return SCM_FALSE;
    }
}

/*
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
*/

ScmObj pointer_set_uint8(ScmObj pointer, int offset, uint8_t value) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        *(uint8_t*)((char*)p + offset) = value;
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

/*
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

*/

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

/*

ScmObj pointer_get_int8(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(int8_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}
*/

ScmObj pointer_get_uint8(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        return SCM_MAKE_INT(*(uint8_t*)((char*)p + offset));
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

/*
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
*/

ScmObj pointer_get_pointer(ScmObj pointer, int offset) {
    if(SCM_FOREIGN_POINTER_P(pointer)) {
        void* p = SCM_FOREIGN_POINTER_REF(void*, pointer);
        char* p1 = (char*)p + offset;
        ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
        return Scm_MakeForeignPointer(pointer_class, (void*)*(char**)p1);
    } else {
        Scm_Error("Not a pointer: %S", pointer);
    }
    return SCM_UNDEFINED;
}

/*

ScmObj string_to_pointer(ScmObj string) {
    if(SCM_STRINGP(string)) {
        ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
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
*/

ScmObj internal_dlerror() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    void* msg = dlerror();
    if(msg == NULL) {
        return Scm_MakeForeignPointer(pointer_class, NULL);
    } else {
        return Scm_MakeForeignPointer(pointer_class, msg);
    }
}

ScmObj internal_dlsym(ScmObj shared_object, ScmObj c_name) {

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

    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, symbol);
}

ScmObj get_ffi_type_int8() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint8);
}

ScmObj get_ffi_type_uint8() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint8);
}

ScmObj get_ffi_type_int16() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint16);
}

ScmObj get_ffi_type_uint16() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint16);
}

ScmObj get_ffi_type_int32() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint32);
}

ScmObj get_ffi_type_uint32() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint32);
}

ScmObj get_ffi_type_int64() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint64);
}

ScmObj get_ffi_type_uint64() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint64);
}

ScmObj get_ffi_type_char() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_schar);
}

ScmObj get_ffi_type_unsigned_char() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uchar);
}

ScmObj get_ffi_type_short() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sshort);
}

ScmObj get_ffi_type_unsigned_short() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_ushort);
}

ScmObj get_ffi_type_int() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_sint);
}

ScmObj get_ffi_type_unsigned_int() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_uint);
}

ScmObj get_ffi_type_long() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_slong);
}

ScmObj get_ffi_type_unsigned_long() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_ulong);
}

ScmObj get_ffi_type_float() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_float);
}

ScmObj get_ffi_type_double() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_double);
}

ScmObj get_ffi_type_void() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_void);
}

ScmObj get_ffi_type_pointer() {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, &ffi_type_pointer);
}

ScmObj internal_ffi_call(
        ScmObj nargs,
        ScmObj rtype,
        ScmObj atypes,
        ScmObj fn,
        ScmObj rvalue_size,
        ScmObj avalues)
    {

    ffi_cif cif;

    /*
    unsigned int c_nargs = SCM_INT_VALUE(nargs);
    ffi_type* c_rtype = SCM_FOREIGN_POINTER_REF(ffi_type*, rtype);
    int atypes_length = (int)Scm_Length(atypes);
    ffi_type* c_atypes[atypes_length];
    for(int i = 0; i < atypes_length; i++) {
        switch(atypes[i]) {
        }
        //c_atypes[i] = SCM_FOREIGN_POINTER_REF(ffi_type*, Scm_ListRef(atypes, i, SCM_UNDEFINED));
    }
    */

    unsigned int c_nargs = SCM_INT_VALUE(nargs);
    ffi_type* c_atypes[c_nargs];
    void* c_avalues[c_nargs];
    uint8_t vals2[c_nargs];
    uint64_t vals8[c_nargs];
    int vals13[c_nargs];
    void* vals20[c_nargs];

    for(int i = 0; i < c_nargs; i++) {
        ScmObj type = Scm_ListRef(atypes, i, SCM_UNDEFINED);
        ScmObj value = Scm_ListRef(avalues, i, SCM_UNDEFINED);
        switch(SCM_INT_VALUE(type)) {
            //case 1: c_atypes[i] = &ffi_type_sint8; arg = sexp_sint_value(avalues[i]); break;
            case 2:
                c_atypes[i] = &ffi_type_uint8;
                vals2[i] = (uint8_t)SCM_INT_VALUE(value);
                c_avalues[i] = &vals2[i];
                break;
                //case 3: c_atypes[i] = &ffi_type_sint16; arg = sexp_sint_value(avalues[i]); break;
                //case 4: c_atypes[i] = &ffi_type_uint16; arg = sexp_uint_value(avalues[i]); break;
                //case 5: c_atypes[i] = &ffi_type_sint32; arg = sexp_sint_value(avalues[i]); break;
                //case 6: c_atypes[i] = &ffi_type_uint32; arg = sexp_uint_value(avalues[i]); break;
                //case 7: c_atypes[i] = &ffi_type_sint64; arg = sexp_sint_value(avalues[i]); break;
            case 8:
                c_atypes[i] = &ffi_type_uint64;
                vals8[i] = (uint64_t)SCM_INT_VALUE(value);
                c_avalues[i] = &vals8[i];
                break;
                //case 9: c_atypes[i] = &ffi_type_schar; arg = sexp_sint_value(avalues[i]); break;
                //case 10: c_atypes[i] = &ffi_type_uchar; arg = sexp_uint_value(avalues[i]); break;
                //case 11: c_atypes[i] = &ffi_type_sshort; arg = sexp_sint_value(avalues[i]); break;
                //case 12: c_atypes[i] = &ffi_type_ushort; arg = sexp_uint_value(avalues[i]); break;
            case 13:
                c_atypes[i] = &ffi_type_sint;
                vals13[i] = (int)SCM_INT_VALUE(value);
                c_avalues[i] = &vals13[i];
                break;
                //case 14: c_atypes[i] = &ffi_type_uint; arg = sexp_uint_value(avalues[i]); break;
                //case 15: c_atypes[i] = &ffi_type_slong; arg = sexp_sint_value(avalues[i]); break;
                //case 16: c_atypes[i] = &ffi_type_ulong; arg = sexp_uint_value(avalues[i]); break;
                // FIXME
                //case 17: c_atypes[i] = &ffi_type_float; arg = sexp_flonum_value(avalues[i]); break;
                // FIXME
                //case 18: c_atypes[i] = &ffi_type_double; arg = sexp_flonum_value(avalues[i]); break;
                //case 19: c_atypes[i] = &ffi_type_void; arg = NULL; break;
            case 20:
                //printf("Argument value: %s\n", SCM_FOREIGN_POINTER_REF(char*, value));
                c_atypes[i] = &ffi_type_pointer;
                vals20[i] = SCM_FOREIGN_POINTER_REF(void*, value);
                c_avalues[i] = &vals20[i];
                //printf("Argument value1: %s\n", *(char**)c_avalues[i]);
                //printf("Pointer value: %s\n", sexp_cpointer_maybe_null_value(avalues[i]));
                break;
            default:
                //printf("Undefined argument type: %i, index: %i\n", SCM_INT_VALUE(type), i);
                //c_avalues[i] = sexp_cpointer_value(avalues[i]);
                break;
        }
    }

    ffi_type* c_rtype = &ffi_type_void;
    switch(SCM_INT_VALUE(rtype)) {
      case 1: c_rtype = &ffi_type_sint8; break;
      case 2: c_rtype = &ffi_type_uint8; break;
      case 3: c_rtype = &ffi_type_sint16; break;
      case 4: c_rtype = &ffi_type_uint16; break;
      case 5: c_rtype = &ffi_type_sint32; break;
      case 6: c_rtype = &ffi_type_uint32; break;
      case 7: c_rtype = &ffi_type_sint64; break;
      case 8: c_rtype = &ffi_type_uint64; break;
      case 9: c_rtype = &ffi_type_schar; break;
      case 10: c_rtype = &ffi_type_uchar; break;
      case 11: c_rtype = &ffi_type_sshort; break;
      case 12: c_rtype = &ffi_type_ushort; break;
      case 13: c_rtype = &ffi_type_sint; break;
      case 14: c_rtype = &ffi_type_uint; break;
      case 15: c_rtype = &ffi_type_slong; break;
      case 16: c_rtype = &ffi_type_ulong; break;
      case 17: c_rtype = &ffi_type_float; break;
      case 18: c_rtype = &ffi_type_double; break;
      case 19: c_rtype = &ffi_type_void; break;
      case 20: c_rtype = &ffi_type_pointer; break;
      default:
        printf("Undefined return type: %i\n", SCM_INT_VALUE(rtype));
        c_rtype = &ffi_type_pointer;
      break;
    }

    int prep_status = ffi_prep_cif(&cif, FFI_DEFAULT_ABI, c_nargs, c_rtype, c_atypes);

    void* c_fn = SCM_FOREIGN_POINTER_REF(void*, fn);
    void* rvalue = malloc(SCM_INT_VALUE(rvalue_size)); //SCM_FOREIGN_POINTER_REF(void*, rvalue);
    /*
    int avalues_length = (int)Scm_Length(avalues);
    void* c_avalues[avalues_length];
    for(int i = 0; i < avalues_length; i++) {
        ScmObj item = Scm_ListRef(avalues, i, SCM_UNDEFINED);
        void* pp = SCM_FOREIGN_POINTER_REF(void*, item);
        char* list_p = (char*)c_avalues + (sizeof(void) * i);
        c_avalues[i] = pp;
    }*/
    ffi_call(&cif, FFI_FN(c_fn), rvalue, c_avalues);

    //printf("Return value: %s\n", (char*)rvalue);
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "pointer", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, rvalue);
}

ScmObj scheme_procedure_to_pointer(ScmObj procedure) {
    ScmClass* pointer_class = Scm_MakeForeignPointerClass(module, "callback", print_pointer, NULL, 0);
    return Scm_MakeForeignPointer(pointer_class, procedure);
}

/*
ScmObj procedure_to_pointer(ScmObj procedure) {

    return SCM_UNDEFINED;
}*/

void Scm_Init_gauche(void)
{
    SCM_INIT_EXTENSION(foreign.c.primitives.gauche);
    module = SCM_MODULE(SCM_FIND_MODULE("foreign.c.primitives.gauche", TRUE));
    Scm_Init_gauchelib();
}
