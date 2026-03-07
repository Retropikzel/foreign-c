(define type->libffi-type-number
  (lambda (type argument?)
    (cond ((equal? type 'i8) 1)
          ((equal? type 'u8) 2)
          ((equal? type 'i16) 3)
          ((equal? type 'u16) 4)
          ((equal? type 'i32) 5)
          ((equal? type 'u32) 6)
          ((equal? type 'i64) 7)
          ((equal? type 'u64) 8)
          ((equal? type 'char) 9)
          ((equal? type 'uchar) 10)
          ((equal? type 'short) 11)
          ((equal? type 'ushort) 12)
          ((equal? type 'int) 13)
          ((equal? type 'uint) 14)
          ((equal? type 'long) 15)
          ((equal? type 'ulong) 16)
          ((equal? type 'float) 17)
          ((equal? type 'double) 18)
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" type)
             '19))
          ((equal? type 'pointer) 20)
          ((equal? type 'array) 20)
          ((equal? type 'struct) 20)
          ((equal? type 'pointer-address) 21)
          (else (error "define-c-procedure: Invalid argument type" type)))))

(define shared-object-load
  (lambda (path options)
    (let ((shared-object (dlopen path RTLD-NOW)))
      shared-object)))

#;(define type->native-type
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
          ((equal? type 'pointer) '(maybe-null pointer void*))
          ((equal? type 'array) '(maybe-null pointer void*))
          ((equal? type 'struct) '(maybe-null pointer void*))
          ((equal? type 'pointer-address) '(maybe-null pointer void*))
          ((equal? type 'void)
           (if argument?
             (error "define-c-procedure: Argument type can not be void" type)
             'void))
          (else (error "define-c-procedure: Invalid argument type" type)))))

(define make-c-function
  (lambda (shared-object c-name return-type argument-types)
    (let ((c-function (dlsym shared-object c-name)))
      (lambda arguments
        (let* ((return-pointer
                 (internal-ffi-call (length argument-types)
                                    (type->libffi-type-number return-type #f)
                                    (map (lambda (type)
                                           (type->libffi-type-number type #t))
                                         argument-types)
                                    c-function
                                    (c-type-size return-type)
                                    (map value->native-value arguments))))
          (when (not (equal? return-type 'void))
            (c-bytevector-ref (internal-make-c-bytevector return-pointer) return-type 0)))))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-c-function shared-object
                        (symbol->string c-name)
                        return-type
                        argument-types)))))

(define (c-null) (internal-c-null))

(define (c-null? pointer)
  (or (equal? pointer #f) ;; #f counts as null pointer
      (and (c-bytevector? pointer)
           (internal-c-null? pointer))))

