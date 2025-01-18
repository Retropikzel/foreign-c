(define-record-type <pffi-struct>
  (struct-make name size pointer members)
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
    (i386 4) ; 32-bit system
    (else 8))) ; 64-bit system

(define (pffi-struct-make name members . pointer)
  (for-each
    (lambda (member)
      (write member)
      (newline)
      (when (not (pair? member))
        (error "All struct members must be pairs" (list name member)))
      (when (not (symbol? (car member)))
        (error "All struct member types must be symbols" (list name member)))
      (when (not (symbol? (cdr member)))
        (error "All struct member names must be symbols" (list name member))))
    members)
  (let* ((size-and-offsets (calculate-struct-size-and-offsets members))
         (size (cdr (assoc 'size size-and-offsets)))
         (offsets (cdr (assoc 'offsets size-and-offsets)))
         (pointer (if (null? pointer) (pffi-pointer-allocate size) (car pointer)))
         (name (if (string? name) name (symbol->string name))))
    (struct-make name size pointer offsets)))

(define (pffi-struct-get struct member-name)
  (when (not (assoc member-name (pffi-struct-members struct)))
    (error "Struct has no such member" (list struct member-name)))
  (let ((type (car (cdr (assoc member-name (pffi-struct-members struct)))))
        (offset (car (cdr (cdr (assoc member-name (pffi-struct-members struct)))))))
    (pffi-pointer-get (pffi-struct-pointer struct) type offset)))

(define (pffi-struct-set! struct member-name value)
  (when (not (assoc member-name (pffi-struct-members struct)))
    (error "Struct has no such member" (list struct member-name)))
  (let ((type (car (cdr (assoc member-name (pffi-struct-members struct)))))
        (offset (car (cdr (cdr (assoc member-name (pffi-struct-members struct)))))))
    (pffi-pointer-set! (pffi-struct-pointer struct) type offset value)))
