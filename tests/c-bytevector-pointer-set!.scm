(test-begin "c-bytevector-pointer-set!")

(define p-pointer (make-c-bytevector (c-type-size 'pointer)))
(test-assert "1" (c-bytevector? p-pointer))
(c-bytevector-pointer-set! p-pointer 0 u8-pointer)

(test-end "c-bytevector-pointer-set!")
