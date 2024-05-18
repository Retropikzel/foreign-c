(define-library
  (retropikzel pffi v0-1-0 guile)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme process-context)
          (rnrs bytevectors)
          (system foreign)
          (system foreign-library))
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
        (cond ((equal? type 'int8) int8)
              ((equal? type 'uint8) uint8)
              ((equal? type 'int16) int16)
              ((equal? type 'uint16) uint16)
              ((equal? type 'int32) int32)
              ((equal? type 'uint32) uint32)
              ((equal? type 'int64) int64)
              ((equal? type 'uint64) uint64)
              ((equal? type 'char) int)
              ((equal? type 'unsigned-char) int)
              ((equal? type 'short) short)
              ((equal? type 'unsigned-short) unsigned-short)
              ((equal? type 'int) int)
              ((equal? type 'unsigned-int) unsigned-int)
              ((equal? type 'long) long)
              ((equal? type 'unsigned-long) unsigned-long)
              ((equal? type 'float) float)
              ((equal? type 'double) double)
              ((equal? type 'pointer) '*)
              ((equal? type 'string) '*)
              ((equal? type 'void) void)
              (else (error "pffi-type->native-type -- No such pffi type" type)))))

    (define pffi-pointer?
      (lambda (object)
        (pointer? object)))

    (define-syntax pffi-define
      (syntax-rules ()
        ((pffi-define scheme-name shared-object c-name return-type argument-types)
         (define scheme-name
           (foreign-library-function shared-object
                                     (symbol->string c-name)
                                     #:return-type (pffi-type->native-type return-type)
                                     #:arg-types (map pffi-type->native-type argument-types))))))


    (define pffi-size-of
      (lambda (type)
        (sizeof (pffi-type->native-type type))))

    (define pffi-pointer-allocate
      (lambda (size)
        (bytevector->pointer (make-bytevector size 0))))

    (define pffi-pointer-null
      (lambda ()
        (make-pointer 0)))

    (define pffi-string->pointer
      (lambda (string-content)
        (string->pointer string-content)))

    (define pffi-pointer->string
      (lambda (pointer)
        (pointer->string pointer)))

    (define pffi-shared-object-load
      (lambda (header path)
        (load-foreign-library path)))

    (define pffi-pointer-free
      (lambda (pointer)
        #t))

    (define pffi-pointer-null?
      (lambda (pointer)
        (and (pffi-pointer? pointer)
             (null-pointer? pointer))))

    (define pffi-pointer-set!
      (lambda (pointer type offset value)
        (let ((p (pointer->bytevector pointer (+ offset 100)))
              (native-type (pffi-type->native-type type)))
          (cond ((equal? native-type int8) (bytevector-s8-set! p offset value))
                ((equal? native-type uint8) (bytevector-u8-set! p offset value))
                ((equal? native-type int16) (bytevector-s16-set! p offset value (native-endianness)))
                ((equal? native-type uint16) (bytevector-u16-set! p offset value (native-endianness)))
                ((equal? native-type int32) (bytevector-s32-set! p offset value (native-endianness)))
                ((equal? native-type uint32) (bytevector-u32-set! p offset value (native-endianness)))
                ((equal? native-type int64) (bytevector-s64-set! p offset value (native-endianness)))
                ((equal? native-type uint64) (bytevector-u64-set! p offset value (native-endianness)))
                ((equal? native-type char) (bytevector-u8-set! p offset value))
                ((equal? native-type short) (bytevector-s8-set! p offset value))
                ((equal? native-type unsigned-short) (bytevector-u8-set! p offset value))
                ((equal? native-type int) (bytevector-sint-set! p offset value (native-endianness) (pffi-size-of type)))
                ((equal? native-type unsigned-int) (bytevector-uint-set! p offset value (native-endianness) (pffi-size-of type)))
                ((equal? native-type long) (bytevector-s64-set! p offset value (native-endianness)))
                ((equal? native-type unsigned-long) (bytevector-u64-set! p offset value (native-endianness)))
                ((equal? native-type float) (bytevector-u64-set! p offset value (native-endianness)))
                ((equal? native-type double) (bytevector-u64-set! p offset value (native-endianness)))
                ((equal? native-type '*) (bytevector-sint-set! p offset value (native-endianness) (pffi-size-of type)))))))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (let ((p (pointer->bytevector pointer (+ offset 100)))
              (native-type (pffi-type->native-type type)))
          (cond ((equal? native-type int8) (bytevector-s8-ref p offset))
                ((equal? native-type uint8) (bytevector-u8-ref p offset))
                ((equal? native-type int16) (bytevector-s16-ref p offset (native-endianness)))
                ((equal? native-type uint16) (bytevector-u16-ref p offset (native-endianness)))
                ((equal? native-type int32) (bytevector-s32-ref p offset (native-endianness)))
                ((equal? native-type uint32) (bytevector-u32-ref p offset (native-endianness)))
                ((equal? native-type int64) (bytevector-s64-ref p offset (native-endianness)))
                ((equal? native-type uint64) (bytevector-u64-ref p offset (native-endianness)))
                ((equal? native-type char) (bytevector-u8-ref p offset value))
                ((equal? native-type short) (bytevector-s8-ref p offset value))
                ((equal? native-type unsigned-short) (bytevector-u8-ref p offset value))
                ((equal? native-type int) (bytevector-sint-ref p offset (native-endianness) (pffi-size-of type)))
                ((equal? native-type unsigned-int) (bytevector-uint-ref p offset (native-endianness) (pffi-size-of type)))
                ((equal? native-type long) (bytevector-s64-ref p offset value (native-endianness)))
                ((equal? native-type unsigned-long) (bytevector-u64-ref p offset value (native-endianness)))
                ((equal? native-type float) (bytevector-u64-ref p offset value (native-endianness)))
                ((equal? native-type double) (bytevector-u64-ref p offset value (native-endianness)))
                ((equal? native-type '*) (bytevector-sint-ref p offset value (native-endianness) (pffi-size-of type)))))))))))

    (define pffi-pointer-deref
      (lambda (pointer)
        (dereference-pointer pointer)))))
