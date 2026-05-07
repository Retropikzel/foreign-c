(define (shared-object-load path options) path)

(define-syntax define-c-procedure
  (gauche-er-macro-transformer
    (lambda (expr rename compare)
      (let* ((type->native-type
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
                       ((equal? type 'ushort) 'u_short)
                       ((equal? type 'int) 'int)
                       ((equal? type 'uint) 'u_int)
                       ((equal? type 'long) 'long)
                       ((equal? type 'ulong) 'u_long)
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
             (scheme-name (list-ref expr 1))
             (shared-object (list-ref expr 2))
             (c-name (cadr (list-ref expr 3)))
             (return-type (cadr (list-ref expr 4)))
             (native-return-type (type->native-type scheme-name return-type #f))
             (argument-types (if (null? (list-ref expr 5))
                               (list)
                               (cadr (list-ref expr 5))))
             (native-argument-types (map (lambda (type)
                                           (type->native-type scheme-name type #t))
                                         argument-types)))
        `(gauche-with-ffi
           (gauche-dynamic-load ,shared-object gauche-:init-function #f)
           '()
           (define-c-function ,c-name ',native-argument-types ',native-return-type)
           (define ,scheme-name
             (lambda args
               (if (equal? (quote ,native-return-type) 'void*)
                 (internal-make-c-bytevector (apply ,c-name (map argument->native-value args)))
                 (apply ,c-name (map argument->native-value args))))))
        ))))


(define type-uint8_t* (gauche-make-c-pointer-type (gauche-native-type 'uint8_t)))
(define (c-u8-set! pointer offset value)
  (set! (gauche-native-aref pointer offset type-uint8_t*) value))

(define (c-u8-ref pointer offset)
  (gauche-native-aref pointer offset type-uint8_t*))

(define type-void* (gauche-make-c-pointer-type (gauche-native-type 'void*)))
(define (c-pointer-set! pointer offset value)
  (set! (gauche-native* (gauche-cast-handle type-void* pointer offset) type-void*) value))

(define (c-pointer-ref pointer offset)
  (gauche-native* (gauche-cast-handle type-void* pointer offset)))

#;(define (c-pointer-set! pointer offset value)
  (c-bytevector-uint-set! (internal-make-c-bytevector pointer)
                          offset
                          (c-memset-pointer->address value 0 0)
                          (c-type-size 'pointer)))

#;(define (c-pointer-ref pointer offset)
  (c-memset-address->pointer
    (c-bytevector-uint-ref (internal-make-c-bytevector pointer)
                           offset
                           (c-type-size 'pointer))
    0
    0))


(define (c-null) (gauche-null-pointer-handle type-void*))
(define (c-null? pointer) (gauche-null-pointer-handle? pointer))


