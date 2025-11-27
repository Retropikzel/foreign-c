(test-begin "string->c-utf8")

(define c-string (string->c-utf8 "foobar"))
(test-assert "1" (c-bytevector? c-string))

(test-end "string->c-utf8")
