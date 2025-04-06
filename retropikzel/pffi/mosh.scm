(define size-of-type
  (lambda (type)
    (cond ((eq? type 'int8) 1)
          ((eq? type 'uint8) 1)
          ((eq? type 'int16) 2)
          ((eq? type 'uint16) 2)
          ((eq? type 'int32) 4)
          ((eq? type 'uint32) 4)
          ((eq? type 'int64) 8)
          ((eq? type 'uint64) 8)
          ((eq? type 'char) 1)
          ((eq? type 'unsigned-char) 1)
          ((eq? type 'short) size-of-short)
          ((eq? type 'unsigned-short) size-of-unsigned-short)
          ((eq? type 'int) size-of-int)
          ((eq? type 'unsigned-int) size-of-unsigned-int)
          ((eq? type 'long) size-of-long)
          ((eq? type 'unsigned-long) size-of-unsigned-long)
          ((eq? type 'float) size-of-float)
          ((eq? type 'double) size-of-double)
          ((eq? type 'pointer) size-of-pointer)
          ((eq? type 'string) size-of-pointer)
          ((eq? type 'callback) size-of-pointer)
          ((eq? type 'void) 0)
          (else #f))))

(define pffi-shared-object-load
  (lambda (path . options)
    (open-shared-library path)))

(define pffi-pointer-null
  (lambda ()
    pointer-null))

(define pffi-pointer-null?
  (lambda (pointer)
    (pointer-null? pointer)))

#;(define pffi-pointer-allocate
  (lambda (size)
    (malloc size)))

(define pffi-pointer-address
  (lambda (pointer)
    (pointer->integer pointer)))

(define pffi-pointer?
  (lambda (object)
    (pointer? object)))

#;(define pffi-pointer-free
  (lambda (pointer)
    (free pointer)))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond ((equal? type 'int8) (pointer-set-c-int8! pointer offset value))
          ((equal? type 'uint8) (pointer-set-c-uint8! pointer offset value))
          ((equal? type 'int16) (pointer-set-c-int16! pointer offset value))
          ((equal? type 'uint16) (pointer-set-c-uint16! pointer offset value))
          ((equal? type 'int32) (pointer-set-c-int32! pointer offset value))
          ((equal? type 'uint32) (pointer-set-c-uint32! pointer offset value))
          ((equal? type 'int64) (pointer-set-c-int64! pointer offset value))
          ((equal? type 'uint64) (pointer-set-c-uint64! pointer offset value))
          ((equal? type 'char) (pointer-set-c-char! pointer offset (char->integer value)))
          ((equal? type 'short) (pointer-set-c-short! pointer offset value))
          ((equal? type 'unsigned-short) (pointer-set-c-short! pointer offset value))
          ((equal? type 'int) (pointer-set-c-int! pointer offset value))
          ((equal? type 'unsigned-int) (pointer-set-c-int! pointer offset value))
          ((equal? type 'long) (pointer-set-c-long! pointer offset value))
          ((equal? type 'unsigned-long) (pointer-set-c-long! pointer offset value))
          ((equal? type 'float) (pointer-set-c-float! pointer offset value))
          ((equal? type 'double) (pointer-set-c-double! pointer offset value))
          ((equal? type 'void) (pointer-set-c-pointer! pointer offset value))
          ((equal? type 'pointer) (pointer-set-c-pointer! pointer offset value)))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond ((equal? type 'int8) (pointer-ref-c-int8 pointer offset))
          ((equal? type 'uint8) (pointer-ref-c-uint8 pointer offset))
          ((equal? type 'int16) (pointer-ref-c-int16 pointer offset))
          ((equal? type 'uint16) (pointer-ref-c-uint16 pointer offset))
          ((equal? type 'int32) (pointer-ref-c-int32 pointer offset))
          ((equal? type 'uint32) (pointer-ref-c-uint32 pointer offset))
          ((equal? type 'int64) (pointer-ref-c-int64 pointer offset))
          ((equal? type 'uint64) (pointer-ref-c-uint64 pointer offset))
          ((equal? type 'char) (integer->char (pointer-ref-c-signed-char pointer offset)))
          ((equal? type 'short) (pointer-ref-c-signed-short pointer offset))
          ((equal? type 'unsigned-short) (pointer-ref-c-unsigned-short pointer offset))
          ((equal? type 'int) (pointer-ref-c-signed-int pointer offset))
          ((equal? type 'unsigned-int) (pointer-ref-c-unsigned-int pointer offset))
          ((equal? type 'long) (pointer-ref-c-signed-long pointer offset))
          ((equal? type 'unsigned-long) (pointer-ref-c-unsigned-long pointer offset))
          ((equal? type 'float) (pointer-ref-c-float pointer offset))
          ((equal? type 'double) (pointer-ref-c-double pointer offset))
          ((equal? type 'void) (pointer-ref-c-pointer pointer offset))
          ((equal? type 'pointer) (pointer-ref-c-pointer pointer offset)))))

#;(define pffi-string->pointer
  (lambda (string-content)
    (let ((pointer (pffi-pointer-allocate (+ (string-length string-content) 1)))
          (index 0))
      (string-for-each
        (lambda (c)
          (pffi-pointer-set! pointer 'char (* index (size-of-type 'char)) c)
          (set! index (+ index 1)))
        string-content)
      (pffi-pointer-set! pointer 'char (* index (size-of-type 'char)) #\null)
      pointer)))

#;(define pffi-pointer->string
  (lambda (pointer)
    (pointer->string pointer)))

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
          ((equal? type 'pointer) 'void*)
          ((equal? type 'string) 'char*)
          ((equal? type 'void) 'void)
          ((equal? type 'callback) 'void*)
          ((equal? type 'struct) 'void*)
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (pffi-type->native-type return-type)
                        c-name
                        (map pffi-type->native-type argument-types))))))

(define-syntax pffi-define-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (make-c-callback (pffi-type->native-type return-type)
                        (map pffi-type->native-type argument-types)
                        procedure)))))

#;(define pffi-struct-dereference
  (lambda (struct)
    (pffi-struct-pointer struct)))
