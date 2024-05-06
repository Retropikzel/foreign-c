(import (scheme base)
        (scheme write)
        (retropikzel pffi v0.1.0 main))

(write (pffi-size-of 'int))
(newline)


