(define-library
  (foreign c)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme process-context)
          (scheme inexact))
  ;; SCHEME-primitives.scm must implement:
  ;; size-of-type
  ;; align-of-type
  ;; shared-object-load
  ;; define-c-procedure
  ;; c-bytevector?
  ;; c-bytevector-u8-ref
  ;; c-bytevector-u8-set!
  ;; c-bytevector-pointer-ref
  ;; c-bytevector-pointer-set!
  ;; make-c-null
  ;; c-null?
  (cond-expand
    (capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (foreign c chezscheme-primitives))
                (export foreign-procedure))
    (chibi (include-shared "c/chibi-primitives")
           (include "c/chibi-primitives.scm"))
    (chicken (import (chicken base)
                     (chicken foreign)
                     (chicken locative)
                     (chicken syntax)
                     (chicken memory)
                     (chicken random))
             (export foreign-declare
                     foreign-safe-lambda
                     foreign-value
                     unspecified
                     u8->s8
                     s8->u8
                     shared-object-load
                     define-c-procedure)
             (include "c/chicken-primitives.scm"))
    ;(cyclone (import (foreign c cyclone-primitives)))
    ;(gambit (import (foreign c gambit-primitives)))
    (gauche (import (rename (gauche ffi)
                            (size-of-type gauche:size-of-type)
                            (align-of-type gauche:align-of-type)))
            (include "c/gauche-primitives.scm"))
    (guile (import (system foreign)
                   (system foreign-library))
           ;; TODO Fix guile include bug
           ;(include "c/guile-primitives.scm")
           (begin
             (define (primitives-init set-procedure get-procedure)
               #t)

             (define os 'unix)
             (define implementation 'guile)
             (define arch 'x86_64)
             (define libc-name "c")

             (define type->native-type
               (lambda (type)
                 (cond ((equal? type 'i8) int8)
                       ((equal? type 'u8) uint8)
                       ((equal? type 'i16) int16)
                       ((equal? type 'u16) uint16)
                       ((equal? type 'i32) int32)
                       ((equal? type 'u32) uint32)
                       ((equal? type 'i64) int64)
                       ((equal? type 'u64) uint64)
                       ((equal? type 'char) int8)
                       ((equal? type 'uchar) uint8)
                       ((equal? type 'short) short)
                       ((equal? type 'ushort) unsigned-short)
                       ((equal? type 'int) int)
                       ((equal? type 'uint) unsigned-int)
                       ((equal? type 'long) long)
                       ((equal? type 'ulong) unsigned-long)
                       ((equal? type 'float) float)
                       ((equal? type 'double) double)
                       ((equal? type 'pointer) '*)
                       ((equal? type 'void) void)
                       ((equal? type 'callback) '*)
                       (else #f))))

             (define c-bytevector?
               (lambda (object)
                 (pointer? object)))

             (define-syntax define-c-procedure
               (syntax-rules ()
                 ((_ scheme-name shared-object c-name return-type argument-types)
                  (define scheme-name
                    (pointer->procedure (type->native-type return-type)
                                        (foreign-library-pointer shared-object
                                                                 (symbol->string c-name))
                                        (map type->native-type argument-types))))))

             (define-syntax define-c-callback
               (syntax-rules ()
                 ((_ scheme-name return-type argument-types procedure)
                  (define scheme-name
                    (procedure->pointer (type->native-type return-type)
                                        procedure
                                        (map type->native-type argument-types))))))

             (define size-of-type
               (lambda (type)
                 (let ((native-type (type->native-type type)))
                   (cond ((equal? native-type void) 0)
                         (native-type (sizeof native-type))
                         (else #f)))))

             (define align-of-type
               (lambda (type)
                 (let ((native-type (type->native-type type)))
                   (cond ((equal? native-type void) 0)
                         (native-type (alignof native-type))
                         (else #f)))))

             (define shared-object-load
               (lambda (path options)
                 (load-foreign-library path)))

             (define (c-bytevector-u8-set! cbv offset byte)
               (bytevector-u8-set! (pointer->bytevector cbv (+ offset 100)) offset byte))

             (define (c-bytevector-u8-ref cbv offset)
               (bytevector-u8-ref (pointer->bytevector cbv (+ offset 100)) offset))

             (define (c-bytevector-pointer-set! cbv offset pointer)
               (bytevector-uint-set! (pointer->bytevector cbv (+ offset 100))
                                     offset
                                     (pointer-address pointer)
                                     (native-endianness)
                                     (size-of-type 'uint)))

             (define (c-bytevector-pointer-ref cbv offset)
               (make-pointer (bytevector-uint-ref (pointer->bytevector cbv (+ offset 100))
                                                  offset
                                                  (native-endianness)
                                                  (size-of-type 'uint))))

             (define (make-c-null) (make-pointer (pointer-address %null-pointer)))

             (define (c-null? pointer)
               (and (pointer? pointer)
                    (null-pointer? pointer)))))
    (ikarus (import (ikarus foreign))
            (include "c/ikarus-primitives.scm"))
    (ironscheme (import (ironscheme clr)
                        (ironscheme clr internal)
                        (ironscheme ffi))
                (include "c/ironscheme-primitives.scm"))
    (kawa (include "c/kawa-primitives.scm"))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (mosh ffi))
          (include "c/mosh-primitives.scm"))
    (racket (import (ffi winapi)
                    (compatibility mlist)
                    (ffi unsafe)
                    (ffi vector))
            (include "c/racket-primitives.scm"))
    (sagittarius (import (except (sagittarius ffi)
                                 c-free
                                 c-malloc
                                 define-c-struct))
                 (include "c/sagittarius-primitives.scm"))
    (stklos (import (only (stklos)
                          %make-callback
                          make-external-function
                          allocate-bytes
                          free-bytes
                          cpointer?
                          cpointer-null?
                          cpointer-data
                          cpointer-data-set!
                          cpointer-set-abs!
                          cpointer-ref-abs
                          c-size-of
                          void?))
            (include "c/stklos-primitives.scm")
            (export make-external-function
                    free-bytes
                    file-exists?
                    c-bytevector-pointer-set!
                    c-bytevector-pointer-ref))
    (ypsilon (import (ypsilon c-ffi)
                     (ypsilon c-types)
                     (only (core)
                           define-macro
                           syntax-case
                           bytevector-c-int8-set!
                           bytevector-c-uint8-ref))
             (include "c/ypsilon-primitives.scm")
             (export c-function
                     bytevector-c-int8-set!
                     bytevector-c-uint8-ref)))
  (export
    ;; Types
    c-type-size
    c-type-align

    ;; Libraries and procedures
    define-c-library
    define-c-procedure
    ;define-c-callback ;; TODO

    ;; c-bytevectors
    make-c-bytevector
    c-bytevector
    c-bytevector?
    c-free
    make-c-null
    c-null?
    c-bytevector-set!
    c-bytevector-ref
    bytevector->c-bytevector
    c-bytevector->bytevector
    c-bytevector->integer
    integer->c-bytevector

    ;; Strings
    string->c-utf8
    c-utf8->string

    ;; Pass pointer by address
    call-with-address-of

    ;; Structs
    define-c-struct

    ;; Utilities
    libc-name

    ;; endianness
    native-endianness)
  (cond-expand
    (chezscheme
      (import (only (rnrs bytevectors) native-endianness)))
    (r6rs
      (import (only (rnrs bytevectors) native-endianness)))
    (guile
      (import (only (rnrs bytevectors) native-endianness)))
    (else
      (begin
        (define (native-endianness)
          (cond-expand (big-endian 'big) (else 'little))))))
  (cond-expand
    (chicken
      (begin
        (define-syntax define-c-library
          (syntax-rules ()
            ((_ scheme-name headers object-name options)
             (begin
               (define scheme-name #t)
               (shared-object-load headers)))))))
    (else (include "c/define-c-library.scm")))
  (cond-expand
    (chicken
      (begin
        (define libc-name
          (cond-expand
            (windows "ucrtbase")
            (haiku "root")
            (else "c")))
        (define-c-library libc
                          '("stdlib.h" "stdio.h" "string.h")
                          libc-name
                          '((additional-versions ("0" "6"))))

        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset) (address->pointer address))
        (define (c-memset-pointer->address pointer value offset) (pointer->address pointer))))
    (else (include "c/libc.scm")))
  (cond-expand
    #;(chicken
      ;; FIXME These are in primitives too but error
      (begin
        (define (make-c-null) (foreign-value "NULL" c-pointer))
        (define c-null?
          (lambda (pointer)
            (if (and (not (pointer? pointer))
                     pointer)
              #f
              (or (not pointer) ; #f counts as null pointer on Chicken
                  (= (pointer->address pointer) 0)))))))
    (else))
  (include "c.scm"))

