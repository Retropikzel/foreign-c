;(test-begin "define-c-struct")

(define c-int (make-c-integer-type 'int 4 4 #t))
(define c-float (make-c-float-type 'float))
(define c-pointer (make-c-pointer-type 'pointer 8 8))
(define color (make-c-struct-type 'color
                               `((r . ,c-int)
                                 (g . ,c-int)
                                 (b . ,c-int)
                                 (a . ,c-float)
                                 (metadata . ,c-pointer)
                                 )))
(write color)
(newline)
(define green (make-c-bytevector (c-type-size color)))
(c-bytevector-set! green color 'r 0)
(c-bytevector-set! green color 'g 255)
(c-bytevector-set! green color 'b 0)
(c-bytevector-set! green color 'a 42.50)
(define metadata (make-c-bytevector (c-type-size c-int)))
(c-bytevector-set! metadata c-int 0 100)
(c-bytevector-set! green color 'metadata metadata)

(write (c-bytevector->list green color))
(newline)

(define md (c-bytevector-ref green color 'metadata))
(write md)
(newline)

(write (c-bytevector-ref md c-int 0))
(newline)

;(define c-int-array (make-c-array-type 'array c-int))
;(define ar1 (make-c-bytevector (* (c-type-size c-int-array) 10)))
;(c-bytevector-set! art1 c-int-array 5 25) ; Multiply the 5 by the size of arrays type

;(test-end "define-c-struct")
