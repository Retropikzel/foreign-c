#!r6rs
(import (rnrs)
        (foreign c)
        (retropikzel junit)
        (srfi :64))

(test-runner-current (junit-runner))

(define junit-file "junit-result.xml")
(when (file-exists? junit-file) (delete-file junit-file))
(set-junit-runner-output-port! (open-output-file junit-file))
