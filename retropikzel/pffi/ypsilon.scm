(define size-of-type
  (lambda (type)
    (cond ((eq? type 'int8) (c-sizeof int8_t))
          ((eq? type 'uint8) (c-sizeof uint8_t))
          ((eq? type 'int16) (c-sizeof int16_t))
          ((eq? type 'uint16) (c-sizeof uint16_t))
          ((eq? type 'int32) (c-sizeof int32_t))
          ((eq? type 'uint32) (c-sizeof uint32_t))
          ((eq? type 'int64) (c-sizeof int64_t))
          ((eq? type 'uint64) (c-sizeof uint64_t))
          ((eq? type 'char) (c-sizeof char))
          ((eq? type 'unsigned-char) (c-sizeof char))
          ((eq? type 'short) (c-sizeof short))
          ((eq? type 'unsigned-short) (c-sizeof unsigned-short))
          ((eq? type 'int) (c-sizeof int))
          ((eq? type 'unsigned-int) (c-sizeof unsigned-int))
          ((eq? type 'long) (c-sizeof long))
          ((eq? type 'unsigned-long) (c-sizeof unsigned-long))
          ((eq? type 'float) (c-sizeof float))
          ((eq? type 'double) (c-sizeof double))
          ((eq? type 'pointer) (c-sizeof void*))
          ((eq? type 'string) (c-sizeof void*))
          ((eq? type 'struct) (c-sizeof void*))
          ((eq? type 'callback) (c-sizeof void*))
          ((eq? type 'void) 0)
          (else #f))))

(define c-malloc (c-function void* malloc (size_t)))
(define c-free (c-function int free (void*)))

(define pffi-pointer-allocate
  (lambda (size)
    (c-malloc size)))

(define pffi-pointer-address
  (lambda (pointer)
    pointer))

(define pffi-pointer?
  (lambda (object)
    (number? object)))

(define pffi-pointer-free
  (lambda (pointer)
    (c-free pointer)))

; FIXME I dont know where to else get null :D
(define pffi-pointer-null
  (lambda ()
    (c-malloc 999999999999999999999999999999999999999999999999999999999999)))

(define pffi-pointer-null?
  (lambda (pointer)
    (and (pffi-pointer? pointer)
         (= (pffi-pointer-address pointer) 0))))

(define pffi-pointer->string
  (lambda (pointer)
    (c-string-ref pointer)))

(define c-memset(c-function int memset (void* int int)))
(define c-snprintf (c-function int snprintf (void* size_t void*) (long double)))
(define pffi-string->pointer
  (lambda (string-content)
    (let* ((c-string (make-c-string string-content))
          (c-string-length (bytevector-length c-string))
          (pointer (c-malloc c-string-length)))
      (c-memset pointer 0 c-string-length)
      (c-snprintf pointer c-string-length (make-c-string "%s") c-string)
      pointer)))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (let ((bv (make-bytevector-mapping (+ pointer offset) (pffi-size-of type))))
      (cond ((equal? type 'int8) (bytevector-c-int8-set! bv 0 value))
            ((equal? type 'uint8) (bytevector-c-int8-set! bv 0 value))
            ((equal? type 'int16) (bytevector-c-int16-set! bv 0 value))
            ((equal? type 'uint16) (bytevector-c-int16-set! bv 0 value))
            ((equal? type 'int32) (bytevector-c-int32-set! bv 0 value))
            ((equal? type 'uint32) (bytevector-c-int32-set! bv 0 value))
            ((equal? type 'int64) (bytevector-c-int64-set! bv 0 value))
            ((equal? type 'uint64) (bytevector-c-int64-set! bv 0 value))
            ((equal? type 'char) (bytevector-c-int8-set! bv 0 (char->integer value)))
            ((equal? type 'short) (bytevector-c-short-set! bv 0 value))
            ((equal? type 'unsigned-short) (bytevector-c-short-set! bv 0 value))
            ((equal? type 'int) (bytevector-c-int-set! bv 0 value))
            ((equal? type 'unsigned-int) (bytevector-c-int-set! bv 0 value))
            ((equal? type 'long) (bytevector-c-long-set! bv 0 value))
            ((equal? type 'unsigned-long) (bytevector-c-long-set! bv 0 value))
            ((equal? type 'float) (bytevector-c-float-set! bv 0 value))
            ((equal? type 'double) (bytevector-c-double-set! bv 0 value))
            ((equal? type 'void) (bytevector-c-void*-set! bv 0 value))
            ((equal? type 'pointer) (bytevector-c-void*-set! bv 0 value))))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (let ((bv (make-bytevector-mapping (+ pointer offset) (pffi-size-of type))))
      (cond ((equal? type 'int8) (bytevector-c-int8-ref bv 0))
            ((equal? type 'uint8) (bytevector-c-uint8-ref bv 0))
            ((equal? type 'int16) (bytevector-c-int16-ref bv 0))
            ((equal? type 'uint16) (bytevector-c-uint16-ref bv 0))
            ((equal? type 'int32) (bytevector-c-int32-ref bv 0))
            ((equal? type 'uint32) (bytevector-c-uint32-ref bv 0))
            ((equal? type 'int64) (bytevector-c-int64-ref bv 0))
            ((equal? type 'uint64) (bytevector-c-uint64-ref bv 0))
            ((equal? type 'char) (integer->char (bytevector-c-uint8-ref bv 0)))
            ((equal? type 'short) (bytevector-c-short-ref bv 0))
            ((equal? type 'unsigned-short) (bytevector-c-unsigned-short-ref bv 0))
            ((equal? type 'int) (bytevector-c-int-ref bv 0))
            ((equal? type 'unsigned-int) (bytevector-c-unsigned-int-ref bv 0))
            ((equal? type 'long) (bytevector-c-long-ref bv 0))
            ((equal? type 'unsigned-long) (bytevector-c-unsigned-long-ref bv 0))
            ((equal? type 'float) (bytevector-c-float-ref bv 0))
            ((equal? type 'double) (bytevector-c-double-ref bv 0))
            ((equal? type 'void) (bytevector-c-void*-ref bv 0))
            ((equal? type 'pointer) (bytevector-c-void*-ref bv 0))))))

(define pffi-shared-object-load
  (lambda (headers path . options)
    (load-shared-object path)))

(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type '(quote int8)) 'int8_t)
          ((equal? type '(quote uint8)) 'uint8_t)
          ((equal? type '(quote int16)) 'int16_t)
          ((equal? type '(quote uint16)) 'uint16_t)
          ((equal? type '(quote int32)) 'int32_t)
          ((equal? type '(quote uint32)) 'uint32_t)
          ((equal? type '(quote int64)) 'int64_t)
          ((equal? type '(quote uint64)) 'uint64_t)
          ((equal? type '(quote char)) 'char)
          ((equal? type '(quote unsigned-char)) 'char)
          ((equal? type '(quote short)) 'short)
          ((equal? type '(quote unsigned-short)) 'unsigned-short)
          ((equal? type '(quote int)) 'int)
          ((equal? type '(quote unsigned-int)) 'unsigned-int)
          ((equal? type '(quote long)) 'long)
          ((equal? type '(quote unsigned-long)) 'unsigned-long)
          ((equal? type '(quote float)) 'float)
          ((equal? type '(quote double)) 'double)
          ((equal? type '(quote pointer)) 'void*)
          ((equal? type '(quote string)) 'void*)
          ((equal? type '(quote void)) 'void)
          ((equal? type '(quote callback)) 'void*)
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define-macro
  (pffi-define scheme-name shared-object c-name return-type argument-types)
    `(define ,scheme-name
       (c-function ,(pffi-type->native-type return-type)
                   ,(cadr c-name)
                   ,(map pffi-type->native-type (cdr argument-types)))))

(define-macro
  (pffi-define-callback scheme-name return-type argument-types procedure)
    `(define ,scheme-name
       (c-callback ,(pffi-type->native-type return-type)
                   ,(map pffi-type->native-type (cdr argument-types))
                   ,procedure)))
