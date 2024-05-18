(import (scheme base)
        (scheme write)
        (retropikzel pffi v0-1-0 main))


(define p (pffi-string->pointer "Hello world"))
(write p)
(newline)

(define s (pffi-pointer->string p))
(write s)
(newline)


