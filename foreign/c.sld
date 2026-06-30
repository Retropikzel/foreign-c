(define-library
  (foreign c)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme process-context)
          (scheme inexact)
          (scheme cxr))
  (begin
    (define-record-type <c-bytevector>
      (internal-make-c-bytevector pointer)
      c-bytevector?
      (pointer c-bytevector-pointer)))
  (cond-expand
    (capy (import (prefix (core foreign) capy-)
                  (prefix (core foreign-library) capy-))
                (include "c/primitives/capyscheme.scm"))
    (chezscheme (import (prefix (chezscheme) chezscheme-)
                        (only (chezscheme) syntax))
                (include "c/primitives/chezscheme.scm")
                (export chezscheme-foreign-procedure
                        c-bytevector-null))
    (chibi (include-shared "c/primitives/chibi")
           (include "c/primitives/chibi.scm"))
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
                     shared-object-load
                     define-c-procedure
                     bytevector-mod
                     bytevector-div)
             (include "c/primitives/chicken.scm"))
    ;; TODO
    ;(cyclone (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/primitives/cyclone.scm"))
    ;; TODO
    ;(gambit (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) (include "c/primitives/gambit-primitives.scm"))
    ;; TODO
    (gauche (import (only (gauche keyword) :info-alist)
                    (prefix (gauche base) gauche-)
                    (prefix (gauche ffi) gauche-)
                    (prefix (gauche uvector) gauche-)
                    (prefix (gauche native-type) gauche-)
                    (prefix (gauche ffi native) gauche-)
                    (gauche ffi ffiaux))
            (include "c/primitives/gauche.scm")
            (export gauche-:init-function
                    :info-alist
                    gauche-with-ffi
                    gauche-dynamic-load
                    gauche-define-c-function
                    ;type->native-type
                    aggregate-type?))
    ;(guile (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact) (prefix (system foreign) guile-) (prefix (system foreign-library) guile-) (prefix (rnrs bytevectors) guile-))  (include "c/primitives/guile.scm"))
    (ikarus (import (prefix (ikarus foreign) ikarus-))
            (include "c/primitives/ikarus.scm"))
    (ironscheme (import (ironscheme clr)
                        (ironscheme clr internal)
                        (ironscheme ffi))
                (include "c/primitives/ironscheme.scm"))
    (kawa (import (prefix (kawa reflect) kawa-))
          (include "c/primitives/kawa.scm"))
    ;; TODO
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;; TODO
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (prefix (mosh ffi) mosh-))
          (include "c/primitives/mosh.scm"))
    (racket (import (prefix (ffi winapi) racket-)
                    (prefix (compatibility mlist) racket-)
                    (prefix (ffi unsafe) racket-)
                    (prefix (ffi vector) racket-))
            (include "c/primitives/racket.scm"))
    (sagittarius (import (prefix (sagittarius ffi) sagittarius-))
                 (include "c/primitives/sagittarius.scm"))
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

    (tr7 (include "c/primitives/tr7.scm"))
    (ypsilon (import (prefix (ypsilon c-ffi) ypsilon-)
                     (prefix (ypsilon c-types) ypsilon-)
                     (prefix (core) ypsilon-))
             (include "c/primitives/ypsilon.scm")
             (export ypsilon-c-function
                     ypsilon-bytevector-c-int8-set!
                     ypsilon-bytevector-c-uint8-ref)))
  (export c-integer-type?
          c-char-type?
          c-float-type?
          c-double-type?
          c-signed-type?
          c-pointer-type?
          c-array-type?
          c-struct-type?

          c-type-size
          c-type-size+
          c-type-size*
          c-type-size-
          c-type-align
          c-type-align+
          c-type-align*
          c-type-align-

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
          null-byte

          ;; Pass pointer by address
          call-with-address-of

          ;; Arrays
          define-c-array-type

          ;; Structs
          define-c-struct-type

          ;; Callbacks
          define-c-callback
          pointer->c-bytevector

          argument->native-value ;; TODO remove from exports
          )
  (include "c/c-struct.scm")
  (include "c/c-array.scm")
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
    (capy
      (begin
        (define-c-library libc '("stdlib.h" "stdio.h" "string.h") #f '())
        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define-c-procedure
          c-memset-address->pointer libc 'memset 'pointer '(u64 int int))
        (define (c-memset-pointer->address pointer value offset)
          (capy-pointer-address pointer)))
      )
    (chicken
      (begin
        (define-c-library libc '("stdlib.h" "stdio.h" "string.h") #f '())
        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset)
          (address->pointer address))
        (define (c-memset-pointer->address pointer value offset)
          (pointer->address pointer))))
    (kawa
      (begin
        (define-c-library libc '("stdlib.h" "stdio.h" "string.h") #f '())
        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset)
          (kawa-invoke-static java.lang.foreign.MemorySegment
                              'ofAddress
                              address))
        (define (c-memset-pointer->address pointer value offset)
          (kawa-invoke pointer 'address))))
    (else (include "c/libc.scm"))))

