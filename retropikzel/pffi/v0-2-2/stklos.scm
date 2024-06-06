(define-library
  (retropikzel pffi v0-2-1 stklos)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme process-context)
          (stklos))
  (export pffi-define
          pffi-pointer->string
          pffi-pointer-allocate
          pffi-pointer-deref
          pffi-pointer-free
          pffi-pointer-get
          pffi-pointer-null
          pffi-pointer-null?
          pffi-pointer-set!
          pffi-pointer?
          pffi-shared-object-load
          pffi-size-of
          pffi-string->pointer)
  (begin

    (define pffi-type->native-type
      (lambda (type)
        (cond ((equal? type 'int8) :int)
              ((equal? type 'uint8) :uint)
              ((equal? type 'int16) :int)
              ((equal? type 'uint16) :uint)
              ((equal? type 'int32) :int)
              ((equal? type 'uint32) :uint)
              ((equal? type 'int64) :int)
              ((equal? type 'uint64) :uint)
              ((equal? type 'char) :char)
              ((equal? type 'unsigned-char) :uchar)
              ((equal? type 'short) :short)
              ((equal? type 'unsigned-short) :ushort)
              ((equal? type 'int) :int)
              ((equal? type 'unsigned-int) :uint)
              ((equal? type 'long) :long)
              ((equal? type 'unsigned-long) :ulong)
              ((equal? type 'float) :float)
              ((equal? type 'double) :double)
              ((equal? type 'pointer) :pointer)
              ((equal? type 'string) :string)
              ((equal? type 'void) :void)
              (else (error "pffi-type->native-type -- No such pffi type" type)))))

    (define pffi-pointer?
      (lambda (object)
        (cpointer? object)))

    (define-syntax pffi-define
      (syntax-rules ()
        ((pffi-define scheme-name shared-object c-name return-type argument-types)
         (define scheme-name
           (make-external-function
             (symbol->string c-name)
             (map pffi-type->native-type argument-types)
             (pffi-type->native-type return-type)
             shared-object)))))


    (define pffi-size-of
      (lambda (type)
        (error "Not implemented")))

    (define pffi-pointer-allocate
      (lambda (size)
        (allocate-bytes size)))

    (define pffi-pointer-null
      (lambda ()
        (let ((p (allocate-bytes 0))) (cpointer-data-set! p 0) p)))

    (define pffi-string->pointer
      (lambda (string-content)
        string-content))

    (define pffi-pointer->string
      (lambda (pointer)
        pointer))

    (define pffi-shared-object-load
      (lambda (header path)
        path))

    (define pffi-pointer-free
      (lambda (pointer)
        (free-bytes pointer)))

    (define pffi-pointer-null?
      (lambda (pointer)
        (cpointer-null? pointer)))

    (define pffi-pointer-set!
      (lambda (pointer type offset value)
        (error "Not implemented")))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (error "Not implemented")))

    (define pffi-pointer-deref
      (lambda (pointer)
        (error "Not implemented")))))
