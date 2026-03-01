(define-record-type <c-integer-type>
  (internal-make-c-integer-type name size align signed?)
  c-integer-type?
  (name c-integer-type-name)
  (size c-integer-type-size)
  (align c-integer-type-align)
  (signed? c-integer-type-signed?))

(define-record-type <c-float-type>
  (internal-make-c-float-type name size align)
  c-float-type?
  (name c-float-type-name)
  (size c-float-type-size)
  (align c-float-type-align))

(define-record-type <c-double-type>
  (internal-make-c-double-type name size)
  c-double-type?
  (name c-double-type-name)
  (size c-double-type-size)
  (align c-double-type-align))

(define-record-type <c-pointer-type>
  (internal-make-c-pointer-type name)
  c-pointer-type?
  (name c-pointer-type-name))

#;(define-record-type <c-array-type>
  (internal-make-c-array-type name type)
  c-array-type?
  (name c-array-type-name)
  (type c-array-type-type))

(define-record-type <c-struct-type>
  (internal-make-c-struct-type name size members)
  c-struct-type?
  (name c-struct-type-name)
  (size c-struct-type-size)
  (members c-struct-type-members))

(define (make-c-integer-type name size align signed?)
  (when (not (symbol? name))
    (error "make-c-integer-type: name must be symbol" size))
  (when (not (exact-integer? size))
    (error "make-c-integer-type: size must be exact integer" size))
  (when (not (exact-integer? align))
    (error "make-c-integer-type: align must be exact integer" align))
  (when (not (boolean? signed?))
    (error "make-c-integer-type: signed? must be boolean" signed?))
  (internal-make-c-integer-type name size align signed?))

(define (make-c-float-type name size align)
  (when (not (symbol? name))
    (error "make-c-float-type: name must be symbol" size))
  (when (not (exact-integer? size))
    (error "make-c-float-type: size must be exact integer" size))
  (when (not (exact-integer? align))
    (error "make-c-float-type: align must be exact integer" align))
  (internal-make-c-float-type name size align))

(define (make-c-struct-type name members)
  (when (not (symbol? name))
    (error "make-c-struct-type: name must be symbol" size))
  (when (null? members)
    (error "make-c-struct-type: can not make struct type with no members" members))
  (for-each
    (lambda (memb)
      (when (not (pair? memb))
        (error "meake-c-struct-type: struct members must be pairs" memb))
      (when (not (symbol? (car memb)))
        (error "meake-c-struct-type: struct member car must be symbol" memb))
      (when (not (c-type? (cdr memb)))
        (error "meake-c-struct-type: struct member cdr must be C type" memb)))
    members)
  (internal-make-c-struct-type name
                               (calculate-struct-size members)
                               (calculate-struct-members members)))

(define (c-type? obj)
  (or (c-integer-type? obj)
      (c-float-type? obj)
      (c-double-type? obj)
      (c-pointer-type? obj)
      (c-struct-type? obj)))

(define (c-type-size type)
  (cond
    ((c-integer-type? type) (c-integer-type-size type))
    ((c-float-type? type) (c-float-type-size type))
    ((c-struct-type? type) (c-struct-type-size type))
    (else (error "c-type-size: argument must be C type" type))))

(define (c-type-size=? type-a type-b)
  (when (not (c-type? type-a)) (error "c-type-size=?: type-a must be C type"))
  (when (not (c-type? type-b)) (error "c-type-size=?: type-b must be C type"))
  (= (c-type-size type) (c-type-size type)))

(define (c-type-align type)
  (cond
    ((c-integer-type? type)
     (c-integer-type-align type))
    ((c-struct-type? type)
     (error "c-type-size: c-struct-types do not have align" type))
    (else (error "c-type-size: argument must be C type" type))))


