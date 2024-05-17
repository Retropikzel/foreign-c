(define-library
  (retropikzel pffi v0-1-0 cyclone)
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
      (syntax-rules ()
        ((pffi-define msg)
         ;(define-c t "(void *data, int argc, closure _, object k, object h)" "puts(string_str(h));")
         ;(c-define puts int "puts" string)
         (c-code "char* buffer[1000]; fgets(buffer, 1000, stdin); puts(buffer);")
         #t
         )
        )
      )


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

    (define pffi-pointer->bytevector
      (lambda (pointer size)
        (error "Not defined")))

(define-syntax pffi-shared-object-load
  (syntax-rules ()
    ((when headers shared-object additional-paths)


     )))

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
