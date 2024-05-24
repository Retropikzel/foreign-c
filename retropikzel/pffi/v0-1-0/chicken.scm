(define-library
  (retropikzel pffi v0-1-0 chicken)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme process-context)
          (chicken foreign)
          (chicken syntax)
          (chicken memory))
  (export pffi-shared-object-load
          pffi-define
          pffi-size-of
          pffi-pointer-allocate
          pffi-pointer-null
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-pointer-set!
          pffi-pointer-get
          pffi-pointer-deref)
  (begin

    (define pffi-type->native-type
      (lambda (type)
        (cond ((equal? type 'int8) 'byte)
              ((equal? type 'uint8) 'unsigned-byte)
              ((equal? type 'int16) 'int16_t)
              ((equal? type 'uint16) 'uint16_t)
              ((equal? type 'int32) 'int32)
              ((equal? type 'uint32) 'unsigned-int32)
              ((equal? type 'int64) 'integer-64)
              ((equal? type 'uint64) 'unsigned-integer64)
              ((equal? type 'char) 'char)
              ((equal? type 'unsigned-char) 'unsigned-char)
              ((equal? type 'short) 'short)
              ((equal? type 'unsigned-short) 'unsigned-short)
              ((equal? type 'int) 'int)
              ((equal? type 'unsigned-int) 'unsigned-int)
              ((equal? type 'long) 'long)
              ((equal? type 'unsigned-long) 'unsigned-long)
              ((equal? type 'float) 'float)
              ((equal? type 'double) 'double)
              ((equal? type 'pointer) 'c-pointer)
              ((equal? type 'string) 'c-string)
              ((equal? type 'void) 'void)
              (else (error "pffi-type->native-type -- No such pffi type" type)))) )

    (define pffi-pointer?
      (lambda (object)
        (pointer? object)))

    (define-syntax pffi-define
      (er-macro-transformer
        (lambda (expr rename compare)
          (let* ((pffi-type->native-type
                   (lambda (type)
                     (cond ((equal? type 'int8) 'byte)
                           ((equal? type 'uint8) 'unsigned-byte)
                           ((equal? type 'int16) 'int16_t)
                           ((equal? type 'uint16) 'uint16_t)
                           ((equal? type 'int32) 'int32)
                           ((equal? type 'uint32) 'unsigned-int32)
                           ((equal? type 'int64) 'integer-64)
                           ((equal? type 'uint64) 'unsigned-integer64)
                           ((equal? type 'char) 'char)
                           ((equal? type 'unsigned-char) 'unsigned-char)
                           ((equal? type 'short) 'short)
                           ((equal? type 'unsigned-short) 'unsigned-short)
                           ((equal? type 'int) 'int)
                           ((equal? type 'unsigned-int) 'unsigned-int)
                           ((equal? type 'long) 'long)
                           ((equal? type 'unsigned-long) 'unsigned-long)
                           ((equal? type 'float) 'float)
                           ((equal? type 'double) 'double)
                           ((equal? type 'pointer) 'c-pointer)
                           ((equal? type 'string) 'c-string)
                           ((equal? type 'void) 'void)
                           (else (error "pffi-type->native-type -- No such pffi type" type)))))
                 (scheme-name (car (cdr expr)))
                 (c-name (symbol->string (car (cdr (car (cdr (cdr (cdr expr))))))))
                 (return-type (pffi-type->native-type (car (cdr (car (cdr (cdr (cdr (cdr expr)))))))))
                 (argument-types
                   (let ((types (cdr (car (cdr (cdr (cdr (cdr (cdr expr)))))))))
                     (if (null? types)
                       '()
                       (map pffi-type->native-type (map car (map cdr types)))))))
            (if (null? argument-types)
              `(define ,scheme-name
                 (foreign-lambda ,return-type ,c-name))
              `(define ,scheme-name
                 (foreign-lambda ,return-type ,c-name ,@ argument-types)))))))

    (define-syntax pffi-size-of
      (er-macro-transformer
        (lambda (expr rename compare)
          (let ((type (car (cdr (car (cdr expr))))))
            (cond ((equal? type 'int8) `(foreign-value "sizeof(int8_t)" int))
                  ((equal? type 'uint8) `(foreign-value "sizeof(uint8_t)" int))
                  ((equal? type 'int16) `(foreign-value "sizeof(int16_t)" int))
                  ((equal? type 'uint16) `(foreign-value "sizeof(uint16_t)" int))
                  ((equal? type 'int32) `(foreign-value "sizeof(int32_t)" int))
                  ((equal? type 'uint32) `(foreign-value "sizeof(uint32_t)" int))
                  ((equal? type 'int64) `(foreign-value "sizeof(int64_t)" int))
                  ((equal? type 'uint64) `(foreign-value "sizeof(uint64_t)" int))
                  ((equal? type 'char) `(foreign-value "sizeof(char)" int))
                  ((equal? type 'unsigned-char) `(foreign-value "sizeof(unsigned char)" int))
                  ((equal? type 'short) `(foreign-value "sizeof(short)" int))
                  ((equal? type 'unsigned-short) `(foreign-value "sizeof(unsigned short)" int))
                  ((equal? type 'int) `(foreign-value "sizeof(int)" int))
                  ((equal? type 'unsigned-int) `(foreign-value "sizeof(unsigned int)" int))
                  ((equal? type 'long) `(foreign-value "sizeof(long)" int))
                  ((equal? type 'unsigned-long) `(foreign-value "sizeof(unsigned long)" int))
                  ((equal? type 'float) `(foreign-value "sizeof(float)" int))
                  ((equal? type 'double) `(foreign-value "sizeof(double)" int))
                  ((equal? type 'pointer) `(foreign-value "sizeof(int)" int))
                  (else `(error "pffi-size-of -- No such pffi type" type)))))))

    (define pffi-pointer-allocate
      (lambda (size)
        (allocate size)))

    (define pffi-pointer-null
      (lambda ()
        (address->pointer 0)))

    (define pffi-string->pointer
      (lambda (string-content)
        (let* ((size (string-length string-content))
               (pointer (pffi-pointer-allocate size)))
          (move-memory! string-content pointer size 0)
          pointer)))

    (pffi-define strlen #f 'strlen 'int (list 'pointer))

    (define pffi-pointer->string
      (lambda (pointer)
        (if (string? pointer)
          pointer
          (let* ((size (strlen pointer))
                 (string-content (make-string size)))
            (move-memory! pointer string-content size 0)
            string-content))))

    (define-syntax pffi-shared-object-load
      (er-macro-transformer
        (lambda (expr rename compare)
          (let* ((headers (cdr (car (cdr expr)))))
            `(begin
               ,@ (map
                    (lambda (header)
                      `(foreign-declare ,(string-append "#include <" header ">")))
                    headers))))))

    (define pffi-pointer-free
      (lambda (pointer)
        (free pointer)))

    (define pffi-pointer-null?
      (lambda (pointer)
        (and (pffi-pointer? pointer)
             (= (pointer->address pointer) 0))))

    (define pffi-pointer-set!
      (lambda (pointer type offset value)
        (cond
          ((equal? type 'int8) (pointer-s8-set! (pointer+ pointer offset) value))
          ((equal? type 'uint8) (pointer-u8-set! (pointer+ pointer offset) value))
          ((equal? type 'int16) (pointer-s16-set! (pointer+ pointer offset) value))
          ((equal? type 'uint16) (pointer-u16-set! (pointer+ pointer offset) value))
          ((equal? type 'int32) (pointer-s32-set! (pointer+ pointer offset) value))
          ((equal? type 'uint32) (pointer-u32-set! (pointer+ pointer offset) value))
          ((equal? type 'int64) (pointer-s64-set! (pointer+ pointer offset) value))
          ((equal? type 'uint64) (pointer-u64-set! (pointer+ pointer offset) value))
          ((equal? type 'char) (pointer-s8-set! (pointer+ pointer offset) value))
          ((equal? type 'short) (pointer-s8-set! (pointer+ pointer offset) value))
          ((equal? type 'unsigned-short) (pointer-u8-set! (pointer+ pointer offset) value))
          ((equal? type 'int) (pointer-s32-set! (pointer+ pointer offset) value))
          ((equal? type 'unsigned-int) (pointer-u32-set! (pointer+ pointer offset) value))
          ((equal? type 'long) (pointer-s32-set! (pointer+ pointer offset) value))
          ((equal? type 'unsigned-long) (pointer-u32-set! (pointer+ pointer offset) value))
          ((equal? type 'float) (pointer-s32-set! (pointer+ pointer offset) value))
          ((equal? type 'double) (pointer-s32-set! (pointer+ pointer offset) value))
          ((equal? type 'pointer) (pointer-u32-set! (pointer+ pointer offset) value)))))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (cond
          ((equal? type 'int8) (pointer-s8-ref (pointer+ pointer offset)))
          ((equal? type 'uint8) (pointer-u8-ref (pointer+ pointer offset)))
          ((equal? type 'int16) (pointer-s16-ref (pointer+ pointer offset)))
          ((equal? type 'uint16) (pointer-u16-ref (pointer+ pointer offset)))
          ((equal? type 'int32) (pointer-s32-ref (pointer+ pointer offset)))
          ((equal? type 'uint32) (pointer-u32-ref (pointer+ pointer offset)))
          ((equal? type 'int64) (pointer-s64-ref (pointer+ pointer offset)))
          ((equal? type 'uint64) (pointer-u64-ref (pointer+ pointer offset)))
          ((equal? type 'char) (pointer-s8-ref (pointer+ pointer offset)))
          ((equal? type 'short) (pointer-s8-ref (pointer+ pointer offset)))
          ((equal? type 'unsigned-short) (pointer-u8-ref (pointer+ pointer offset)))
          ((equal? type 'int) (pointer-s32-ref (pointer+ pointer offset)))
          ((equal? type 'unsigned-int) (pointer-u32-ref (pointer+ pointer offset)))
          ((equal? type 'long) (pointer-s32-ref (pointer+ pointer offset)))
          ((equal? type 'unsigned-long) (pointer-u32-ref (pointer+ pointer offset)))
          ((equal? type 'float) (pointer-s32-ref (pointer+ pointer offset)))
          ((equal? type 'double) (pointer-s32-ref (pointer+ pointer offset)))
          ((equal? type 'pointer) (pointer-u32-ref (pointer+ pointer offset))))))

    (define pffi-pointer-deref
      (lambda (pointer)
        pointer))))
