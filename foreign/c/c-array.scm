(define-record-type <c-array-type>
  (internal-make-c-array-type name type)
  c-array-type?
  (name c-array-type-name)
  (type c-array-type-type))

(define-syntax define-c-array-type
  (syntax-rules ()
    ((_ name type)
     (define name (internal-make-c-array-type 'name type)))))

(define (internal-array-type-size type)
  (c-type-size (c-array-type-type type)))
