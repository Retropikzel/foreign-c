(define size-of-type
  (lambda (type)
    (cond ((eq? type 'int8) (size-of-int8_t))
          ((eq? type 'uint8) (size-of-uint8_t))
          ((eq? type 'int16) (size-of-int16_t))
          ((eq? type 'uint16) (size-of-uint16_t))
          ((eq? type 'int32) (size-of-int32_t))
          ((eq? type 'uint32) (size-of-uint32_t))
          ((eq? type 'int64) (size-of-int64_t))
          ((eq? type 'uint64) (size-of-uint64_t))
          ((eq? type 'char) (size-of-char))
          ((eq? type 'unsigned-char) (size-of-char))
          ((eq? type 'short) (size-of-short))
          ((eq? type 'unsigned-short) (size-of-unsigned-short))
          ((eq? type 'int) (size-of-int))
          ((eq? type 'unsigned-int) (size-of-unsigned-int))
          ((eq? type 'long) (size-of-long))
          ((eq? type 'unsigned-long) (size-of-unsigned-long))
          ((eq? type 'float) (size-of-float))
          ((eq? type 'double) (size-of-double))
          ((eq? type 'pointer) (size-of-pointer))
          ((eq? type 'string) (size-of-pointer))
          ((eq? type 'struct) (size-of-pointer))
          ((eq? type 'callback) (size-of-pointer))
          ((eq? type 'void) 0)
          (else #f))))

(define pffi-shared-object-load
  (lambda (path options)
    (let ((shared-object (dlopen path RTLD-NOW))
          (maybe-error (dlerror)))
      (when (not (pffi-pointer-null? maybe-error))
        (error (pffi-pointer->string maybe-error)))
      shared-object)))

(define pffi-pointer-null
  (lambda ()
    (pointer-null)))

(define pffi-pointer-null?
  (lambda (pointer)
    (not pointer))) ; #f is null on Chibi

(define pffi-pointer?
  (lambda (object)
    (or (equal? object #f) ; False can be null pointer
    (pointer? object))))

(define pffi-pointer-allocate
  (lambda (size)
    (pointer-allocate size)))

(define pffi-pointer-address
  (lambda (pointer)
    (pointer-address pointer)))

(define pffi-pointer-free
  (lambda (pointer)
    (pointer-free pointer)))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond ((equal? type 'int8) (pointer-set-c-int8_t! pointer offset value))
          ((equal? type 'uint8) (pointer-set-c-uint8_t! pointer offset value))
          ((equal? type 'int16) (pointer-set-c-int16_t! pointer offset value))
          ((equal? type 'uint16) (pointer-set-c-uint16_t! pointer offset value))
          ((equal? type 'int32) (pointer-set-c-int32_t! pointer offset value))
          ((equal? type 'uint32) (pointer-set-c-uint32_t! pointer offset value))
          ((equal? type 'int64) (pointer-set-c-int64_t! pointer offset value))
          ((equal? type 'uint64) (pointer-set-c-uint64_t! pointer offset value))
          ((equal? type 'char) (pointer-set-c-char! pointer offset value))
          ((equal? type 'short) (pointer-set-c-short! pointer offset value))
          ((equal? type 'unsigned-short) (pointer-set-c-unsigned-short! pointer offset value))
          ((equal? type 'int) (pointer-set-c-int! pointer offset value))
          ((equal? type 'unsigned-int) (pointer-set-c-unsigned-int! pointer offset value))
          ((equal? type 'long) (pointer-set-c-long! pointer offset value))
          ((equal? type 'unsigned-long) (pointer-set-c-unsigned-long! pointer offset value))
          ((equal? type 'float) (pointer-set-c-float! pointer offset value))
          ((equal? type 'double) (pointer-set-c-double! pointer offset value))
          ((equal? type 'void) (pointer-set-c-pointer! pointer offset value))
          ((equal? type 'pointer) (pointer-set-c-pointer! pointer offset value)))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond ((equal? type 'int8) (pointer-ref-c-int8_t pointer offset))
          ((equal? type 'uint8) (pointer-ref-c-uint8_t pointer offset))
          ((equal? type 'int16) (pointer-ref-c-int16_t pointer offset))
          ((equal? type 'uint16) (pointer-ref-c-uint16_t pointer offset))
          ((equal? type 'int32) (pointer-ref-c-int32_t pointer offset))
          ((equal? type 'uint32) (pointer-ref-c-uint32_t pointer offset))
          ((equal? type 'int64) (pointer-ref-c-int64_t pointer offset))
          ((equal? type 'uint64) (pointer-ref-c-uint64_t pointer offset))
          ((equal? type 'char) (pointer-ref-c-char pointer offset))
          ((equal? type 'short) (pointer-ref-c-short pointer offset))
          ((equal? type 'unsigned-short) (pointer-ref-c-unsigned-short pointer offset))
          ((equal? type 'int) (pointer-ref-c-int pointer offset))
          ((equal? type 'unsigned-int) (pointer-ref-c-unsigned-int pointer offset))
          ((equal? type 'long) (pointer-ref-c-long pointer offset))
          ((equal? type 'unsigned-long) (pointer-ref-c-unsigned-long pointer offset))
          ((equal? type 'float) (pointer-ref-c-float pointer offset))
          ((equal? type 'double) (pointer-ref-c-double pointer offset))
          ((equal? type 'void) (pointer-ref-c-pointer pointer offset))
          ((equal? type 'pointer) (pointer-ref-c-pointer pointer offset)))))

#;(define pffi-string->pointer
  (lambda (string-content)
    (string-to-pointer string-content)))

#;(define pffi-pointer->string
  (lambda (pointer)
    (pointer-to-string pointer)))

(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) 'int8_t)
          ((equal? type 'uint8) 'uint8_t)
          ((equal? type 'int16) 'int16_t)
          ((equal? type 'uint16) 'uint16_t)
          ((equal? type 'int32) 'int32_t)
          ((equal? type 'uint32) 'uint32_t)
          ((equal? type 'int64) 'int64_t)
          ((equal? type 'uint64) 'uint64_t)
          ((equal? type 'char) 'char)
          ((equal? type 'unsigned-char) 'char)
          ((equal? type 'short) 'short)
          ((equal? type 'unsigned-short) 'unsigned-short)
          ((equal? type 'int) 'int)
          ((equal? type 'unsigned-int) 'unsigned-int)
          ((equal? type 'long) 'long)
          ((equal? type 'unsigned-long) 'unsigned-long)
          ((equal? type 'float) 'float)
          ((equal? type 'double) 'double)
          ((equal? type 'pointer) '(maybe-null void*))
          ((equal? type 'string) 'string)
          ((equal? type 'void) 'void)
          ((equal? type 'callback) '(maybe-null void*))
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

;; pffi-define

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
