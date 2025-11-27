(test-begin "c-bytevector-sint-ref")

(test-equal (c-bytevector-sint-ref sint-cbv 0 (native-endianness) (c-type-size 'int)) 32)

(test-end "c-bytevector-sint-ref")

