(test-begin "c-bytevector-s8-set!")

(define s8-bv (make-c-bytevector (c-type-size 'int8)))
(test-assert (bytevector? s8-bv))
(c-bytevector-s8-set! s8-bv 0 1)

(test-end "c-bytevector-s8-set!")
