;(test-begin "define-c-struct")

(define color (make-c-struct-type 'color
                               `((r . ,i8)
                                 (g . ,i8)
                                 (b . ,i8)
                                 (a . ,float)
                                 (metadata . ,pointer)
                                 )))
(write color)
(newline)
(define green (make-c-bytevector (c-type-size color)))
(c-bytevector-set! green color 'r 0)
(c-bytevector-set! green color 'g 42)
(c-bytevector-set! green color 'b 0)
(c-bytevector-set! green color 'a 42.50)
(define metadata (make-c-bytevector (c-type-size i8)))
(c-bytevector-set! metadata i8 0 100)
(c-bytevector-set! green color 'metadata metadata)

(write (c-bytevector->list green color))
(newline)

(define md (c-bytevector-ref green color 'metadata))
(write md)
(newline)

(write (c-bytevector-ref md i8 0))
(newline)

(define i8-array (make-c-array-type 'int-array i8))
(define ar1 (make-c-bytevector (* (c-type-size i8-array) 10)))
(write ar1)
(newline)
(c-bytevector-set! ar1 i8-array 5 25)
(write (c-bytevector-ref ar1 i8-array 5))
(newline)

;(test-end "define-c-struct")
