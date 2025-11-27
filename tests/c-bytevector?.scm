(test-begin "c-bytevector?")

(define is-pointer (make-c-bytevector 100))
(test-assert "1" (c-bytevector? is-pointer))
(test-assert "2" (not (c-bytevector? 100)))
;(test-assert "3" (c-bytevector? #f))
(test-assert "4" (not (c-bytevector? "Hello")))
(test-assert "5" (not (c-bytevector? 'bar)))

(test-end "c-bytevector?")

