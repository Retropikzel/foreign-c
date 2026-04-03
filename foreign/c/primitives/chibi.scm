(define type->libffi-type-number
  (lambda (type argument?)
    (cond ((equal? type 'i8) 1)
          ((equal? type 'u8) 2)
          ((equal? type 'i16) 3)
          ((equal? type 'u16) 4)
          ((equal? type 'i32) 5)
          ((equal? type 'u32) 6)
          ((equal? type 'i64) 7)
          ((equal? type 'u64) 8)
          ((equal? type 'char) 9)
          ((equal? type 'uchar) 10)
          ((equal? type 'short) 11)
          ((equal? type 'ushort) 12)
          ((equal? type 'int) 13)
          ((equal? type 'uint) 14)
          ((equal? type 'long) 15)
          ((equal? type 'ulong) 16)
          ((equal? type 'float) 17)
          ((equal? type 'double) 18)
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" type)
             '19))
          ((equal? type 'pointer) 20)
          ((equal? type 'array) 20)
          ((equal? type 'struct) 20)
          ((equal? type 'pointer-address) 21)
          (else (error "define-c-procedure: Invalid argument type" type)))))

(define make-c-function
  (lambda (shared-object c-name return-type argument-types)
    (let ((c-function (dlsym shared-object c-name)))
      (lambda arguments
        (let* ((return-pointer
                 (internal-ffi-call (length argument-types)
                                    (type->libffi-type-number return-type #f)
                                    (map
                                      (lambda (type)
                                        (type->libffi-type-number type #t))
                                         argument-types)
                                    c-function
                                    (c-type-size return-type)
                                    (map argument->native-value arguments))))
          (when (not (symbol=? return-type 'void))
            (c-bytevector-ref (internal-make-c-bytevector return-pointer) return-type 0)))))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type)
     (define-c-procedure scheme-name shared-object c-name return-type '()))
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (symbol->string c-name)
                        return-type
                        argument-types)))))

(define shared-object-load
  (lambda (path options)
    (let ((shared-object (dlopen path RTLD-NOW)))
      shared-object)))

(define (c-null) (internal-c-null))

(define (c-null? pointer)
  (or (equal? pointer #f) ;; #f counts as null pointer
      (and (c-bytevector? pointer)
           (internal-c-null? pointer))))

