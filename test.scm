(import (scheme base)
        (scheme write)
        (scheme read)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (srfi 64)
        (foreign c))

;; Types

(test-begin "c-type-size")

(test-equal "c-type-size i8" (c-type-size 'i8) 1)
(test-equal "c-type-size u8" (c-type-size 'u8) 1)
(test-equal "c-type-size i16" (c-type-size 'i16) 2)
(test-equal "c-type-size u16" (c-type-size 'u16) 2)
(test-equal "c-type-size i32" (c-type-size 'i32) 4)
(test-equal "c-type-size u32" (c-type-size 'u32) 4)
(test-equal "c-type-size i64" (c-type-size 'i64) 8)
(test-equal "c-type-size u64" (c-type-size 'u64) 8)
(test-equal "c-type-size char" (c-type-size 'char) 1)
(test-equal "c-type-size uchar" (c-type-size 'uchar) 1)
(test-equal "c-type-size short" (c-type-size 'short) 2)
(test-equal "c-type-size ushort" (c-type-size 'ushort) 2)
(test-equal "c-type-size int" (c-type-size 'int) 4)
(test-equal "c-type-size uint" (c-type-size 'uint) 4)

#;(cond-expand
  (i386
    (test-equal (c-type-size 'long) 4))
  (else
    (test-equal (c-type-size 'long) 8)))

#;(cond-expand
  (i386
    (test-equal (c-type-size 'unsigned-long) 4))
  (else
    (test-equal (c-type-size 'unsigned-long) 8)))

(test-equal "c-type-size float" (c-type-size 'float) 4)
(test-equal "c-type-size double" (c-type-size 'double) 8)

#;(cond-expand
  (i386
    (test-equal (c-type-size 'pointer) 4))
  (else
    (test-equal (c-type-size 'pointer) 8)))

(test-end "c-type-size")


(test-begin "c-type-aling")

(test-equal "c-type-align i8" (c-type-align 'i8) 1)
(test-equal "c-type-align u8" (c-type-align 'u8) 1)
(test-equal "c-type-align i16" (c-type-align 'i16) 2)
(test-equal "c-type-align u16" (c-type-align 'u16) 2)
(test-equal "c-type-align i32" (c-type-align 'i32) 4)
(test-equal "c-type-align u32" (c-type-align 'u32) 4)
(test-equal "c-type-align i64" (c-type-align 'i64) 8)
(test-equal "c-type-align u64" (c-type-align 'u64) 8)
(test-equal "c-type-align char" (c-type-align 'char) 1)
(test-equal "c-type-align uchar" (c-type-align 'uchar) 1)
(test-equal "c-type-align short" (c-type-align 'short) 2)
(test-equal "c-type-align ushort" (c-type-align 'ushort) 2)
(test-equal "c-type-align int" (c-type-align 'int) 4)
(test-equal "c-type-align uint" (c-type-align 'uint) 4)

#;(cond-expand
  (i386
    (test-equal (c-type-align 'long) 4))
  (else
    (test-equal (c-type-align 'long) 8)))

#;(cond-expand
  (i386
    (test-equal (c-type-align 'ulong) 4))
  (else
    (test-equal (c-type-align 'ulong) 8)))

(test-equal "c-type-align float" (c-type-align 'float) 4)
(test-equal "c-type-align double" (c-type-align 'double) 8)

#;(cond-expand
  (i386
    (test-equal (c-type-align 'pointer) 4))
  (else
    (test-equal (c-type-align 'pointer) 8)))

(test-end "c-type-aling")


;; Libraries and procedures

(test-begin "define-c-library")
(test-end "define-c-library")

(test-begin "define-c-procedure")
(test-end "define-c-procedure")


;; c-bytevectors

(test-begin "make-c-bytevector")
(test-end "make-c-bytevector")

(test-begin "c-bytevector")
(test-end "c-bytevector")

(test-begin "c-bytevector?")
(test-end "c-bytevector?")

(test-begin "c-free")
(test-end "c-free")

(test-begin "make-c-null")
(test-end "make-c-null")

(test-begin "c-null?")
(test-end "c-null?")

(test-begin "c-bytevector-set!")
(test-end "c-bytevector-set!")

(test-begin "c-bytevector-ref")
(test-end "c-bytevector-ref")

(test-begin "bytevector->c-bytevector")
(test-end "bytevector->c-bytevector")

(test-begin "c-bytevector->bytevector")
(test-end "c-bytevector->bytevector")

(test-begin "c-bytevector->integer")
(define cbv-cbc-int (c-bytevector->integer (make-c-bytevector 128)))
(test-assert (number? cbv-cbc-int))
(test-assert (integer? cbv-cbc-int))
(test-end "c-bytevector->integer")

(test-begin "integer->c-bytevector")
(test-end "integer->c-bytevector")


;; Strings

(test-begin "string->c-utf8")
(test-end "string->c-utf8")

(test-begin "c-utf8->string")
(test-end "c-utf8->string")


;; Pass pointer by address

(test-begin "call-with-address-of")
(test-end "call-with-address-of")


;; Structs

(test-begin "define-c-struct")
(test-end "define-c-struct")


;; Utilities

(test-begin "libc-name")
(test-end "libc-name")


;; endianness

(test-begin "native-endianness")
(test-end "native-endianness")
