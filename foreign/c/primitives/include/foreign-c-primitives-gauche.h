/*
 * spigot.h - calculate pi and e by spigot algorithm
 *
 *  Written by Shiro Kawai (shiro@acm.org)
 *  I put this program in public domain.  Use it as you like.
 */

extern ScmObj size_of_int8();
extern ScmObj size_of_uint8();
extern ScmObj size_of_int16();
extern ScmObj size_of_uint16();
extern ScmObj size_of_int32();
extern ScmObj size_of_uint32();
extern ScmObj size_of_int64();
extern ScmObj size_of_uint64();
extern ScmObj size_of_char();
extern ScmObj size_of_unsigned_char();
extern ScmObj size_of_short();
extern ScmObj size_of_unsigned_short();
extern ScmObj size_of_int();
extern ScmObj size_of_unsigned_int();
extern ScmObj size_of_long();
extern ScmObj size_of_unsigned_long();
extern ScmObj size_of_float();
extern ScmObj size_of_double();
extern ScmObj size_of_string();
extern ScmObj size_of_pointer();
extern ScmObj size_of_void();
extern ScmObj shared_object_load(ScmString* path, ScmObj options);
//extern ScmObj pointer_null();
//extern ScmObj is_pointer_null();
//extern ScmObj pointer_allocate(int size);
//extern ScmObj pointer_address(ScmObj pointer);
extern ScmObj is_pointer(ScmObj pointer);
//extern ScmObj pointer_free(ScmObj pointer);

//extern ScmObj pointer_set_int8(ScmObj pointer, int offset, int8_t value);
extern ScmObj pointer_set_uint8(ScmObj pointer, int offset, uint8_t value);
/*
extern ScmObj pointer_set_int16(ScmObj pointer, int offset, int16_t value);
extern ScmObj pointer_set_uint16(ScmObj pointer, int offset, uint16_t value);
extern ScmObj pointer_set_int32(ScmObj pointer, int offset, int32_t value);
extern ScmObj pointer_set_uint32(ScmObj pointer, int offset, uint32_t value);
extern ScmObj pointer_set_int64(ScmObj pointer, int offset, int64_t value);
extern ScmObj pointer_set_uint64(ScmObj pointer, int offset, uint64_t value);
extern ScmObj pointer_set_char(ScmObj pointer, int offset, char value);
extern ScmObj pointer_set_unsigned_char(ScmObj pointer, int offset, unsigned char value);
extern ScmObj pointer_set_short(ScmObj pointer, int offset, short value);
extern ScmObj pointer_set_unsigned_short(ScmObj pointer, int offset, unsigned short value);
extern ScmObj pointer_set_int(ScmObj pointer, int offset, int value);
extern ScmObj pointer_set_unsigned_int(ScmObj pointer, int offset, unsigned int value);
extern ScmObj pointer_set_long(ScmObj pointer, int offset, long value);
extern ScmObj pointer_set_unsigned_long(ScmObj pointer, int offset, unsigned long value);
extern ScmObj pointer_set_float(ScmObj pointer, int offset, float value);
extern ScmObj pointer_set_double(ScmObj pointer, int offset, double value);
*/
extern ScmObj pointer_set_pointer(ScmObj pointer, int offset, ScmObj value);

//extern ScmObj pointer_get_int8(ScmObj pointer, int offset);
extern ScmObj pointer_get_uint8(ScmObj pointer, int offset);
/*
extern ScmObj pointer_get_int16(ScmObj pointer, int offset);
extern ScmObj pointer_get_uint16(ScmObj pointer, int offset);
extern ScmObj pointer_get_int32(ScmObj pointer, int offset);
extern ScmObj pointer_get_uint32(ScmObj pointer, int offset);
extern ScmObj pointer_get_int64(ScmObj pointer, int offset);
extern ScmObj pointer_get_uint64(ScmObj pointer, int offset);
extern ScmObj pointer_get_char(ScmObj pointer, int offset);
extern ScmObj pointer_get_unsigned_char(ScmObj pointer, int offset);
extern ScmObj pointer_get_short(ScmObj pointer, int offset);
extern ScmObj pointer_get_unsigned_short(ScmObj pointer, int offset);
extern ScmObj pointer_get_int(ScmObj pointer, int offset);
extern ScmObj pointer_get_unsigned_int(ScmObj pointer, int offset);
extern ScmObj pointer_get_long(ScmObj pointer, int offset);
extern ScmObj pointer_get_unsigned_long(ScmObj pointer, int offset);
extern ScmObj pointer_get_float(ScmObj pointer, int offset);
extern ScmObj pointer_get_double(ScmObj pointer, int offset);
*/
extern ScmObj pointer_get_pointer(ScmObj pointer, int offset);

//extern ScmObj string_to_pointer(ScmObj string);
//extern ScmObj pointer_to_string(ScmObj pointer);
extern ScmObj internal_dlerror();
extern ScmObj internal_dlsym(ScmObj shared_object, ScmObj c_name);
extern ScmObj internal_ffi_call(ScmObj nargs, ScmObj rtype, ScmObj atypes, ScmObj fn, ScmObj rvalue, ScmObj avalues);
extern ScmObj scheme_procedure_to_pointer(ScmObj procedure);

extern ScmObj get_ffi_type_int8();
extern ScmObj get_ffi_type_uint8();
extern ScmObj get_ffi_type_int16();
extern ScmObj get_ffi_type_uint16();
extern ScmObj get_ffi_type_int32();
extern ScmObj get_ffi_type_uint32();
extern ScmObj get_ffi_type_int64();
extern ScmObj get_ffi_type_uint64();
extern ScmObj get_ffi_type_char();
extern ScmObj get_ffi_type_unsigned_char();
extern ScmObj get_ffi_type_short();
extern ScmObj get_ffi_type_unsigned_short();
extern ScmObj get_ffi_type_int();
extern ScmObj get_ffi_type_unsigned_int();
extern ScmObj get_ffi_type_long();
extern ScmObj get_ffi_type_unsigned_long();
extern ScmObj get_ffi_type_float();
extern ScmObj get_ffi_type_double();
extern ScmObj get_ffi_type_void();
extern ScmObj get_ffi_type_pointer();

extern void Scm_Init_gauchelib(void);
