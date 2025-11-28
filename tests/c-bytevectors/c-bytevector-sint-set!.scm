(test-begin "c-bytevector-sint-set!")

(define sint-cbv (make-c-bytevector (c-type-size 'int8)))
(test-assert (bytevector? sint-cbv))
(c-bytevector-sint-set! sint-cbv 0 32 (native-endianness) (c-type-size 'int))

(test-end "c-bytevector-sint-set!")
