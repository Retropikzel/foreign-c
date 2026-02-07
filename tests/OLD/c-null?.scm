(test-begin "c-null?")

(test-assert "c-null?-1" (c-null? null-pointer))
(test-assert "c-null?-2" (not (c-null? "")))
(test-assert "c-null?-3" (not (c-null? #t)))
(test-assert "c-null?-4" (not (c-null? #f)))

(test-end "c-null?")
