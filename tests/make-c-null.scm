(test-begin "make-c-null")

(define null-pointer (make-c-null))

(test-assert (c-bytevector? null-pointer))

(test-end "make-c-null")
