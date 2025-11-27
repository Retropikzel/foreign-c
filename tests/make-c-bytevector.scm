(test-begin "make-c-bytevector")

(define bytes (make-c-bytevector 100))
(test-assert "1" (c-bytevector? bytes))

(test-end "make-c-bytevector")
