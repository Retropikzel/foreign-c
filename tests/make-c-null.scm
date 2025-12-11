(test-begin "make-c-null")

(define null-pointer (make-c-null))

(test-assert "make-c-null-1" (c-bytevector? null-pointer))

(test-end "make-c-null")
