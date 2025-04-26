(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) _int8)
          ((equal? type 'uint8) _uint8)
          ((equal? type 'int16) _int16)
          ((equal? type 'uint16) _uint16)
          ((equal? type 'int32) _int32)
          ((equal? type 'uint32) _uint32)
          ((equal? type 'int64) _int64)
          ((equal? type 'uint64) _uint64)
          ((equal? type 'char) _int8)
          ((equal? type 'unsigned-char) _uint8)
          ((equal? type 'short) _short)
          ((equal? type 'unsigned-short) _ushort)
          ((equal? type 'int) _int)
          ((equal? type 'unsigned-int) _uint)
          ((equal? type 'long) _long)
          ((equal? type 'unsigned-long) _ulong)
          ((equal? type 'float) _float)
          ((equal? type 'double) _double)
          ((equal? type 'pointer) _pointer)
          ((equal? type 'void) _void)
          ((equal? type 'callback) _pointer)
          (else #f))))

(define c-bytevector?
  (lambda (object)
    (cpointer? object)))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (get-ffi-obj c-name
                    shared-object
                    (_cprocedure (mlist->list (map pffi-type->native-type argument-types))
                                 (pffi-type->native-type return-type)))))))

(define-syntax define-c-callback
  (syntax-rules ()
    ((pffi-define-callback scheme-name return-type argument-types procedure)
     (define scheme-name (function-ptr procedure
                                       (_cprocedure
                                         (mlist->list (map pffi-type->native-type argument-types))
                                         (pffi-type->native-type return-type)))))))

(define size-of-type
  (lambda (type)
    (let ((native-type (pffi-type->native-type type)))
      (if native-type
        (ctype-sizeof native-type)
        #f))))

(define pffi-shared-object-load
  (lambda (path options)
    (if (and (not (null? options))
             (assoc 'additional-versions options))
      (ffi-lib path (mlist->list (append (cadr (assoc 'additional-versions
                                                      options))
                                         (list #f))))
      (ffi-lib path))))

#;(define c-bytevector-u8-set!
  (lambda (c-bytevector k byte)
    (ptr-set! c-bytevector _uint8 'abs k byte)))

(define c-bytevector-u8-ref
  (lambda (c-bytevector k)
    (ptr-ref c-bytevector _uint8 'abs k)))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (ptr-set! pointer
              (pffi-type->native-type type)
              'abs
              offset
              (if (equal? type 'char)
                (char->integer value)
                value))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (let ((r (ptr-ref pointer
                      (pffi-type->native-type type)
                      'abs
                      offset)))
      (if (equal? type 'char)
        (integer->char r)
        r))))
