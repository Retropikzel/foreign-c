(define-record-type <pffi-struct>
  (struct-make c-type size pointer members)
  pffi-struct?
  (c-type pffi-struct-c-type)
  (size pffi-struct-size)
  (pointer pffi-struct-pointer)
  (members pffi-struct-members))

(define-syntax pffi-define-struct
  (syntax-rules ()
    ((_ name c-type members)
     (define name
       (lambda arguments
         (let* ((size-and-offsets (calculate-struct-size-and-offsets members))
                (size (cdr (assoc 'size size-and-offsets)))
                (offsets (cdr (assoc 'offsets size-and-offsets)))
                (pointer (if (and (not (null? arguments))
                                  (pffi-pointer? (car arguments)))
                           (car arguments)
                           (pffi-pointer-allocate size)))
                (c-type-string (if (string? c-type) c-type (symbol->string c-type))))
           (struct-make c-type-string size pointer offsets)))))))

(define pffi-struct-dereference
  (lambda (struct)
    (let ((pointer (pffi-pointer-allocate (pffi-struct-size struct)))
          (offset 0))
      (for-each
        (lambda (struct-member)
          (let* ((member-type (cadr struct-member))
                 (member-name (car struct-member))
                 (member-size (pffi-size-of member-type)))
            (display "HERE: ")
            (write member-size)
            (newline)
            (pffi-pointer-set! pointer
                               member-type
                               offset
                               (pffi-struct-get struct member-name))
            (set! offset (+ offset member-size))))
        (pffi-struct-members struct))
    ;(pffi-pointer-get (pffi-struct-pointer struct) 'pointer 0)
    ;(pffi-pointer-get pointer 'pointer 0)
    pointer
    )))

(define pffi-align-of
  (lambda (type)
    (cond-expand
      ;(guile (alignof (pffi-type->native-type type)))
      (else (size-of-type type)))))

(define round-to-next-modulo-of
  (lambda (to-round roundee)
    (if (= (floor-remainder to-round roundee) 0)
      to-round
      (round-to-next-modulo-of (+ to-round 1) roundee))))

(define calculate-struct-size-and-offsets
  (lambda (members)
    (let* ((size 0)
           (largest-member-size 0)
           (offsets (map (lambda (member)
                           (let* ((name (cdr member))
                                  (type (car member))
                                  (type-alignment (pffi-align-of type)))
                             (when (> (size-of-type type) largest-member-size)
                               (set! largest-member-size (size-of-type type)))
                             (if (or (= size 0)
                                     (= (floor-remainder size type-alignment) 0))
                               (begin
                                 (set! size (+ size type-alignment))
                                 (list name type (- size type-alignment)))
                               (let ((next-alignment (round-to-next-modulo-of size type-alignment)))
                                 (set! size (+ next-alignment type-alignment))
                                 (list name
                                       type
                                       next-alignment)))))
                         members)))
      (list (cons 'size
                  (cond-expand
                    ;(guile (sizeof (map pffi-type->native-type (map car members))))
                    (else
                      (if (= (modulo size largest-member-size) 0)
                        size
                        (round-to-next-modulo-of size largest-member-size)))))
            (cons 'offsets offsets)))))

#;(define pffi-struct-make
  (lambda (c-type members . pointer)
  (for-each
    (lambda (member)
      (when (not (pair? member))
        (error "All struct members must be pairs" (list c-type member)))
      (when (not (symbol? (car member)))
        (error "All struct member types must be symbols" (list c-type member)))
      (when (not (symbol? (cdr member)))
        (error "All struct member names must be symbols" (list c-type member))))
    members)
  (let* ((size-and-offsets (calculate-struct-size-and-offsets members))
         (size (cdr (assoc 'size size-and-offsets)))
         (offsets (cdr (assoc 'offsets size-and-offsets)))
         (pointer (if (null? pointer) (pffi-pointer-allocate size) (car pointer)))
         (c-type (if (string? c-type) c-type (symbol->string c-type))))
    (struct-make c-type size pointer offsets))))

(define (pffi-struct-offset-get struct member-name)
  (when (not (assoc member-name (pffi-struct-members struct)))
    (error "Struct has no such member" (list struct member-name)))
  (car (cdr (cdr (assoc member-name (pffi-struct-members struct))))))

(define (pffi-struct-get struct member-name)
  (when (not (assoc member-name (pffi-struct-members struct)))
    (error "Struct has no such member" (list struct member-name)))
  (let ((type (car (cdr (assoc member-name (pffi-struct-members struct)))))
        (offset (car (cdr (cdr (assoc member-name (pffi-struct-members struct)))))))
    (map display (list "type: " type
                       ", offset: " offset
                       ", value: " (pffi-pointer-get (pffi-struct-pointer struct) type offset)
                       #\newline))
    (pffi-pointer-get (pffi-struct-pointer struct) type offset)))

(define (pffi-struct-set! struct member-name value)
  (when (not (assoc member-name (pffi-struct-members struct)))
    (error "Struct has no such member" (list struct member-name)))
  (let ((type (car (cdr (assoc member-name (pffi-struct-members struct)))))
        (offset (car (cdr (cdr (assoc member-name (pffi-struct-members struct)))))))
    (pffi-pointer-set! (pffi-struct-pointer struct) type offset value)))
