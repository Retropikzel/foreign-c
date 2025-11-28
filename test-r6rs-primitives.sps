#!r6rs
(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (rnrs programs) (foreign c sagittarius-primitives) (srfi :64) (only (scheme base) cond-expand) (only (rnrs bytevectors) make-bytevector bytevector?))
(test-begin "foreign-c-r6rs-primitives")
(test-begin "size-of-type")

(test-equal "size-of-type int8" (size-of-type 'int8) 1)
(test-equal "size-of-type uint8" (size-of-type 'uint8) 1)
(test-equal "size-of-type int16" (size-of-type 'int16) 2)
(test-equal "size-of-type uint16" (size-of-type 'uint16) 2)
(test-equal "size-of-type int32" (size-of-type 'int32) 4)
(test-equal "size-of-type uint32" (size-of-type 'uint32) 4)
(test-equal "size-of-type int64" (size-of-type 'int64) 8)
(test-equal "size-of-type uint64" (size-of-type 'uint64) 8)
(test-equal "size-of-type char" (size-of-type 'char) 1)
(test-equal "size-of-type unsigned-char" (size-of-type 'unsigned-char) 1)
(test-equal "size-of-type short" (size-of-type 'short) 2)
(test-equal "size-of-type unsigned-short" (size-of-type 'unsigned-short) 2)
(test-equal "size-of-type int" (size-of-type 'int) 4)
(test-equal "size-of-type unsigned-int" (size-of-type 'unsigned-int) 4)

(cond-expand
  (i386
    (test-equal (size-of-type 'long) 4))
  (else
    (test-equal (size-of-type 'long) 8)))

(cond-expand
  (i386
    (test-equal (size-of-type 'unsigned-long) 4))
  (else
    (test-equal (size-of-type 'unsigned-long) 8)))

(test-equal "size-of-type float" (size-of-type 'float) 4)
(test-equal "size-of-type double" (size-of-type 'double) 8)

(cond-expand
  (i386
    (test-equal (size-of-type 'pointer) 4))
  (else
    (test-equal (size-of-type 'pointer) 8)))

(test-end "size-of-type")
(test-end "foreign-c-r6rs-primitives")
