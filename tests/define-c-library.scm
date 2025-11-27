(test-begin "define-c-library")

(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

(test-assert "test-assert libc" (if libc #t #f))

(define-c-procedure c-abs libc 'abs 'int '(int))
(test-equal "c-abs" (c-abs -2) 2)

;; Skip these tests on 32 bit implementations
(test-skip (cond-expand (i386 1) (else 0)))
(cond-expand
(i386 #t)
(else
  (define-c-library c-testlib
                    '("libtest.h")
                    "test"
                    '((additional-paths ("." "./tests"))))))

(cond-expand
(i386 #t)
(else
  (define-c-procedure c-takes-no-args c-testlib 'takes_no_args 'void '())
  (c-takes-no-args)))


(cond-expand
(i386 #t)
(else
  (define-c-procedure c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int '())
  (define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
  (test-equal takes-no-args-returns-int-result 0)))

(test-end "define-c-library")
