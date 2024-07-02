(import (scheme base)
        (scheme write)
        (retropikzel pffi v0-3-0 main))

(define p (pffi-pointer-allocate (+ (* (pffi-size-of 'uint32) 3)
                                    (* (pffi-size-of 'uint8) 4)
                                    (pffi-size-of 'int))))

(if (not (pffi-pointer? p)) (error "pffi-pointer? returned false when given pointer"))
(if (pffi-pointer? "Hello") (error "pffi-pointer? returned true when given not a pointer"))


