(test-begin "size-of-type")

(test-equal "size-of-type i8" (size-of-type 'i8) 1)
(test-equal "size-of-type u8" (size-of-type 'u8) 1)
(test-equal "size-of-type i16" (size-of-type 'i16) 2)
(test-equal "size-of-type u16" (size-of-type 'u16) 2)
(test-equal "size-of-type i32" (size-of-type 'i32) 4)
(test-equal "size-of-type u32" (size-of-type 'u32) 4)
(test-equal "size-of-type i64" (size-of-type 'i64) 8)
(test-equal "size-of-type u64" (size-of-type 'u64) 8)
(test-equal "size-of-type char" (size-of-type 'char) 1)
(test-equal "size-of-type uchar" (size-of-type 'uchar) 1)
(test-equal "size-of-type short" (size-of-type 'short) 2)
(test-equal "size-of-type ushort" (size-of-type 'ushort) 2)
(test-equal "size-of-type int" (size-of-type 'int) 4)
(test-equal "size-of-type uint" (size-of-type 'uint) 4)

#;(cond-expand
  (i386
    (test-equal (size-of-type 'long) 4))
  (else
    (test-equal (size-of-type 'long) 8)))

#;(cond-expand
  (i386
    (test-equal (size-of-type 'unsigned-long) 4))
  (else
    (test-equal (size-of-type 'unsigned-long) 8)))

(test-equal "size-of-type float" (size-of-type 'float) 4)
(test-equal "size-of-type double" (size-of-type 'double) 8)

#;(cond-expand
  (i386
    (test-equal (size-of-type 'pointer) 4))
  (else
    (test-equal (size-of-type 'pointer) 8)))

(test-end "size-of-type")
