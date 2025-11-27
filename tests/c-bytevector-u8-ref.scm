(test-begin "c-bytevector-u8-ref")

(test-equal "1" (c-bytevector-u8-ref u8-pointer 0) 42)

(test-end "c-bytevector-u8-ref")

