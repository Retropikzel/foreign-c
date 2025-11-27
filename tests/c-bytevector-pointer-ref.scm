(test-begin "c-bytevector-pointer-ref")

(test-equal "1" (c-bytevector-u8-ref (c-bytevector-pointer-ref p-pointer 0) 0) 42)

(test-end "c-bytevector-pointer-ref")
