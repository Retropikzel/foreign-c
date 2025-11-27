(test-begin "define-c-procedure")

(define-c-procedure c-atoi libc 'atoi 'int '(pointer))
(test-equal "1" (c-atoi (string->c-utf8 "100")) 100)

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(define chars-written (c-puts (string->c-utf8 "puts: Hello from testing, I am C function puts")))
(test-equal "2" chars-written 47)

(define-c-procedure c-strcat libc 'strcat 'pointer '(pointer pointer))
(define c-string1 (string->c-utf8 "test123"))
(test-assert "3" (string=? (c-utf8->string (c-strcat (string->c-utf8 "con2")
                                                     (string->c-utf8 "cat2")))
                           "con2cat2"))

(when (file-exists? "testfile.test") (delete-file "testfile.test"))
(define-c-procedure c-fopen libc 'fopen 'pointer '(pointer pointer))
(define output-file (c-fopen (string->c-utf8 "testfile.test")
                             (string->c-utf8 "w")))
(define-c-procedure c-fprintf libc 'fprintf 'int '(pointer pointer int))
(define characters-written (c-fprintf output-file (string->c-utf8 "Hello world %i") 1))
(test-equal "4" characters-written 13)
(define-c-procedure c-fclose libc 'fclose 'int '(pointer))
(define closed-status (c-fclose output-file))
(test-equal "5" closed-status 0)
(test-assert "6" (file-exists? "testfile.test"))

;; Own readline so tests work on R6RS
(define (rl result)
  (let ((c (read-char)))
    (if (eof-object? c)
      result
      (rl (string-append result (string c))))))
(define file-content (with-input-from-file "testfile.test"
                                           (lambda () (rl ""))))
(test-assert "7" (string=? file-content "Hello world 1"))

(test-end "define-c-procedure")
