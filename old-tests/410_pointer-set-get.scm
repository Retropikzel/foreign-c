(import (scheme base)
        (scheme write)
        (retropikzel r7rs-pffi version main))

(define p (pffi-pointer-allocate (+ (* (pffi-size-of 'uint32) 3)
                                    (* (pffi-size-of 'uint8) 4)
                                    (pffi-size-of 'int))))

(write p)
(newline)

(pffi-pointer-set! p
                   'uint8
                   (+ (* (pffi-size-of 'uint32))
                      (* (pffi-size-of 'uint8) 2))
                   42)

(write p)
(newline)

(let ((result(pffi-pointer-get p
                               'uint8
                               (+ (* (pffi-size-of 'uint32))
                                  (* (pffi-size-of 'uint8) 2)))))
  (if (not (= result 42))
    (error "pffi-pointer-get did not return 42"))

  (write result)
  (newline))


