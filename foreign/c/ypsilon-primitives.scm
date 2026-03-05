(define size-of-type
  (lambda (type)
    (cond ((eq? type 'i8) (ypsilon-c-sizeof int8_t))
          ((eq? type 'u8) (ypsilon-c-sizeof uint8_t))
          ((eq? type 'i16) (ypsilon-c-sizeof int16_t))
          ((eq? type 'u16) (ypsilon-c-sizeof uint16_t))
          ((eq? type 'i32) (ypsilon-c-sizeof int32_t))
          ((eq? type 'u32) (ypsilon-c-sizeof uint32_t))
          ((eq? type 'i64) (ypsilon-c-sizeof int64_t))
          ((eq? type 'u64) (ypsilon-c-sizeof uint64_t))
          ((eq? type 'char) (ypsilon-c-sizeof char))
          ((eq? type 'uchar) (ypsilon-c-sizeof char))
          ((eq? type 'short) (ypsilon-c-sizeof short))
          ((eq? type 'ushort) (ypsilon-c-sizeof unsigned-short))
          ((eq? type 'int) (ypsilon-c-sizeof int))
          ((eq? type 'uint) (ypsilon-c-sizeof unsigned-int))
          ((eq? type 'long) (ypsilon-c-sizeof long))
          ((eq? type 'ulong) (ypsilon-c-sizeof unsigned-long))
          ((eq? type 'float) (ypsilon-c-sizeof float))
          ((eq? type 'double) (ypsilon-c-sizeof double))
          ((eq? type 'pointer) (ypsilon-c-sizeof void*)))))

(define align-of-type
  (lambda (type)
    (cond ((eq? type 'i8) ypsilon-alignof:int8_t)
          ((eq? type 'u8) ypsilon-alignof:int8_t)
          ((eq? type 'i16) ypsilon-alignof:int16_t)
          ((eq? type 'u16) ypsilon-alignof:int16_t)
          ((eq? type 'i32) ypsilon-alignof:int32_t)
          ((eq? type 'u32) ypsilon-alignof:int32_t)
          ((eq? type 'i64) ypsilon-alignof:int64_t)
          ((eq? type 'u64) ypsilon-alignof:int64_t)
          ((eq? type 'char) ypsilon-alignof:int8_t)
          ((eq? type 'uchar) ypsilon-alignof:int8_t)
          ((eq? type 'short) ypsilon-alignof:short)
          ((eq? type 'ushort) ypsilon-alignof:short)
          ((eq? type 'int) ypsilon-alignof:int)
          ((eq? type 'uint) ypsilon-alignof:int)
          ((eq? type 'long) ypsilon-alignof:long)
          ((eq? type 'ulong) ypsilon-alignof:long)
          ((eq? type 'float) ypsilon-alignof:float)
          ((eq? type 'double) ypsilon-alignof:double)
          ((eq? type 'pointer) ypsilon-alignof:void*))))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    ;; Ypsilon for some reason does not have bytevector-c-uint8-set!
    ;; or other bytevector-c-u*-set! procedures so we use
    ;; bytevector-c-int8-set!
    (ypsilon-bytevector-c-int8-set!
      (ypsilon-make-bytevector-mapping (+ c-bytevector k)
                                       (size-of-type 'u8))
      0
      byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (ypsilon-bytevector-c-uint8-ref
      (ypsilon-make-bytevector-mapping (+ c-bytevector k)
                                       (size-of-type 'u8))
      0)))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (ypsilon-bytevector-c-void*-set!
      (ypsilon-make-bytevector-mapping (+ c-bytevector k)
                                       (size-of-type 'pointer))
      0
      pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (ypsilon-bytevector-c-void*-ref
      (ypsilon-make-bytevector-mapping (+ c-bytevector k)
                                       (size-of-type 'pointer))
      0)))

(define shared-object-load
  (lambda (path options)
    (ypsilon-load-shared-object path)))

(ypsilon-define-macro
  (define-c-procedure scheme-name shared-object c-name return-type argument-types)
  (begin
    (let ((type->native-type
            (lambda (type)
              (cond ((equal? type 'i8) 'int8_t)
                    ((equal? type 'u8) 'uint8_t)
                    ((equal? type 'i16) 'int16_t)
                    ((equal? type 'u16) 'uint16_t)
                    ((equal? type 'i32) 'int32_t)
                    ((equal? type 'u32) 'uint32_t)
                    ((equal? type 'i64) 'int64_t)
                    ((equal? type 'u64) 'uint64_t)
                    ((equal? type 'char) 'char)
                    ((equal? type 'uchar) 'char)
                    ((equal? type 'short) 'short)
                    ((equal? type 'ushort) 'unsigned-short)
                    ((equal? type 'int) 'int)
                    ((equal? type 'uint) 'unsigned-int)
                    ((equal? type 'long) 'long)
                    ((equal? type 'ulong) 'unsigned-long)
                    ((equal? type 'float) 'float)
                    ((equal? type 'double) 'double)
                    ((equal? type 'pointer) 'void*)
                    ((equal? type 'void) 'void)
                    ((equal? type 'callback) 'void*)
                    (else (error "type->native-type -- No such type" type))))))
      `(define ,scheme-name
         (lambda args
           (let ((internal
                   (ypsilon-c-function ,(type->native-type (cadr return-type))
                                       ,(cadr c-name)
                                       ,(map type->native-type (cadr argument-types)))))
             (if (equal? ,return-type 'pointer)
               (internal-make-c-bytevector (apply internal (map value->native-value args)))
               (apply internal (map value->native-value args)))))))))

(define (c-null) (c-memset-address->pointer 0 0 0))
(define (c-null? pointer)
  (or (and (number? pointer)
           (= pointer 0))
      (and (c-bytevector? pointer)
           (=  (c-memset-pointer->address pointer 0 0) 0))))
