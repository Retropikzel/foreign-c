(define (type->native-type scheme-name type argument?)
  (cond ((equal? type 'i8) capy-int8)
        ((equal? type 'u8) capy-uint8)
        ((equal? type 'i16) capy-int16)
        ((equal? type 'u16) capy-uint16)
        ((equal? type 'i32) capy-int32)
        ((equal? type 'u32) capy-uint32)
        ((equal? type 'i64) capy-int64)
        ((equal? type 'u64) capy-uint64)
        ((equal? type 'char) capy-int8)
        ((equal? type 'uchar) capy-uint8)
        ((equal? type 'short) capy-short)
        ((equal? type 'ushort) capy-unsigned-short)
        ((equal? type 'int) capy-int)
        ((equal? type 'uint) capy-unsigned-int)
        ((equal? type 'long) capy-long)
        ((equal? type 'ulong) capy-unsigned-long)
        ((equal? type 'float) capy-float)
        ((equal? type 'double) capy-double)
        ((equal? type 'pointer) '*)
        ((equal? type 'array) '*)
        ((equal? type 'struct) '*)
        ((equal? type 'callback) '*)
        ((equal? type 'void) capy-void)
        (else #f)))

(define c-bytevector?
  (lambda (object)
    (capy-pointer? object)))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal
                 (capy-pointer->procedure
                   (type->native-type scheme-name return-type #f)
                   (capy-foreign-library-pointer shared-object
                                                  (symbol->string c-name))
                   (map (lambda (type)
                          (type->native-type scheme-name type #t))
                        argument-types))))
           (if (c-pointer-type? return-type)
             (internal-make-c-bytevector
               (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define size-of-type
  (lambda (type)
    (let ((native-type (type->native-type 'none type #f)))
      (cond ((equal? native-type void) 0)
            (native-type (sizeof native-type))
            (else #f)))))

(define align-of-type
  (lambda (type)
    (let ((native-type (type->native-type 'none type #f)))
      (cond ((equal? native-type void) 0)
            (native-type (alignof native-type))
            (else #f)))))

(define shared-object-load
  (lambda (path options)
    (capy-load-foreign-library path)))

(define (c-u8-set! cbv offset byte)
  (bytevector-u8-set!
    (capy-pointer->bytevector cbv (+ offset 100)) offset byte))

(define (c-u8-ref cbv offset)
  (bytevector-u8-ref (capy-pointer->bytevector cbv (+ offset 100)) offset))

(define (c-pointer-set! cbv offset pointer)
  (capy-bytevector-u64-native-set!
    (capy-pointer->bytevector cbv (+ offset 100))
    offset
    (capy-pointer-address pointer)))

(define (c-pointer-ref cbv offset)
  (capy-make-pointer (capy-bytevector-u64-native-ref
                        (capy-pointer->bytevector cbv (+ offset 100))
                        offset)))


(define (c-null)
  (internal-make-c-bytevector
    (capy-make-pointer (capy-pointer-address capy-%null-pointer))))

(define (c-null? pointer)
  (and (capy-pointer? pointer)
       (capy-null-pointer? pointer)))

(define-syntax define-c-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (procedure->pointer
         (type->native-type scheme-name return-type #f)
         procedure
         (map (lambda (type)
                (type->native-type scheme-name type #t))
              argument-types))))))
