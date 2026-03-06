(chicken-define-for-syntax type->native-type
  (lambda (type)
    (cond ((equal? type 'i8) 'byte)
          ((equal? type 'u8) 'unsigned-byte)
          ((equal? type 'i16) 'short)
          ((equal? type 'u16) 'unsigned-short)
          ((equal? type 'i32) 'integer32)
          ((equal? type 'u32) 'unsigned-integer32)
          ((equal? type 'i64) 'integer64)
          ((equal? type 'u64) 'unsigned-integer64)
          ((equal? type 'char) 'char)
          ((equal? type 'uchar) 'unsigned-char)
          ((equal? type 'short) 'short)
          ((equal? type 'ushort) 'unsigned-short)
          ((equal? type 'int) 'int)
          ((equal? type 'uint) 'unsigned-int)
          ((equal? type 'long) 'long)
          ((equal? type 'ulong) 'unsigned-long)
          ((equal? type 'float) 'float)
          ((equal? type 'double) 'double)
          ((equal? type 'void) 'void)
          (else
            (display "HERE: ")
            (write type)
            (newline)
            'c-pointer))))

(define-syntax define-c-procedure
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((scheme-name (list-ref expr 1))
             (c-name (symbol->string (cadr (list-ref expr 3))))
             (return-type (cadr (list-ref expr 4)))
             (native-return-type (type->native-type return-type))
             (argument-types (if (null? (list-ref expr 5))
                               (list)
                               (cadr (list-ref expr 5))))
             (native-argument-types (map type->native-type argument-types)))
        (display "HERE: 1 ")
        (write c-name)
        (newline)
        (write return-type)
        (newline)
        (write argument-types)
        (newline)
        (write native-argument-types)
        (newline)
          `(define ,scheme-name
             (lambda args
               (let ((,scheme-name (chicken-foreign-safe-lambda ,native-return-type ,c-name ,@ native-argument-types)))
                 (if (equal? (quote ,native-return-type) 'c-pointer)
                   (internal-make-c-bytevector (apply ,scheme-name (map value->native-value args)))
                   (apply ,scheme-name (map value->native-value args))))))))))

(define-syntax shared-object-load
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((headers (cadr (car (cdr expr)))))
        `(begin
           ,@ (map
                (lambda (header)
                  `(chicken-foreign-declare ,(string-append "#include <" header ">")))
                headers))))))

(define c-u8-ref
  (lambda (pointer k)
    (chicken-pointer-u8-ref (chicken-pointer+ pointer k))))

(define c-u8-set!
  (lambda (pointer k byte)
    (chicken-pointer-u8-set! (chicken-pointer+ pointer k) byte)))

(define c-pointer-ref
  (lambda (pointer k)
    (chicken-address->pointer (chicken-pointer-u64-ref (chicken-pointer+ pointer k)))))

(define c-pointer-set!
  (lambda (pointer k value-pointer)
    (chicken-pointer-u64-set! (chicken-pointer+ pointer k)
                      (chicken-pointer->address value-pointer))))

(define (c-null) (chicken-address->pointer 0))

(define c-null?
  (lambda (pointer)
    (or (not pointer)
        (= (chicken-pointer->address pointer) 0))))
