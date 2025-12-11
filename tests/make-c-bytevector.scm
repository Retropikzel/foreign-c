(test-begin "make-c-bytevector")

(define bytes (make-c-bytevector 100))
(test-assert "make-c-bytevector-1" (c-bytevector? bytes))
(test-assert "make-c-bytevector-2" (not (c-null? bytes)))

(test-end "make-c-bytevector")
