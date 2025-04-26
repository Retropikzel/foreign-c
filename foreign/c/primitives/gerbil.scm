(define pffi-type->native-type
  (lambda (type)
    (error "Not defined")))

(define c-bytevector?
  (lambda (object)
    (error "Not defined")))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (error "Not defined"))))

(define size-of-type
  (lambda (type)
    (error "Not defined")))

(define pffi-shared-object-load
  (lambda (header path)
    (error "Not defined")))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (let ((p pointer))
      (error "Not defined"))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (error "Not defined")))
