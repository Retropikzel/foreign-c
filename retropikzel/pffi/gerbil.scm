(define pffi-type->native-type
  (lambda (type)
    (error "Not defined")))

(define pffi-pointer?
  (lambda (object)
    (error "Not defined")))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (error "Not defined"))))

(define size-of-type
  (lambda (type)
    (error "Not defined")))

(define pffi-pointer-allocate
  (lambda (size)
    (error "Not defined")))

(define pffi-pointer-null
  (lambda ()
    (error "Not defined")))

#;(define pffi-string->pointer
  (lambda (string-content)
    (error "Not defined")))

#;(define pffi-pointer->string
  (lambda (pointer)
    pointer))

(define pffi-shared-object-load
  (lambda (header path)
    (error "Not defined")))

(define pffi-pointer-free
  (lambda (pointer)
    (error "Not defined")))

(define pffi-pointer-null?
  (lambda (pointer)
    (error "Not defined")))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (let ((p pointer))
      (error "Not defined"))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (error "Not defined")))

(define pffi-pointer-deref
  (lambda (pointer)
    (error "Not defined")))
