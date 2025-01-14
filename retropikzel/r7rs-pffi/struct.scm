(define-record-type <pffi-struct>
  (pffi-struct-make name size pointer members)
  pffi-struct?
  (name pffi-struct-name)
  (size pffi-struct-size)
  (pointer pffi-struct-pointer)
  (members pffi-struct-members))

(define pffi-align-of
  (lambda (type)
    (cond-expand
      (guile (alignof (pffi-type->native-type type)))
      (else (pffi-size-of type)))))

(define (round-to-next-modulo-of to-round roundee)
  (if (= (floor-remainder to-round roundee) 0)
    to-round
    (round-to-next-modulo-of (+ to-round 1) roundee)))

(define (calculate-struct-size types)
  (cond-expand
    (guile (sizeof (map pffi-type->native-type types)))
    (else
      (let ((size 0))
        (for-each
          (lambda (type)
            (let ((type-alignment (pffi-align-of type)))
              (if (or (= size 0)
                      (= (floor-remainder size type-alignment) 0))
                (set! size (+ size type-alignment))
                (set! size (+ (round-to-next-modulo-of size type-alignment) type-alignment)))))
          types)
        size))))

(define pffi-word-size
  (cond-expand
    (larceny 4) ; 32-bit system
    (else 8))) ; 64-bit system

(define (pffi-struct-allocate name members)
  (let* ((size (calculate-struct-size (map car members)))
         (pointer (pffi-pointer-allocate size)))
    (pffi-struct-make name size pointer members)))
