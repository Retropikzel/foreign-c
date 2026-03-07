(ypsilon-define-macro
  (define-c-procedure scheme-name shared-object c-name return-type argument-types)
  (begin
    (let* ((type->native-type
             (lambda (type argument?)
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
                     ((equal? type 'array) 'void*)
                     ((equal? type 'struct) 'void*)
                     ((equal? type 'void)
                      (if argument?
                        (error "define-c-procedure: Argument type can not be void" scheme-name type)
                        'void))
                     (else
                       (if argument?
                         (error "define-c-procedure: Invalid argument type" scheme-name type)
                         (error "define-c-procedure: Invalid return type" scheme-name type))))))
           (native-argument-types (if (null? argument-types)
                                    (list)
                                    (map (lambda (type)
                                           (type->native-type type #t))
                                         (cadr argument-types)))))
      `(define ,scheme-name
         (lambda args
           (let ((internal
                   (ypsilon-c-function ,(type->native-type (cadr return-type) #f)
                                       ,(cadr c-name)
                                       ,native-argument-types)))
             (if (equal? ,return-type 'pointer)
               (internal-make-c-bytevector (apply internal (map value->native-value args)))
               (apply internal (map value->native-value args)))))))))

(define shared-object-load
  (lambda (path options)
    (ypsilon-load-shared-object path)))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    ;; Ypsilon for some reason does not have bytevector-c-uint8-set!
    ;; or other bytevector-c-u*-set! procedures so we use
    ;; bytevector-c-int8-set!
    (ypsilon-bytevector-c-int8-set!
      (ypsilon-make-bytevector-mapping (+ c-bytevector k) (c-type-size 'u8))
      0
      byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (ypsilon-bytevector-c-uint8-ref
      (ypsilon-make-bytevector-mapping (+ c-bytevector k) (c-type-size 'u8))
      0)))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (ypsilon-bytevector-c-void*-set!
      (ypsilon-make-bytevector-mapping (+ c-bytevector k) (c-type-size 'pointer))
      0
      pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (ypsilon-bytevector-c-void*-ref
      (ypsilon-make-bytevector-mapping (+ c-bytevector k) (c-type-size 'pointer))
      0)))

(define (c-null) (c-memset-address->pointer 0 0 0))
(define (c-null? pointer)
  (or (and (number? pointer)
           (= pointer 0))
      (and (c-bytevector? pointer)
           (=  (c-memset-pointer->address pointer 0 0) 0))))
