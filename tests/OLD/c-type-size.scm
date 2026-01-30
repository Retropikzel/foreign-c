(test-begin "c-type-size")

(test-equal "c-type-size int8" (c-type-size 'i8) 1)
(test-equal "c-type-size uint8" (c-type-size 'u8) 1)
(test-equal "c-type-size int16" (c-type-size 'i16) 2)
(test-equal "c-type-size uint16" (c-type-size 'u16) 2)
(test-equal "c-type-size int32" (c-type-size 'i32) 4)
(test-equal "c-type-size uint32" (c-type-size 'u32) 4)
(test-equal "c-type-size int64" (c-type-size 'i64) 8)
(test-equal "c-type-size uint64" (c-type-size 'u64) 8)
(test-equal "c-type-size char" (c-type-size 'char) 1)
(test-equal "c-type-size unsigned-char" (c-type-size 'uchar) 1)
(test-equal "c-type-size short" (c-type-size 'short) 2)
(test-equal "c-type-size unsigned-short" (c-type-size 'ushort) 2)
(test-equal "c-type-size int" (c-type-size 'int) 4)
(test-equal "c-type-size unsigned-int" (c-type-size 'uint) 4)

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
