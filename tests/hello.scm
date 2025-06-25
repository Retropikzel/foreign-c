(import (scheme base)
        (scheme write)
        (foreign c))

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(c-puts (string->c-utf8 "Hello from C!"))

