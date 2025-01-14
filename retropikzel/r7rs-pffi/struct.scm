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

(define (calculate-struct-size-and-offsets members)
  (let* ((size 0)
         (largest-member-size 0)
         (offsets (map (lambda (member)
                         (let* ((name (cdr member))
                                (type (car member))
                                (type-alignment (pffi-align-of type)))
                           (when (> (pffi-size-of type) largest-member-size)
                             (set! largest-member-size (pffi-size-of type)))
                           (if (or (= size 0)
                                   (= (floor-remainder size type-alignment) 0))
                             (begin
                               (set! size (+ size type-alignment))
                               (list name type (- size type-alignment)))
                             (begin
                               (set! size (+ (round-to-next-modulo-of size type-alignment)
                                             type-alignment))
                               (list name
                                     type
                                     (round-to-next-modulo-of size type-alignment))))))
                       members)))
    (list (cons 'size
                (cond-expand
                  (guile (sizeof (map pffi-type->native-type (map car members))))
                  (else
                    (if (= (modulo size largest-member-size) 0)
                      size
                      (round-to-next-modulo-of size largest-member-size)))))
          (cons 'offsets offsets))))

(define pffi-word-size
  (cond-expand
    (larceny 4) ; 32-bit system
    (else 8))) ; 64-bit system

(define (pffi-struct-allocate name members)
  (let* ((size-and-offsets (calculate-struct-size-and-offsets members))
         (size (cdr (assoc 'size size-and-offsets)))
         (offsets (cdr (assoc 'offsets size-and-offsets)))
         (pointer (pffi-pointer-allocate size)))
    (write size-and-offsets)
    (newline)
    (pffi-struct-make name size pointer members)))
