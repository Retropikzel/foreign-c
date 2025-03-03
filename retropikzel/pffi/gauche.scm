(define-module retropikzel.pffi.gauche
               (export size-of-type
                       pffi-shared-object-load
                       pffi-pointer-null
                       pffi-pointer-null?
                       pffi-pointer-allocate
                       pffi-pointer?
                       pffi-pointer-free
                       spigot-calculate-e))
(select-module retropikzel.pffi.gauche)
(dynamic-load "retropikzel-pffi-gauche")

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
  (lambda (headers path . options)
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

(define pffi-pointer?
  (lambda (pointer)
    (pointer? pointer)))

(define pffi-pointer-free
  (lambda (pointer)
    (pointer-free pointer)))

