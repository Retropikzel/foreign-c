(import (scheme base)
        (scheme write)
        (foreign c))

(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(c-puts (string->c-utf8 "Hello from C!"))

