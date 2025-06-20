(import (scheme base)
        (scheme write)
        (foreign c))


(cond-expand
  (windows (define-c-library c-stdlib
                             '("stdlib.h")
                             "ucrtbase"
                             '()))
  (else (define-c-library c-stdlib
                          '("stdlib.h")
                          "c"
                          '((additional-versions ("6"))))))

(define-c-procedure c-system c-stdlib 'system 'int '(pointer))

(define (anything->string item)
  (parameterize
    ((current-output-port (open-output-string)))
    (display item)
    (get-output-string (current-output-port))))

(define (system command)
  (c-system (string->c-utf8
              (apply string-append
                     (map (lambda (item)
                            (string-append (anything->string item) " "))
                          command)))))

(system '(ls))

