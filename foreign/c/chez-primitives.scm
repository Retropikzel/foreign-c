(define-syntax type->native-type
  (syntax-rules ()
    ((_ type)
     (cond ((equal? type 'int8) 'integer-8)
           ((equal? type 'uint8) 'unsigned-8)
           ((equal? type 'int16) 'integer-16)
           ((equal? type 'uint16) 'unsigned-16)
           ((equal? type 'int32) 'integer-32)
           ((equal? type 'uint32) 'unsigned-32)
           ((equal? type 'int64) 'integer-64)
           ((equal? type 'uint64) 'unsigned-64)
           ((equal? type 'char) 'char)
           ((equal? type 'unsigned-char) 'unsigned-8)
           ((equal? type 'short) 'short)
           ((equal? type 'unsigned-short) 'unsigned-short)
           ((equal? type 'int) 'int)
           ((equal? type 'unsigned-int) 'unsigned-int)
           ((equal? type 'long) 'long)
           ((equal? type 'unsigned-long) 'unsigned-long)
           ((equal? type 'float) 'float)
           ((equal? type 'double) 'double)
           ((equal? type 'pointer) 'void*)
           ((equal? type 'void) 'void*)
           ((equal? type 'callback) 'void*)
           (error "Unsupported type: " type)))))

(define c-bytevector?
  (lambda (object)
    (ftype-pointer? object)))

#;(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (foreign-procedure #f
                          (symbol->string c-name)
                          (map type->native-type argument-types)
                          (type->native-type return-type))))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (foreign-procedure #f
                          (symbol->string c-name)
                          (map type->native-type argument-types)
                          (type->native-type return-type))))))

(define-syntax define-c-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (function-ptr procedure
                     (_cprocedure
                       (mlist->list (map type->native-type argument-types))
                       (type->native-type return-type)))))))

(define size-of-type
  (lambda (type)
    (foreign-sizeof (type->native-type type))))

(define align-of-type
  (lambda (type)
    (foreign-alignof (type->native-type type))))

(define shared-object-load
  (lambda (path options)
    (load-shared-object path)))

(define c-bytevector-u8-set!
  (lambda (c-bytevector k byte)
    #t
    ;(ptr-set! c-bytevector _uint8 'abs k byte)
    ))

(define c-bytevector-u8-ref
  (lambda (c-bytevector k)
    #t
    ;(ptr-ref c-bytevector _uint8 'abs k)
    ))

(define c-bytevector-pointer-set!
  (lambda (c-bytevector k pointer)
    #t
    ;(ptr-set! c-bytevector _pointer 'abs k pointer)
    ))

(define c-bytevector-pointer-ref
  (lambda (c-bytevector k)
    #t
    ;(ptr-ref c-bytevector _pointer 'abs k)
    ))

