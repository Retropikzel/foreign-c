#!r6rs
(import (rnrs)
        (foreign c)
        (retropikzel junit)
        (srfi :64))

(test-runner-current (tap-runner))
