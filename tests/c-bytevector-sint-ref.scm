(test-begin "c-bytevector-sint-ref")

(test-equal (c-bytevector-sint-ref sint-cbv 0) 32 (native-endianness) (c-type-size 'int))

(test-end "c-bytevector-sint-ref")

