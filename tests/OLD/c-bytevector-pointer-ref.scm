(test-begin "c-bytevector-pointer-ref")

(test-equal (c-bytevector-u8-ref (c-bytevector-pointer-ref p-cbv 0) 0) 42)

(test-end "c-bytevector-pointer-ref")
