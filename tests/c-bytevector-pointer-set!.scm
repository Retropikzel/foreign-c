(test-begin "c-bytevector-pointer-set!")

(define p-cbv (make-c-bytevector (c-type-size 'pointer)))
(test-assert (c-bytevector? p-cbv))
(c-bytevector-pointer-set! p-cbv 0 u8-cbv)

(test-end "c-bytevector-pointer-set!")
