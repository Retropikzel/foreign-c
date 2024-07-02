(define-library
  (retropikzel pffi v0-3-0 cyclone)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme eval)
          (scheme process-context)
          (scheme eval)
          (cyclone foreign)
          (scheme cyclone primitives))
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
        (cond ((equal? type 'int8) int)
              ((equal? type 'uint8) int)
              ((equal? type 'int16) int)
              ((equal? type 'uint16) int)
              ((equal? type 'int32) int)
              ((equal? type 'uint32) int)
              ((equal? type 'int64) int)
              ((equal? type 'uint64) int)
              ((equal? type 'char) char)
              ((equal? type 'unsigned-char) char)
              ((equal? type 'short) int)
              ((equal? type 'unsigned-short) int)
              ((equal? type 'int) int)
              ((equal? type 'unsigned-int) int)
              ((equal? type 'long) int)
              ((equal? type 'unsigned-long) int)
              ((equal? type 'float) float)
              ((equal? type 'double) double)
              ((equal? type 'pointer) opaque)
              ((equal? type 'string) string)
              ((equal? type 'void) c-void)
              (else (error "pffi-type->native-type -- No such pffi type" type)))))

    (define pffi-pointer?
      (lambda (object)
        (error "Not defined")))


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
              `(c-define ,scheme-name ,return-type ,c-name)
              `(c-define ,scheme-name
                         ,return-type ,c-name ,@ argument-types))))))


    (define pffi-size-of
      (lambda (type)
        (error "Not defined")))

    (define pffi-pointer-allocate
      (lambda (size)
        (error "Not defined")))

    (define pffi-pointer-null
      (lambda ()
        (error "Not defined")))

    (define pffi-string->pointer
      (lambda (string-content)
        (error "Not defined")))

    (define pffi-pointer->string
      (lambda (pointer)
        pointer))

    (define-syntax pffi-shared-object-load
      (er-macro-transformer
        (lambda (expr rename compare)
          `(begin
             ,@ (map
                  (lambda (header)
                    `(include-c-header ,(string-append "<" header ">")))
                  (cdr (car (cdr expr))))))))

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
        (error "Not defined")))))
