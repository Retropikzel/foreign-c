(import (scheme base)
        (scheme write)
        (retropikzel r7rs-pffi version main))

(define p (pffi-pointer-allocate (+ (* (pffi-size-of 'uint32) 3)
                                    (* (pffi-size-of 'uint8) 4)
                                    (pffi-size-of 'int))))

(write p)
(newline)

(pffi-pointer-free p)


