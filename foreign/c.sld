(define-library
  (foreign c)
  ;; SCHEME-primitives.scm must implement:
  ;; size-of-type
  ;; align-of-type
  ;; shared-object-load
  ;; define-c-procedure
  ;; c-u8-ref
  ;; c-u8-set!
  ;; c-pointer-ref
  ;; c-pointer-set!
  ;; c-null
  (cond-expand
    ;(capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (except (chezscheme)
                                native-endianness
                                endianness
                                remove)
                        (srfi :0)
                        (srfi :98))
                (begin
                  (define-record-type (<c-bytevector> internal-make-c-bytevector c-bytevector?)
                    (fields
                      (immutable pointer c-bytevector-pointer))))
                (include "c/chezscheme-primitives.scm")
                (export foreign-procedure
                        type->native-type
                        c-bytevector-null))
    (chibi (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact))
           (include-shared "c/chibi-primitives")
           (include "c/chibi-primitives.scm")
           (begin
             (define-record-type <c-bytevector>
               (internal-make-c-bytevector pointer)
               c-bytevector?
               (pointer c-bytevector-pointer))))
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
                     shared-object-load
                     define-c-procedure
                     bytevector-mod
                     bytevector-div)
             (begin
               (define-record-type <c-bytevector>
                 (internal-make-c-bytevector pointer)
                 c-bytevector?
                 (pointer c-bytevector-pointer)))
             (include "c/chicken-primitives.scm"))
    ;(cyclone (import (foreign c cyclone-primitives)))
    ;(gambit (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/gambit-primitives.scm"))
    ;; TODO
    (gauche (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact))
            (rename (gauche ffi)
                    (size-of-type gauche:size-of-type)
                    (align-of-type gauche:align-of-type))
            (include "c/gauche-primitives.scm"))
    ;; TODO r6rs tests
    ;; TODO r7rs tests
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
           (begin
               (define-record-type <c-bytevector>
                 (internal-make-c-bytevector pointer)
                 c-bytevector?
                 (pointer c-bytevector-pointer)))
           (include "c/guile-primitives.scm"))
    (ikarus (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (ikarus foreign))
           (begin
               (define-record-type <c-bytevector>
                 (internal-make-c-bytevector pointer)
                 c-bytevector?
                 (pointer c-bytevector-pointer)))
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
           (begin
               (define-record-type <c-bytevector>
                 (internal-make-c-bytevector pointer)
                 c-bytevector?
                 (pointer c-bytevector-pointer)))
                (include "c/ironscheme-primitives.scm"))
    (kawa (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (only (kawa reflect)
                        invoke
                        invoke-static
                        static-field
                        make))
          (begin
            (define-record-type <c-bytevector>
              (internal-make-c-bytevector pointer)
              c-bytevector?
              (pointer c-bytevector-pointer)))
          (include "c/kawa-primitives.scm"))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;(larceny (import (foreign c larceny-primitives)))
    ;; TODO r6rs tests
    (mosh (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (mosh ffi))
          (begin
            (define-record-type <c-bytevector>
              (internal-make-c-bytevector pointer)
              c-bytevector?
              (pointer c-bytevector-pointer)))
          (include "c/mosh-primitives.scm"))
    ; TODO r6rs tests
    ; TODO r7rs tests
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
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
            (include "c/racket-primitives.scm"))
    ;; TODO r6rs tests
    (sagittarius (import (scheme base)
                         (scheme write)
                         (scheme char)
                         (scheme file)
                         (scheme process-context)
                         (scheme inexact)
                         (except (sagittarius ffi)
                                 c-pointer
                                 c-free
                                 c-malloc
                                 define-c-struct))
                 (begin
                   (define-record-type <c-bytevector>
                     (internal-make-c-bytevector pointer)
                     c-bytevector?
                     (pointer c-bytevector-pointer)))
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
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
            (include "c/stklos-primitives.scm")
            (export make-external-function
                    free-bytes
                    file-exists?
                    c-pointer-set!
                    c-pointer-ref))
    ;; TODO r6rs tests
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
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
             (include "c/ypsilon-primitives.scm")
             (export c-function
                     bytevector-c-int8-set!
                     bytevector-c-uint8-ref)))
  (export
    ;; Types
    make-c-integer-type
    make-c-float-type
    make-c-pointer-type
    ;make-c-array-type ; TODO
    make-c-struct-type
    c-type-name
    c-type-name=?
    c-type-size
    c-type-size=?
    c-type-align
    c-type-align=?

    ;; Libraries and procedures
    define-c-library
    define-c-procedure
    ;define-c-callback ;; TODO

    ;; c-bytevectors
    make-c-bytevector
    internal-make-c-bytevector
    c-bytevector
    c-bytevector?
    c-bytevector-pointer
    c-bytevector-free
    c-bytevector-null
    c-bytevector-null?
    c-bytevector-set!
    c-bytevector-ref
    bytevector->c-bytevector
    c-bytevector->bytevector
    c-bytevector->integer
    integer->c-bytevector
    c-bytevector->list

    ;; Strings
    string->c-bytevector
    c-bytevector->string

    ;; Pass pointer by address
    call-with-address-of

    ;; Struct
    ;define-c-struct

    value->native-value ;; TODO remove from exports
    )
  (include "c/types.scm")
  (include "c-bytevector.scm")
  (include "c-value-to-native-value.scm")
  (include "c-call-with-address-of.scm")
  (include "c/struct2.scm")
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
        (define-c-library libc '("stdlib.h" "stdio.h" "string.h") #f '())
        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset) (address->pointer address))
        (define (c-memset-pointer->address pointer value offset) (pointer->address pointer))))
    (kawa
      (begin
        (define-c-library libc '("stdlib.h" "stdio.h" "string.h") #f '())
        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset)
          (invoke-static java.lang.foreign.MemorySegment 'ofAddress address))
        (define (c-memset-pointer->address pointer value offset) (invoke pointer 'address))))
    (else (include "c-libc.scm"))))

