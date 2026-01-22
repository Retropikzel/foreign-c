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
    ;(capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (only (chezscheme)
                              syntax-case
                              syntax
                              identifier?
                              with-syntax
                              datum->syntax-object
                              datum
                              gensym
                              append!))
                (include "c/chezscheme-primitives.scm")
                (export foreign-procedure
                        type->native-type
                        make-c-null
                        c-null?))
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
           (include "c/guile-primitives.scm"))
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
    libc-name)
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
  (include "c.scm"))

