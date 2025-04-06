(define-module retropikzel.pffi.gauche
               (export size-of-type
                       pffi-shared-object-load
                       pffi-pointer-null
                       pffi-pointer-null?
                       pffi-pointer-allocate
                       pffi-pointer-address
                       pffi-pointer?
                       pffi-pointer-free
                       pffi-pointer-set!
                       pffi-pointer-get
                       pffi-string->pointer
                       pffi-pointer->string
                       pffi-define))

(select-module retropikzel.pffi.gauche)
(dynamic-load "retropikzel/pffi/gauche-pffi")

(define size-of-type
  (lambda (type)
    (cond
      ((equal? type 'int8) (size-of-int8))
      ((equal? type 'uint8) (size-of-uint8))
      ((equal? type 'int16) (size-of-int16))
      ((equal? type 'uint16) (size-of-uint16))
      ((equal? type 'int32) (size-of-int32))
      ((equal? type 'uint32) (size-of-uint32))
      ((equal? type 'int64) (size-of-int64))
      ((equal? type 'uint64) (size-of-uint64))
      ((equal? type 'char) (size-of-char))
      ((equal? type 'unsigned-char) (size-of-unsigned-char))
      ((equal? type 'short) (size-of-short))
      ((equal? type 'unsigned-short) (size-of-unsigned-short))
      ((equal? type 'int) (size-of-int))
      ((equal? type 'unsigned-int) (size-of-unsigned-int))
      ((equal? type 'long) (size-of-long))
      ((equal? type 'unsigned-long) (size-of-unsigned-long))
      ((equal? type 'float) (size-of-float))
      ((equal? type 'double) (size-of-double))
      ((equal? type 'string) (size-of-string))
      ((equal? type 'pointer) (size-of-pointer))
      ((equal? type 'void) (size-of-void)))))

(define pffi-shared-object-load
  (lambda (path options)
    (shared-object-load path)))

(define pffi-pointer-null
  (lambda ()
    (pointer-null)))

(define pffi-pointer-null?
  (lambda (pointer)
    (pointer-null? pointer)))

(define pffi-pointer-allocate
  (lambda (size)
    (pointer-allocate size)))

(define pffi-pointer-address
  (lambda (object)
    (pointer-address object)))

(define pffi-pointer?
  (lambda (pointer)
    (pointer? pointer)))

(define pffi-pointer-free
  (lambda (pointer)
    (pointer-free pointer)))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond ((equal? type 'int8) (pointer-set-int8! pointer offset value))
          ((equal? type 'uint8) (pointer-set-uint8! pointer offset value))
          ((equal? type 'int16) (pointer-set-int16! pointer offset value))
          ((equal? type 'uint16) (pointer-set-uint16! pointer offset value))
          ((equal? type 'int32) (pointer-set-int32! pointer offset value))
          ((equal? type 'uint32) (pointer-set-uint32! pointer offset value))
          ((equal? type 'int64) (pointer-set-int64! pointer offset value))
          ((equal? type 'uint64) (pointer-set-uint64! pointer offset value))
          ((equal? type 'char) (pointer-set-char! pointer offset value))
          ((equal? type 'short) (pointer-set-short! pointer offset value))
          ((equal? type 'unsigned-short) (pointer-set-unsigned-short! pointer offset value))
          ((equal? type 'int) (pointer-set-int! pointer offset value))
          ((equal? type 'unsigned-int) (pointer-set-unsigned-int! pointer offset value))
          ((equal? type 'long) (pointer-set-long! pointer offset value))
          ((equal? type 'unsigned-long) (pointer-set-unsigned-long! pointer offset value))
          ((equal? type 'float) (pointer-set-float! pointer offset value))
          ((equal? type 'double) (pointer-set-double! pointer offset value))
          ((equal? type 'void) (pointer-set-pointer! pointer offset value))
          ((equal? type 'pointer) (pointer-set-pointer! pointer offset value)))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond ((equal? type 'int8) (pointer-get-int8 pointer offset))
          ((equal? type 'uint8) (pointer-get-uint8 pointer offset))
          ((equal? type 'int16) (pointer-get-int16 pointer offset))
          ((equal? type 'uint16) (pointer-get-uint16 pointer offset))
          ((equal? type 'int32) (pointer-get-int32 pointer offset))
          ((equal? type 'uint32) (pointer-get-uint32 pointer offset))
          ((equal? type 'int64) (pointer-get-int64 pointer offset))
          ((equal? type 'uint64) (pointer-get-uint64 pointer offset))
          ((equal? type 'char) (integer->char (pointer-get-char pointer offset)))
          ((equal? type 'short) (pointer-get-short pointer offset))
          ((equal? type 'unsigned-short) (pointer-get-unsigned-short pointer offset))
          ((equal? type 'int) (pointer-get-int pointer offset))
          ((equal? type 'unsigned-int) (pointer-get-unsigned-int pointer offset))
          ((equal? type 'long) (pointer-get-long pointer offset))
          ((equal? type 'unsigned-long) (pointer-get-unsigned-long pointer offset))
          ((equal? type 'float) (pointer-get-float pointer offset))
          ((equal? type 'double) (pointer-get-double pointer offset))
          ((equal? type 'void) (pointer-get-pointer pointer offset))
          ((equal? type 'pointer) (pointer-get-pointer pointer offset)))))

(define pffi-type->libffi-type
  (lambda (type)
    (cond ((equal? type 'int8) (get-ffi-type-int8))
          ((equal? type 'uint8) (get-ffi-type-uint8))
          ((equal? type 'int16) (get-ffi-type-int16))
          ((equal? type 'uint16) (get-ffi-type-uint16))
          ((equal? type 'int32) (get-ffi-type-int32))
          ((equal? type 'uint32) (get-ffi-type-uint32))
          ((equal? type 'int64) (get-ffi-type-int64))
          ((equal? type 'uint64) (get-ffi-type-uint64))
          ((equal? type 'char) (get-ffi-type-char))
          ((equal? type 'unsigned-char) (get-ffi-type-uchar))
          ((equal? type 'bool) (get-ffi-type-int8))
          ((equal? type 'short) (get-ffi-type-short))
          ((equal? type 'unsigned-short) (get-ffi-type-ushort))
          ((equal? type 'int) (get-ffi-type-int))
          ((equal? type 'unsigned-int) (get-ffi-type-uint))
          ((equal? type 'long) (get-ffi-type-long))
          ((equal? type 'unsigned-long) (get-ffi-type-ulong))
          ((equal? type 'float) (get-ffi-type-float))
          ((equal? type 'double) (get-ffi-type-double))
          ((equal? type 'void) (get-ffi-type-void))
          ((equal? type 'pointer) (get-ffi-type-pointer))
          ((equal? type 'callback) (get-ffi-type-pointer)))))

(define argument->pointer
  (lambda (value type)
    (cond ((procedure? value) (scheme-procedure-to-pointer value))
          (else (let ((pointer (pffi-pointer-allocate (size-of-type type))))
                  (pffi-pointer-set! pointer type 0 value)
                  pointer)))))

(define make-c-function
  (lambda (shared-object c-name return-type argument-types)
    (dlerror) ;; Clean all previous errors
    (let ((c-function (dlsym shared-object c-name))
          (maybe-dlerror (dlerror)))
      (when (not (pffi-pointer-null? maybe-dlerror))
        (error (pffi-pointer->string maybe-dlerror)))
      (lambda arguments
        (let ((return-value (pffi-pointer-allocate
                              (if (equal? return-type 'void)
                                0
                                (size-of-type return-type)))))
          (internal-ffi-call (length argument-types)
                             (pffi-type->libffi-type return-type)
                             (map pffi-type->libffi-type argument-types)
                             c-function
                             return-value
                             (map argument->pointer
                                  arguments
                                  argument-types))
          (cond ((not (equal? return-type 'void))
                 (pffi-pointer-get return-value return-type 0))))))))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (symbol->string c-name)
                        return-type
                        argument-types)))))

(define make-c-callback
  (lambda (return-type argument-types procedure)
    (scheme-procedure-to-pointer procedure)))

(define-syntax pffi-define-callback
  (syntax-rules ()
    ((pffi-define scheme-name return-type argument-types procedure)
     (define scheme-name
       (make-c-callback return-type 'argument-types procedure)))))
