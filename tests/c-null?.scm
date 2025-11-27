(test-begin "c-null?")

(test-assert (c-null? null-pointer))
(test-assert (not (c-null? "")))
(test-assert (not (c-null? #t)))
(test-assert (not (c-null? #f)))
(test-assert (not (c-null? (make-c-bytevector 64))))

(test-end "c-null?")
