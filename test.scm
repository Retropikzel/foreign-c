(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme process-context)
        (stklos))


(define puts (make-external-function "puts" (list :string) :string ""))

(define hello "Hello")

(display (%get-typed-ext-var hello :string))
(newline)

;(puts "Hello")
;(newline)

