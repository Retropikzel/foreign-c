(define (type->native-type scheme-name type argument?)
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
            (error "define-c-procedure: Invalid return type" scheme-name type)))))

(define (shared-object-load path options)
  (sagittarius-open-shared-library path))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let
           ((internal
              (sagittarius-make-c-function shared-object
                                           (type->native-type scheme-name return-type #f)
                                           c-name
                                           (map (lambda (type)
                                                  (type->native-type scheme-name type #t))
                                                argument-types))))
           (if (c-pointer-type? return-type)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define c-u8-set! sagittarius-pointer-set-c-uint8_t!)
(define c-u8-ref sagittarius-pointer-ref-c-uint8_t)
(define c-pointer-set! sagittarius-pointer-set-c-pointer!)
(define c-pointer-ref sagittarius-pointer-ref-c-pointer)

(define c-null sagittarius-empty-pointer)
(define c-null? sagittarius-null-pointer?)


