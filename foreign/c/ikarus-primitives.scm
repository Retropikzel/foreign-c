(define (type->native-type scheme-name type argument?)
  (cond ((equal? type 'i8) 'signed-char)
        ((equal? type 'u8) 'unsigned-char)
        ((equal? type 'i16) 'signed-short)
        ((equal? type 'u16) 'unsigned-short)
        ((equal? type 'i32) 'signed-int)
        ((equal? type 'u32) 'unsigned-int)
        ((equal? type 'i64) 'signed-long)
        ((equal? type 'u64) 'unsigned-long)
        ((equal? type 'char) 'signed-char)
        ((equal? type 'uchar) 'unsigned-char)
        ((equal? type 'short) 'signed-short)
        ((equal? type 'ushort) 'unsigned-short)
        ((equal? type 'int) 'signed-int)
        ((equal? type 'unsigned-int) 'unsigned-int)
        ((equal? type 'long) 'signed-long)
        ((equal? type 'ulong) 'unsigned-long)
        ((equal? type 'float) 'float)
        ((equal? type 'double) 'double)
        ((equal? type 'pointer) 'pointer)
        ((equal? type 'array) 'pointer)
        ((equal? type 'struct) 'pointer)
        ((equal? type 'void)
         (if argument?
           (error "define-c-procedure: Argument type can not be void" scheme-name type)
           'void))
        (else
          (if argument?
            (error "define-c-procedure: Invalid argument type" scheme-name type)
            (error "define-c-procedure: Invalid return type" scheme-name type)))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal
                 ((ikarus-make-c-callout (type->native-type 'scheme-name return-type #f)
                                  (map (lambda (type)
                                         (type->native-type 'scheme-name type #t))
                                       argument-types))
                  (ikarus-dlsym shared-object (symbol->string c-name)))))
           (if (c-pointer-type? return-type)
             (internal-make-c-bytevector (apply internal (map value->native-value args)))
             (apply internal (map value->native-value args)))))))))

(define shared-object-load
  (lambda (path options)
    (ikarus-dlopen path)))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    (ikarus-pointer-set-c-char! c-bytevector k byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (ikarus-pointer-ref-c-unsigned-char c-bytevector k)))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (ikarus-pointer-set-c-pointer! c-bytevector k pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (ikarus-pointer-ref-c-pointer c-bytevector k)))

(define (c-null) (ikarus-integer->pointer 0))

(define (c-null? pointer)
  (and (ikarus-pointer? pointer)
       (= (ikarus-pointer->integer pointer) 0)))
