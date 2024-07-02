(import (scheme base)
        (scheme write)
        (retropikzel pffi v0-3-0 main))

(define original "Hello world")

(define p (pffi-string->pointer original))
(write p)
(newline)

(define s (pffi-pointer->string p))
(if (not (string=? original s))
  (error (string-append "string from pointer is not " original) s))
(write s)
(newline)


