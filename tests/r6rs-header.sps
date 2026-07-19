#!r6rs
(import (rnrs)
        (foreign c)
        (retropikzel tap)
        (srfi :64))

(test-runner-current (tap-runner))
