(define pffi-init (lambda () #t))

;(write (get-ffi-type-int))
;(newline)
;(exit)

(define pffi-size-of
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
          (else (error "Can not get size of unknown type" type)))))

(define pffi-shared-object-load
  (lambda (headers path)
    (dlopen path RTLD-NOW)))

(define pffi-pointer-null
  (lambda ()
    (pointer-null)))

(define pffi-pointer-null?
  (lambda (pointer)
    (not pointer))) ; #f is null on Chibi

(define pffi-pointer?
  (lambda (object)
    (string=? (type-name (type-of object)) "Cpointer")))

(define pffi-pointer-allocate
  (lambda (size)
    (pointer-allocate size)))

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

(define pffi-string->pointer
  (lambda (string-content)
    (string-to-pointer string-content)))

(define pffi-pointer->string
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
    (cond
      ;((equal? type 'int8_t) ffi_type_sint8)
      ;((equal? type 'uint8_t) ffi_type_uint8)
      ;((equal? type 'int16_t) ffi_type_sint16)
      ;((equal? type 'uint16_t) ffi_type_uint16)
      ;((equal? type 'int32_t) ffi_type_sint32)
      ;((equal? type 'uint32_t) ffi_type_uint32)
      ;((equal? type 'int64_t) ffi_type_sint64)
      ;((equal? type 'uint64_t) ffi_type_uint64)
      ;((equal? type 'bool) ffi_type_sint8)
      ;((equal? type 'short) ffi_type_sint16)
      ;((equal? type 'unsigned-short) ffi_type_uint16)
      ((equal? type 'int) (get-ffi-type-int))
      ;((equal? type 'unsigned-int) ffi_type_uint32)
      ;((equal? type 'long) ffi_type_long)
      ;((equal? type 'unsigned-long) ffi_type_uint32)
      ;((equal? type 'float) ffi_type_float)
      ;((equal? type 'double) ffi_type_double)
      ;((equal? type 'void) ffi_type_void)
      ((equal? type 'pointer) (get-ffi-type-pointer))
      ;((equal? type 'callback) ffi_type_pointer)
      )))

(define make-c-function
  (lambda (shared-object return-type c-name args)
    (let ((func (dlsym shared-object c-name)))
      (display "HERE: ")
      (write args)
      (newline)
      (write (length args))
      (newline)
      (write (pffi-type->libffi-type return-type))
      (newline)
      (write (map
               (lambda (item)
                 (display "ITEM: ")
                 (write item)
                 (newline))
                 args))
      (newline)
      (internal-ffi-prep-cif (length args)
                    return-type
                    args
                    )
      func

    )))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (pffi-type->libffi-type return-type)
                        (symbol->string c-name)
                        (map pffi-type->libffi-type argument-types))))))
