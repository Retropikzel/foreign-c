(define-library
  (foreign c)
  ;; SCHEME-primitives.scm must implement:
  ;; shared-object-load
  ;; define-c-procedure
  ;; c-u8-ref
  ;; c-u8-set!
  ;; c-pointer-ref
  ;; c-pointer-set!
  ;; c-null
  ;; c-null?
  (cond-expand
    ;(capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (scheme base)
                        (scheme write)
                        (scheme char)
                        (scheme file)
                        (scheme process-context)
                        (scheme inexact)
                        (scheme cxr)
                        (prefix (chezscheme) chezscheme-)
                        (only (chezscheme) syntax))
                (begin
                  (define-record-type <c-bytevector>
                    (internal-make-c-bytevector pointer)
                    c-bytevector?
                    (pointer c-bytevector-pointer)))
                (include "c/primitives/chezscheme.scm")
                (export chezscheme-foreign-procedure
                        c-bytevector-null))
    (chibi (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact))
           (include-shared "c/primitives/chibi")
           (include "c/primitives/chibi.scm")
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
             (include "c/primitives/chicken.scm"))
    ;; TODO
    ;(cyclone (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/primitives/cyclone.scm"))
    ;; TODO
    ;(gambit (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/primitives/gambit-primitives.scm"))
    ;; TODO
    (gauche (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (scheme eval)
                    (only (gauche keyword) :info-alist)
                    (prefix (gauche base) gauche-)
                    (prefix (gauche ffi) gauche-)
                    (prefix (gauche uvector) gauche-)
                    (prefix (gauche btype) gauche-)
                    (prefix (gauche ffi native) gauche-)
                    (gauche ffi ffiaux)
                    )
            (include "c/primitives/gauche.scm")
            (export gauche-:init-function
                    :info-alist
                    gauche-with-ffi
                    gauche-dynamic-load
                    gauche-define-c-function
                    ;type->native-type
                    aggregate-type?)
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer))))
    ;(guile (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact) (prefix (system foreign) guile-) (prefix (system foreign-library) guile-) (prefix (rnrs bytevectors) guile-)) (begin (define-record-type <c-bytevector> (internal-make-c-bytevector pointer) c-bytevector?  (pointer c-bytevector-pointer))) (include "c/primitives/guile.scm"))
    (ikarus (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (prefix (ikarus foreign) ikarus-))
           (begin
               (define-record-type <c-bytevector>
                 (internal-make-c-bytevector pointer)
                 c-bytevector?
                 (pointer c-bytevector-pointer)))
            (include "c/primitives/ikarus.scm"))
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
                (include "c/primitives/ironscheme.scm"))
    (kawa (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (prefix (kawa reflect) kawa-))
          (begin
            (define-record-type <c-bytevector>
              (internal-make-c-bytevector pointer)
              c-bytevector?
              (pointer c-bytevector-pointer)))
          (include "c/primitives/kawa.scm"))
    ;; TODO
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;; TODO
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (prefix (mosh ffi) mosh-))
          (begin
            (define-record-type <c-bytevector>
              (internal-make-c-bytevector pointer)
              c-bytevector?
              (pointer c-bytevector-pointer)))
          (include "c/primitives/mosh.scm"))
    (racket (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (prefix (ffi winapi) racket-)
                    (prefix (compatibility mlist) racket-)
                    (prefix (ffi unsafe) racket-)
                    (prefix (ffi vector) racket-))
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
            (include "c/primitives/racket.scm"))
    (sagittarius (import (scheme base)
                         (scheme write)
                         (scheme char)
                         (scheme file)
                         (scheme process-context)
                         (scheme inexact)
                         (prefix (sagittarius ffi) sagittarius-))
                 (begin
                   (define-record-type <c-bytevector>
                     (internal-make-c-bytevector pointer)
                     c-bytevector?
                     (pointer c-bytevector-pointer)))
                 (include "c/primitives/sagittarius.scm"))
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
            (include "c/primitives/stklos.scm")
            (export make-external-function
                    free-bytes
                    file-exists?
                    c-pointer-set!
                    c-pointer-ref
                    internal-make-c-array-type
                    internal-make-c-struct-type
                    internal-c-struct-type-member
                    calculate-struct-members
                    get-environment-variable))

    (tr7 (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact))
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
             (include "c/primitives/tr7.scm"))
    (ypsilon (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact)
                     (prefix (ypsilon c-ffi) ypsilon-)
                     (prefix (ypsilon c-types) ypsilon-)
                     (prefix (core) ypsilon-))
            (begin
              (define-record-type <c-bytevector>
                (internal-make-c-bytevector pointer)
                c-bytevector?
                (pointer c-bytevector-pointer)))
             (include "c/primitives/ypsilon.scm")
             (export ypsilon-c-function
                     ypsilon-bytevector-c-int8-set!
                     ypsilon-bytevector-c-uint8-ref)))
  (export
    c-integer-type?
    c-char-type?
    c-float-type?
    c-double-type?
    c-signed-type?
    c-pointer-type?
    c-array-type?
    c-struct-type?

    c-type-size
    c-type-align

    define-c-array-type
    define-c-struct-type

    ;; Libraries and procedures
    define-c-library
    define-c-procedure

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

    argument->native-value ;; TODO remove from exports
    )
  (include "c/types.scm")
  (include "c/c-bytevector.scm")
  (include "c/argument-to-native-value.scm")
  (include "c/call-with-address-of.scm")
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
          (kawa-invoke-static java.lang.foreign.MemorySegment 'ofAddress address))
        (define (c-memset-pointer->address pointer value offset)
          (kawa-invoke pointer 'address))))
    (else (include "c/libc.scm"))))

