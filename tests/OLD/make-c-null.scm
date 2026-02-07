(test-begin "make-c-null")

(define null-pointer (make-c-null))

(test-assert "make-c-null-1" (c-bytevector? null-pointer))

(define-c-procedure c-tempnam libc 'tempnam 'pointer '(pointer pointer))

(let* ((c-tempnam-prefix (string->c-utf8 "npcmd"))
       (r1 (c-utf8->string (c-tempnam (make-c-null)
                                      c-tempnam-prefix)))
       (r2 (c-utf8->string (c-tempnam (make-c-null)
                                      c-tempnam-prefix))))
  (test-assert "make-c-null-2" (string? r1))
  (test-assert "make-c-null-3" (string? r2)))

(test-end "make-c-null")
