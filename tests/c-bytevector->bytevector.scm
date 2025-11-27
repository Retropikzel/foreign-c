(test-begin "c-bytevector->bytevector")

(define bt2 (c-bytevector->bytevector cbt1 64))

(test-assert (bytevector? bt2))
(test-assert (equal? bt1 bt2))

(test-end "c-bytevector->bytevector")
