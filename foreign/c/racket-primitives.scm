(define type->native-type
  (lambda (type)
    (cond ((equal? type 'i8) _byte)
          ((equal? type 'u8) _ubyte)
          ((equal? type 'i16) _int16)
          ((equal? type 'u16) _uint16)
          ((equal? type 'i32) _int32)
          ((equal? type 'u32) _uint32)
          ((equal? type 'i64) _int64)
          ((equal? type 'u64) _uint64)
          ((equal? type 'char) _int8)
          ((equal? type 'uchar) _uint8)
          ((equal? type 'short) _short)
          ((equal? type 'ushort) _ushort)
          ((equal? type 'int) _int)
          ((equal? type 'uint) _uint)
          ((equal? type 'long) _long)
          ((equal? type 'ulong) _ulong)
          ((equal? type 'float) _float)
          ((equal? type 'double) _double)
          ((equal? type 'pointer) _pointer)
          (else #f))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal (racket-get-ffi-obj c-name
                                      shared-object
                                      (racket-_cprocedure (mlist->list (map type->native-type argument-types))
                                                   (type->native-type return-type)))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map value->native-value args)))
             (apply internal (map value->native-value args)))))))))


(define size-of-type
  (lambda (type)
    (racket-ctype-sizeof (type->native-type type))))

;; FIXME
(define align-of-type
  (lambda (type)
    (racket-ctype-sizeof (type->native-type type))))

(define shared-object-load
  (lambda (path options)
    (if (and (not (null? options))
             (assoc 'additional-versions options))
      (racket-ffi-lib path (mlist->list (append (cadr (assoc 'additional-versions
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

