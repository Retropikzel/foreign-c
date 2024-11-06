(c-declare "#include <stdint.h>")

(define pffi-init (lambda () #t))

#|
(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) int8)
          ((equal? type 'uint8) unsigned-int8)
          ((equal? type 'int16) int16)
          ((equal? type 'uint16) unsigned-int16)
          ((equal? type 'int32) int32)
          ((equal? type 'uint32) unsigned-int32)
          ((equal? type 'int64) int64)
          ((equal? type 'uint64) unsigned-int64)
          ((equal? type 'char) char)
          ((equal? type 'unsigned-char) unsigned-char)
          ((equal? type 'short) short)
          ((equal? type 'unsigned-short) unsigned-short)
          ((equal? type 'int) int)
          ((equal? type 'unsigned-int) unsigned-int)
          ((equal? type 'long) long)
          ((equal? type 'unsigned-long) unsigned-long)
          ((equal? type 'float) float)
          ((equal? type 'double) double)
          ((equal? type 'pointer) pointer)
          ((equal? type 'void) void)
          ((equal? type 'callback) pointer)
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define pffi-pointer?
  (lambda (object)
    (error "Not defined")))

#;(define-syntax pffi-define
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       #f
       #;(c-lambda argument-types return-type c-name)

       ))))

(define pffi-define-callback
  (lambda (scheme-name shared-object c-name return-type argument-types)
    (error "Not defined")))

;(c-declare "int size_of_int8() { return sizeof(int8_t);}")
;(define size-of-int8 (c-lambda () int "__return(sizeof(int8_t));"))
;(define int8-size ((c-lambda () int "__return(sizeof(int8_t));")))
;(define int8-size (c-lambda () int "__return(1);"))

|#
(define pffi-size-of
  (lambda (type)
    (cond ((equal? type 'int8) (c-lambda () int "___return(sizeof(int8_t));"))
          (else (error "pffi-size-of -- No such pffi type" type)))))


#|
#;(define-syntax pffi-pointer-allocate
  (syntax-rules
    ((pffi-pointer-allocate size)
     (c-declare (string-append "malloc(" (number->string size) ")")))))

#;(define-syntax pffi-pointer-null
  (syntax-rules
    ((pffi-pointer-null)
     (c-declare "NULL"))))

(define pffi-string->pointer
  (lambda (string-content)
    string-content))

(define pffi-pointer->string
  (lambda (pointer)
    pointer))

#;(define-syntax pffi-shared-object-load
  (syntax-rules ()
    ((pffi-shared-object-load headers)
     (c-declare (apply string-append
                       (map (lambda (header)
                              (string-append "#include <" header ">"))))))))

(define pffi-pointer-free
  (lambda (pointer)
    (error "Not defined")))

(define pffi-pointer-null?
  (lambda (pointer)
    (error "Not defined")))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (let ((p pointer))
      (error "Not defined"))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (error "Not defined")))

(define pffi-pointer-deref
  (lambda (pointer)
    (error "Not defined")))
|#
