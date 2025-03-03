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
extern ScmObj shared_object_load(ScmString* path);
extern ScmObj pointer_null();
extern ScmObj is_pointer_null();
extern ScmObj pointer_allocate(int size);
extern ScmObj is_pointer(ScmObj pointer);
extern ScmObj pointer_free(ScmObj pointer);
extern ScmObj Spigot_calculate_e(int digits);
extern void Scm_Init_gauchelib(void);
