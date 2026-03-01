;(test-begin "define-c-struct")

(define c-int (make-c-integer-type 'int 4 4 #t))
(define color (make-c-struct-type 'color
                               `((r . ,c-int)
                                 (g . ,c-int)
                                 (b . ,c-int))))
(define green (make-c-bytevector (c-type-size color)))
(write color)
(newline)
(c-bytevector-set! green color 'r 0)
(c-bytevector-set! green color 'g 255)
(c-bytevector-set! green color 'b 0)
(write (c-bytevector-ref green color 'g))
(newline)

(write (c-bytevector->list green color))
(newline)

;(test-end "define-c-struct")
