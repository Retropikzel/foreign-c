(define type->native-type
  (lambda (scheme-name type argument?)
    (cond ((equal? type 'i8) guile-int8)
          ((equal? type 'u8) guile-uint8)
          ((equal? type 'i16) guile-int16)
          ((equal? type 'u16) guile-uint16)
          ((equal? type 'i32) guile-int32)
          ((equal? type 'u32) guile-uint32)
          ((equal? type 'i64) guile-int64)
          ((equal? type 'u64) guile-uint64)
          ((equal? type 'char) guile-int8)
          ((equal? type 'uchar) guile-uint8)
          ((equal? type 'short) guile-short)
          ((equal? type 'ushort) guile-unsigned-short)
          ((equal? type 'int) guile-int)
          ((equal? type 'uint) guile-unsigned-int)
          ((equal? type 'long) guile-long)
          ((equal? type 'ulong) guile-unsigned-long)
          ((equal? type 'float) guile-float)
          ((equal? type 'double) guile-double)
          ((equal? type 'pointer) '*)
          ((equal? type 'array) '*)
          ((equal? type 'struct) '*)
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" scheme-name type)
             'void))
          (else
            (if argument?
              (error "define-c-procedure: Invalid argument type" scheme-name type)
              (error "define-c-procedure: Invalid return type" scheme-name type))))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal (guile-pointer->procedure (type->native-type scheme-name return-type #f)
                                                   (guile-foreign-library-pointer shared-object
                                                                                  (symbol->string c-name))
                                                   (map (lambda (type)
                                                          (type->native-type scheme-name type #t))
                                                        argument-types))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define shared-object-load
  (lambda (path options)
    (guile-load-foreign-library path)))

(define (c-u8-set! cbv offset byte)
  (bytevector-u8-set! (guile-pointer->bytevector cbv (+ offset 100)) offset byte))

(define (c-u8-ref cbv offset)
  (bytevector-u8-ref (guile-pointer->bytevector cbv (+ offset 100)) offset))

(define (c-pointer-set! cbv offset pointer)
  (guile-bytevector-u64-native-set!
    (guile-pointer->bytevector cbv (+ offset 100))
    offset
    (guile-pointer-address pointer)))

(define (c-pointer-ref cbv offset)
  (guile-make-pointer (guile-bytevector-u64-native-ref
                        (guile-pointer->bytevector cbv (+ offset 100))
                        offset)))

(define (c-null) (guile-make-pointer (guile-pointer-address guile-%null-pointer)))

(define (c-null? pointer)
  (and (guile-pointer? pointer)
       (guile-null-pointer? pointer)))
