(define-library
  (retropikzel pffi v0-1-0 sagittarius)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme process-context)
          (sagittarius ffi)
          (sagittarius))
  (export pffi-shared-object-load
          pffi-define
          pffi-size-of
          pffi-pointer-allocate
          pffi-pointer-null
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer->bytevector
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-pointer-set!
          pffi-pointer-get
          pffi-pointer-deref)
  (begin

    (define pffi-type->native-type
      (lambda (type)
        (cond ((equal? type 'int8) 'int8_t)
              ((equal? type 'uint8) 'uint8_t)
              ((equal? type 'int16) 'int16_t)
              ((equal? type 'uint16) 'uint16_t)
              ((equal? type 'int32) 'int32_t)
              ((equal? type 'uint32) 'uint32_t)
              ((equal? type 'int64) 'int64_t)
              ((equal? type 'uint64) 'uint64_t)
              ((equal? type 'char) 'char)
              ((equal? type 'unsigned-char) 'char)
              ((equal? type 'short) 'short)
              ((equal? type 'unsigned-short) 'unsigned-short)
              ((equal? type 'int) 'int)
              ((equal? type 'unsigned-int) 'unsigned-int)
              ((equal? type 'long) 'long)
              ((equal? type 'unsigned-long) 'unsigned-long)
              ((equal? type 'float) 'float)
              ((equal? type 'double) 'double)
              ((equal? type 'pointer) 'void*)
              ((equal? type 'string) 'void*)
              ((equal? type 'void) 'void)
              (else (error "pffi-type->native-type -- No such pffi type" type)))))

    (define pffi-pointer? (lambda (object) (pointer? object)))

    (define-syntax pffi-define
      (syntax-rules ()
        ((pffi-define scheme-name shared-object c-name return-type argument-types)
         (define scheme-name
           (make-c-function shared-object
                            (pffi-type->native-type return-type)
                            c-name
                            (map pffi-type->native-type argument-types))))))

    (define pffi-size-of
      (lambda (type)
        (cond ((eq? type 'int8) size-of-int8_t)
              ((eq? type 'uint8) size-of-uint8_t)
              ((eq? type 'int16) size-of-int16_t)
              ((eq? type 'uint16) size-of-uint16_t)
              ((eq? type 'int32) size-of-int32_t)
              ((eq? type 'uint32) size-of-uint32_t)
              ((eq? type 'int64) size-of-int64_t)
              ((eq? type 'uint64) size-of-uint64_t)
              ((eq? type 'char) size-of-char)
              ((eq? type 'unsigned-char) size-of-char)
              ((eq? type 'short) size-of-short)
              ((eq? type 'unsigned-short) size-of-unsigned-short)
              ((eq? type 'int) size-of-int)
              ((eq? type 'unsigned-int) size-of-unsigned-int)
              ((eq? type 'long) size-of-long)
              ((eq? type 'unsigned-long) size-of-unsigned-long)
              ((eq? type 'float) size-of-float)
              ((eq? type 'double) size-of-double)
              ((eq? type 'string) size-of-void*)
              ((eq? type 'pointer) size-of-void*)
              (else (error "Can not get size of unknown type" type)))))

    (define pffi-pointer-allocate
      (lambda (size)
        (allocate-pointer size)))

    (define pffi-pointer-null
      (lambda ()
        (integer->pointer 0)))

    (define pffi-string->pointer
      (lambda (string-content)
        (bytevector->pointer (string->utf8 (string-copy string-content)))))

    (define pffi-pointer->string
      (lambda (pointer)
        (pointer->string pointer)))

    (define pffi-pointer->bytevector
      (lambda (pointer size)
        (pointer->bytevector pointer size)))

    (define pffi-shared-object-load
      (lambda (header path)
        (open-shared-library path)))

    (define pffi-pointer-free
      (lambda (pointer)
        (c-free pointer)))

    (define pffi-pointer-null?
      (lambda (pointer)
        (null-pointer? pointer)))

    (define pffi-pointer-set!
      (lambda (pointer type offset value)
        (let ((p pointer))
          (cond ((equal? type 'int8) (pointer-set-c-int8_t! p offset value))
                ((equal? type 'uint8) (pointer-set-c-uint8_t! p offset value))
                ((equal? type 'int16) (pointer-set-c-int16_t! p offset value))
                ((equal? type 'uint16) (pointer-set-c-uint16_t! p offset value))
                ((equal? type 'int32) (pointer-set-c-int32_t! p offset value))
                ((equal? type 'uint32) (pointer-set-c-uint32_t! p offset value))
                ((equal? type 'int64) (pointer-set-c-int64_t! p offset value))
                ((equal? type 'uint64) (pointer-set-c-uint64_t! p offset value))
                ((equal? type 'intptr) (pointer-set-c-intptr_t! p offset value))
                ((equal? type 'uintptr) (pointer-set-c-uintptr_t! p offset value))
                ((equal? type 'char) (pointer-set-c-char! p offset value))
                ((equal? type 'short) (pointer-set-c-short! p offset value))
                ((equal? type 'unsigned-short) (pointer-set-c-unsigned-short! p offset value))
                ((equal? type 'int) (pointer-set-c-int! p offset value))
                ((equal? type 'unsigned-int) (pointer-set-c-unsigned-int! p offset value))
                ((equal? type 'long) (pointer-set-c-long! p offset value))
                ((equal? type 'unsigned-long) (pointer-set-c-unsigned-long! p offset value))
                ((equal? type 'float) (pointer-set-c-float! p offset value))
                ((equal? type 'double) (pointer-set-c-double! p offset value))
                ((equal? type 'void) (pointer-set-c-void*! p offset value))))))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (let ((p pointer)
              (native-type (pffi-type->native-type type)))
          (cond ((equal? native-type 'int8_t) (pointer-ref-c-int8_t p offset))
                ((equal? native-type 'uint8_t) (pointer-ref-c-uint8_t p offset))
                ((equal? native-type 'int16_t) (pointer-ref-c-int16_t p offset))
                ((equal? native-type 'uint16_t) (pointer-ref-c-uint16_t p offset))
                ((equal? native-type 'int32_t) (pointer-ref-c-int32_t p offset))
                ((equal? native-type 'uint32_t) (pointer-ref-c-uint32_t p offset))
                ((equal? native-type 'int64_t) (pointer-ref-c-int64_t p offset))
                ((equal? native-type 'uint64_t) (pointer-ref-c-uint64_t p offset))
                ((equal? native-type 'intptr_t) (pointer-ref-c-intptr_t p offset))
                ((equal? native-type 'uintptr_t) (pointer-ref-c-uintptr_t p offset))
                ((equal? native-type 'char) (pointer-ref-c-char p offset))
                ((equal? native-type 'short) (pointer-set-c-short p offset value))
                ((equal? native-type 'unsigned-short) (pointer-ref-c-unsigned-short p offset))
                ((equal? native-type 'int) (pointer-ref-c-int p offset))
                ((equal? native-type 'unsigned-int) (pointer-ref-c-unsigned-int p offset))
                ((equal? native-type 'long) (pointer-ref-c-long p offset))
                ((equal? native-type 'unsigned-long) (pointer-ref-c-unsigned-long p offset))
                ((equal? native-type 'float) (pointer-ref-c-float p offset))
                ((equal? native-type 'double) (pointer-ref-c-double p offset))
                ((equal? native-type 'void*) (pointer-ref-c-void* p offset))))))

    (define pffi-pointer-deref
      (lambda (pointer)
        (deref pointer 0)))))
