(define type->native-type
  (lambda (scheme-name type argument?)
    (cond ((equal? type 'i8) racket-_byte)
          ((equal? type 'u8) racket-_ubyte)
          ((equal? type 'i16) racket-_int16)
          ((equal? type 'u16) racket-_uint16)
          ((equal? type 'i32) racket-_int32)
          ((equal? type 'u32) racket-_uint32)
          ((equal? type 'i64) racket-_int64)
          ((equal? type 'u64) racket-_uint64)
          ((equal? type 'char) racket-_int8)
          ((equal? type 'uchar) racket-_uint8)
          ((equal? type 'short) racket-_short)
          ((equal? type 'ushort) racket-_ushort)
          ((equal? type 'int) racket-_int)
          ((equal? type 'uint) racket-_uint)
          ((equal? type 'long) racket-_long)
          ((equal? type 'ulong) racket-_ulong)
          ((equal? type 'float) racket-_float)
          ((equal? type 'double) racket-_double)
          ((equal? type 'pointer) racket-_pointer)
          ((equal? type 'array) racket-_pointer)
          ((equal? type 'struct) racket-_pointer)
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" scheme-name type)
             racket-_void))
          (else
            (if argument?
              (error "define-c-procedure: Invalid argument type" scheme-name type)
              (error "define-c-procedure: Invalid return type" scheme-name type))))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal (racket-get-ffi-obj c-name
                                      shared-object
                                      (racket-_cprocedure
                                        (if (null? argument-types)
                                          (list)
                                          (racket-mlist->list
                                            (map (lambda (type)
                                                   (type->native-type scheme-name type #t))
                                                 argument-types)))
                                        (type->native-type scheme-name return-type #f)))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))


(define shared-object-load
  (lambda (path options)
    (if (and (not (null? options))
             (assoc 'additional-versions options))
      (racket-ffi-lib path
                      (racket-mlist->list
                        (append (cadr (assoc 'additional-versions
                                             options))
                                (list #f))))
      (racket-ffi-lib path))))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    (racket-ptr-set! c-bytevector racket-_uint8 'abs k byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (racket-ptr-ref c-bytevector racket-_uint8 'abs k)))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (racket-ptr-set! c-bytevector racket-_pointer 'abs k pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (racket-ptr-ref c-bytevector racket-_pointer 'abs k)))

(define (c-null) #f)
(define (c-null? pointer) (equal? pointer #f))

