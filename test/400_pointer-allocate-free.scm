(import (scheme base)
        (scheme write)
        (retropikzel pffi v0-1-0 main))

(define p (pffi-pointer-allocate (+ (* (pffi-size-of 'uint32) 3)
                                    (* (pffi-size-of 'uint8) 4)
                                    (pffi-size-of 'int))))

(write p)
(newline)

(pffi-pointer-free p)


