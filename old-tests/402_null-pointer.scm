(import (scheme base)
        (scheme write)
        (retropikzel r7rs-pffi version main))

(define p (pffi-pointer-allocate (+ (* (pffi-size-of 'uint32) 3)
                                    (* (pffi-size-of 'uint8) 4)
                                    (pffi-size-of 'int))))
(define n (pffi-pointer-null))

(if (not (pffi-pointer-null? n)) (error "pffi-pointer-null? returned false when given null pointer"))
(if (pffi-pointer-null? p) (error "pffi-pointer-null? returned true when given not a null pointer"))
(if (pffi-pointer-null? "Hello") (error "pffi-pointer-null? returned true when given not a pointer"))


