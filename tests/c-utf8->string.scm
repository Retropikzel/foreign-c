(test-begin "c-utf8->string")

(define scheme-string (c-utf8->string c-string))

(test-assert (string? scheme-string))
(test-assert (string=? scheme-string "foobar"))

(test-end "c-utf8->string")
