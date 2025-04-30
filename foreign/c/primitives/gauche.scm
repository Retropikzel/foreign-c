(define-module foreign.c.primitives.gauche
               (export size-of-type
                       shared-object-load
                       c-bytevector-u8-set!
                       c-bytevector-u8-ref
                       c-bytevector-pointer-set!
                       c-bytevector-pointer-ref
                       ;pointer-null
                       ;pointer-null?
                       ;make-c-bytevector
                       ;pointer-address
                       c-bytevector?
                       c-free
                       ;pointer-set!
                       ;pointer-get
                       ;define-c-procedure
                       define-c-callback
                       dlerror
                       dlsym
                       internal-ffi-call
                       ))

(select-module foreign.c.primitives.gauche)
(dynamic-load "foreign/c/lib/gauche")

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

#;(define shared-object-load
  (lambda (path options)
    (shared-object-load path)))

#;(define make-c-bytevector
  (lambda (size)
    (pointer-allocate size)))

(define c-bytevector?
  (lambda (pointer)
    (pointer? pointer)))

#;(define c-free
  (lambda (pointer)
    (pointer-free pointer)))

(define c-bytevector-u8-set! pointer-set-uint8!)
(define c-bytevector-u8-ref pointer-get-uint8)
(define c-bytevector-pointer-set! pointer-set-pointer!)
(define c-bytevector-pointer-ref pointer-get-pointer)

#;(define pointer-set!
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

#;(define pointer-get
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

#;(define type->libffi-type
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

#;(define type->libffi-type
  (lambda (type)
    (cond ((equal? type 'int8) 1)
          ((equal? type 'uint8) 2)
          ((equal? type 'int16) 3)
          ((equal? type 'uint16) 4)
          ((equal? type 'int32) 5)
          ((equal? type 'uint32) 6)
          ((equal? type 'int64) 7)
          ((equal? type 'uint64) 8)
          ((equal? type 'char) 9)
          ((equal? type 'unsigned-char) 10)
          ((equal? type 'bool) 11)
          ((equal? type 'short) 12)
          ((equal? type 'unsigned-short) 13)
          ((equal? type 'int) 14)
          ((equal? type 'unsigned-int) 15)
          ((equal? type 'long) 16)
          ((equal? type 'unsigned-long) 17)
          ((equal? type 'float) 18)
          ((equal? type 'double) 19)
          ((equal? type 'void) 20)
          ((equal? type 'pointer) 21)
          ((equal? type 'callback) 21))))

#;(define argument->pointer
  (lambda (value type)
    (cond ((procedure? value) (scheme-procedure-to-pointer value))
          (else (let ((pointer (make-c-bytevector (size-of-type type))))
                  (pointer-set! pointer type 0 value)
                  pointer)))))


(define make-c-callback
  (lambda (return-type argument-types procedure)
    (scheme-procedure-to-pointer procedure)))

(define-syntax define-c-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (make-c-callback return-type 'argument-types procedure)))))
