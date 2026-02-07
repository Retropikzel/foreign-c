(test-begin "bytevector->c-bytevector")

(define bt1 (make-bytevector 64 0))
(define cbt1 (bytevector->c-bytevector bt1))

(test-assert (c-bytevector? cbt1))

(test-end "bytevector->c-bytevector")
