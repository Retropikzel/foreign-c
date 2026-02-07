(test-begin "c-bytevector-char-set!")

(define char-cbv (make-c-bytevector (c-type-size 'int8)))
(test-assert (bytevector? char-cbv))
(c-bytevector-char-set! char-cbv 0 #\a)

(test-end "c-bytevector-char-set!")
