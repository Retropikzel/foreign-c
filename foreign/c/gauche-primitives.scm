(define (primitives-init set-procedure get-procedure) #t)

(define shared-object-load
  (lambda (path options)
    (if (null? options)
      (open-shared-library path)
      (open-shared-library path (cadr (assoc 'additional-versions options))))))

(define type->native-type
  (lambda (type)
    (cond ((equal? type 'i8) 'int8)
          ((equal? type 'u8) 'uint8)
          ((equal? type 'i16) 'int16)
          ((equal? type 'u16) 'uint16)
          ((equal? type 'i32) 'int32)
          ((equal? type 'u32) 'uint32)
          ((equal? type 'i64) 'int64)
          ((equal? type 'u64) 'uint64)
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
          ((equal? type 'pointer) 'pointer)
          ((equal? type 'void) 'pointer)
          ((equal? type 'callback) 'callback)
          (else #f))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (type->native-type return-type)
                        c-name
                        (map type->native-type argument-types))))))

(define c-bytevector?
  (lambda (object)
    (pointer? object)))

(define c-bytevector-u8-set! pointer-set-c-uint8!)
(define c-bytevector-u8-ref pointer-ref-c-uint8)
(define c-bytevector-pointer-set! pointer-set-c-pointer!)
(define c-bytevector-pointer-ref pointer-ref-c-pointer)
(define make-c-null null-pointer)
(define c-null? null-pointer?)


