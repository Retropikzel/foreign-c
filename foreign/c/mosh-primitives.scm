(define type->native-type
  (lambda (scheme-name type argument?)
    (cond ((equal? type 'i8) 'int8_t)
          ((equal? type 'u8) 'uint8_t)
          ((equal? type 'i16) 'int16_t)
          ((equal? type 'u16) 'uint16_t)
          ((equal? type 'i32) 'int32_t)
          ((equal? type 'u32) 'uint32_t)
          ((equal? type 'i64) 'int64_t)
          ((equal? type 'u64) 'uint64_t)
          ((equal? type 'char) 'char)
          ((equal? type 'uchar) 'char)
          ((equal? type 'short) 'short)
          ((equal? type 'ushort) 'unsigned-short)
          ((equal? type 'int) 'int)
          ((equal? type 'uint) 'unsigned-int)
          ((equal? type 'long) 'long)
          ((equal? type 'ulong) 'unsigned-long)
          ((equal? type 'float) 'float)
          ((equal? type 'double) 'double)
          ((equal? type 'pointer) 'void*)
          ((equal? type 'array) 'void*)
          ((equal? type 'struct) 'void*)
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" scheme-name type)
             'void))
          (else
            (if argument?
              (error "define-c-procedure: Invalid argument type" scheme-name type)
              (error "define-c-procedure: Invalid return type" scheme-name type))))))

(define shared-object-load
  (lambda (path options)
    (mosh-open-shared-library path)))

(define c-u8-set! mosh-pointer-set-c-uint8!)
(define c-u8-ref mosh-pointer-ref-c-uint8)
(define c-pointer-set!
  (lambda (pointer offset value)
    (mosh-pointer-set-c-pointer! pointer offset value)))
(define c-pointer-ref
  (lambda (pointer offset)
    (mosh-pointer-ref-c-pointer pointer offset)))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal
                 (mosh-make-c-function shared-object
                                       (type->native-type scheme-name return-type #f)
                                       c-name
                                       (map (lambda (type)
                                              (type->native-type scheme-name type #t))
                                            argument-types))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define (c-null) (mosh-integer->pointer 0))
(define c-null? mosh-pointer-null?)
