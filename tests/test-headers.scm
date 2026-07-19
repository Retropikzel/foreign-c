(import (scheme base)
        (scheme write)
        (scheme read)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (foreign c)
        (retropikzel tap)
        (srfi 64))

(test-runner-current (tap-runner))

