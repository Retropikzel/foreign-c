(define-library
  (foreign c)
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
    ;(capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (chezscheme)
                        (srfi :0)
                        (srfi :98))
                (include "c/chezscheme-primitives.scm")
                (export foreign-procedure
                        type->native-type
                        make-c-null
                        c-null?))
    (chibi (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact))
           (include-shared "c/chibi-primitives")
           (include "c/chibi-primitives.scm"))
    (chicken (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact)
                     (chicken base)
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
    ;(gambit (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/gambit-primitives.scm"))
    ;(gauche (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) ;(rename (gauche ffi) (size-of-type gauche:size-of-type) (align-of-type gauche:align-of-type)) (include "c/gauche-primitives.scm"))
    (guile (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact)
                   (system foreign)
                   (system foreign-library)
                   (only (rnrs bytevectors)
                         bytevector-u64-native-set!
                         bytevector-u64-native-ref
                         native-endianness))
           (include "c/guile-primitives.scm"))
    (ikarus (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (ikarus foreign))
            (include "c/ikarus-primitives.scm"))
    (ironscheme (import (scheme base)
                        (scheme write)
                        (scheme char)
                        (scheme file)
                        (scheme process-context)
                        (scheme inexact)
                        (ironscheme clr)
                        (ironscheme clr internal)
                        (ironscheme ffi))
                (include "c/ironscheme-primitives.scm"))
    (kawa (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact))
          (include "c/kawa-primitives.scm"))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (mosh ffi))
          (include "c/mosh-primitives.scm"))
    (racket (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (ffi winapi)
                    (compatibility mlist)
                    (ffi unsafe)
                    (ffi vector))
            (include "c/racket-primitives.scm"))
    (sagittarius (import (scheme base)
                         (scheme write)
                         (scheme char)
                         (scheme file)
                         (scheme process-context)
                         (scheme inexact)
                         (except (sagittarius ffi)
                                 c-free
                                 c-malloc
                                 define-c-struct))
                 (include "c/sagittarius-primitives.scm"))
    (stklos (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (only (stklos)
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
                    c-bytevector-pointer-ref
                    calculate-struct-members
                    calculate-struct-size))
    (ypsilon (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact)
                     (ypsilon c-ffi)
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
    libc-name)
  (include "c-r6rs-bytevectors.scm")
  (include "c-types.scm")
  (include "c-bytevector.scm")
  (include "c-call-with-address-of.scm")
  (include "c-struct.scm")
  (cond-expand
    (chicken
      (begin
        (define-syntax define-c-library
          (syntax-rules ()
            ((_ scheme-name headers object-name options)
             (begin
               (define scheme-name #t)
               (shared-object-load headers)))))))
    (else (include "c-define-c-library.scm")))

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
    (else (include "c-libc.scm"))))

