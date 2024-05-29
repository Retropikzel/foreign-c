(import (scheme base)
        (scheme write)
        (scheme process-context)
        (scheme eval)
        (retropikzel pffi v0-2-1 main))

(define libc (pffi-shared-object-auto-load (list "curl/curl.h")
                                              (list)
                                              "c"
                                              (list ".6")))

(pffi-define puts libc 'puts 'int (list 'pointer))

(display "=================")
(newline)

(puts (pffi-string->pointer "This is from C"))

(newline)
(display "=================")
(newline)
