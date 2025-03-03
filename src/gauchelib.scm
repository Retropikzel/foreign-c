;;;
;;; spigot - 'spigot' extension module example
;;;
;;;  Written by Shiro Kawai (shiro@acm.org)
;;;  I put this program in public domain.  Use it as you like.
;;;

(in-module retropikzel.pffi.gauche)

;;
;; The 'define-cproc' forms exposes C functions to Scheme world.
;;

(inline-stub
 (.include "pffi-gauche.h")
 (define-cproc size-of-int8 () size_of_int8)
 (define-cproc size-of-uint8 () size_of_uint8)
 (define-cproc size-of-int16 () size_of_int16)
 (define-cproc size-of-uint16 () size_of_int16)
 (define-cproc size-of-int32 () size_of_int32)
 (define-cproc size-of-uint32 () size_of_int32)
 (define-cproc size-of-int64 () size_of_int64)
 (define-cproc size-of-uint64 () size_of_int64)
 (define-cproc size-of-char () size_of_char)
 (define-cproc size-of-unsigned-char () size_of_unsigned_char)
 (define-cproc size-of-short () size_of_short)
 (define-cproc size-of-unsigned-short () size_of_unsigned_short)
 (define-cproc size-of-int () size_of_int)
 (define-cproc size-of-unsigned-int () size_of_unsigned_int)
 (define-cproc size-of-long () size_of_long)
 (define-cproc size-of-unsigned-long () size_of_unsigned_long)
 (define-cproc size-of-float () size_of_float)
 (define-cproc size-of-double () size_of_double)
 (define-cproc size-of-string () size_of_string)
 (define-cproc size-of-pointer () size_of_pointer)
 (define-cproc size-of-void () size_of_void)
 (define-cproc shared-object-load (path::<string>) shared_object_load)
 (define-cproc pointer-null () pointer_null)
 (define-cproc pointer-null? (pointer) is_pointer_null)
 (define-cproc pointer-allocate (size::<int>) pointer_allocate)
 (define-cproc pointer? (pointer) is_pointer)
 (define-cproc pointer-free (pointer) pointer_free)
 (define-cproc spigot-calculate-e (digits::<int>) Spigot_calculate_e))

;; You can define Scheme functions here if you want.
