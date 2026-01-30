(test-begin "c-bytevector-u8-set!")

(define u8-cbv (make-c-bytevector (c-type-size 'u8)))
(test-assert (c-bytevector? u8-cbv))
(c-bytevector-u8-set! u8-cbv 0 42)

(test-end "c-bytevector-u8-set!")
