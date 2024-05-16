(import (scheme base)
        (scheme write)
        (scheme process-context)
        (scheme eval)
        (cyclone foreign)
        (retropikzel pffi v0.1.0 main))

(define libc (pffi-shared-object-auto-load (list "stdio.h") "c" (list)))

(display libc)
(newline)

;(pffi-shared-object-load #t (display "this"))

(display "=================")
(newline)

;(pffi-define "hello")
;(c-define puts int "puts" string)
;(puts "I'm from C")

(newline)
(display "=================")
(newline)
