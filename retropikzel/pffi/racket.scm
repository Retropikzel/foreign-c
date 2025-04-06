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
          ((equal? type 'string) _pointer)
          ((equal? type 'struct) _pointer)
          (else #f))))

(define pffi-pointer?
  (lambda (object)
    (cpointer? object)))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (get-ffi-obj c-name
                    shared-object
                    (_cprocedure (mlist->list (map pffi-type->native-type argument-types))
                                 (pffi-type->native-type return-type)))))))

(define-syntax pffi-define-callback
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

#;(define pffi-pointer-allocate
  (lambda (size)
    (malloc 'raw size)))

(define pffi-pointer-address
  (lambda (pointer)
    pointer))

(define pffi-pointer-null
  (lambda ()
    #f )) ; #f is the null pointer on racket

#;(define pffi-string->pointer
  (lambda (string-content)
    (let* ((size (string-length string-content))
           (pointer (pffi-pointer-allocate (+ size 1))))
      (memmove pointer (cast (string-append string-content "") _string _pointer) (+ size 1))
      pointer)))

#;(define pffi-pointer->string
  (lambda (pointer)
    (when (pffi-pointer-null? pointer)
      (error "Can not make string from null pointer" pointer))
    (string-copy (cast pointer _pointer _string))))

(define pffi-shared-object-load
  (lambda (path options)
    (if (and (not (null? options))
             (assoc 'additional-versions options))
      (ffi-lib path (mlist->list (append (cadr (assoc 'additional-versions
                                                      options))
                                         (list #f))))
      (ffi-lib path))))

#;(define pffi-pointer-free
  (lambda (pointer)
    (free pointer)))

(define pffi-pointer-null?
  (lambda (pointer)
    (not pointer))) ; #f is the null pointer on racket

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

#;(define pffi-struct-dereference
  (lambda (struct)
    (pffi-struct-pointer struct)))
