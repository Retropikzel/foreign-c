(test-begin "c-bytevector-u8-set!")

(define u8-pointer (make-c-bytevector (c-type-size 'uint8)))
(test-assert "1" (c-bytevector? u8-pointer))
(c-bytevector-u8-set! u8-pointer 0 42)

(test-end "c-bytevector-u8-set!")
