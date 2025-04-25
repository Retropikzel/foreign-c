(define-library
  (retropikzel pffi) ; (foreign r7rs)? (foreign c)?
  (cond-expand
    (chibi
      (import (except (scheme base) bytevector-copy!)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chibi ast)
              (chibi)
              (r6rs bytevectors))
      (include-shared "pffi/chibi-pffi"))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chicken base)
              (chicken foreign)
              (chicken locative)
              (chicken syntax)
              (chicken memory)
              (chicken random)
              (r6rs bytevectors)))
    (cyclone
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (cyclone foreign)
              (scheme cyclone primitives)
              (r6rs bytevectors)))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (only (gambit) c-declare c-lambda c-define define-macro)
              (r6rs bytevectors)))
    (gauche
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (gauche base)
              (retropikzel pffi gauche)
              (r6rs bytevectors)))
    (gerbil
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (r6rs bytevectors)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (system foreign)
              (system foreign-library)
              (only (guile) include-from-path)
              (rnrs bytevectors)))
    (kawa
      (import (except (scheme base) bytevector-copy bytevector-copy!)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (r6rs bytevectors)))
    (larceny
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (rename (primitives r5rs:require) (r5rs:require require))
              (primitives std-ffi)
              (primitives foreign-procedure)
              (primitives foreign-file)
              (primitives foreign-stdlib)
              (r6rs bytevectors)))
    (mosh
      (import (except (scheme base) bytevector-copy!)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (mosh ffi)
              (r6rs bytevectors)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (only (racket base) system-type)
              (ffi winapi)
              (compatibility mlist)
              (ffi unsafe)
              (ffi vector)
              (except (r6rs bytevectors) bytevector-copy!)))
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (except (sagittarius ffi) c-free c-malloc)
              (sagittarius)
              (r6rs bytevectors)))
    (skint
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (r6rs bytevectors)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (only (stklos)
                    make-external-function
                    allocate-bytes
                    free-bytes
                    cpointer?
                    cpointer-null?
                    cpointer-data
                    cpointer-data-set!
                    pointer-set-c-int8_t!
                    pointer-ref-c-int8_t
                    pointer-set-c-uint8_t!
                    pointer-ref-c-uint8_t
                    pointer-set-c-int16_t!
                    pointer-ref-c-int16_t
                    pointer-set-c-uint16_t!
                    pointer-ref-c-uint16_t
                    pointer-set-c-int32_t!
                    pointer-ref-c-int32_t
                    pointer-set-c-uint32_t!
                    pointer-ref-c-uint32_t
                    pointer-set-c-int64_t!
                    pointer-ref-c-int64_t
                    pointer-set-c-uint64_t!
                    pointer-ref-c-uint64_t
                    pointer-set-c-char!
                    pointer-ref-c-char
                    pointer-set-c-short!
                    pointer-ref-c-short
                    pointer-set-c-unsigned-short!
                    pointer-ref-c-unsigned-short
                    pointer-set-c-int!
                    pointer-ref-c-int
                    pointer-set-c-unsigned-int!
                    pointer-ref-c-unsigned-int
                    pointer-set-c-long!
                    pointer-ref-c-long
                    pointer-set-c-unsigned-long!
                    pointer-ref-c-unsigned-long
                    pointer-set-c-float!
                    pointer-ref-c-float
                    pointer-set-c-double!
                    pointer-ref-c-double
                    pointer-set-c-pointer!
                    pointer-ref-c-pointer
                    void?)
              (r6rs bytevectors))
      (export make-external-function
              calculate-struct-size-and-offsets
              struct-make
              pffi:string-split))
    (tr7
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (r6rs bytevectors)))
    (ypsilon
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (ypsilon c-ffi)
              (ypsilon c-types)
              (only (core) define-macro syntax-case)
              (except (rnrs bytevectors)
                      bytevector-copy!
                      bytevector-copy
                      string->utf8
                      utf8->string))))
  (export ;; Primitives
          c-size-of
          define-c-library
          define-c-procedure
          ;pffi-define-callback; define-c-callback (?)
          c-bytevector?
          pffi-pointer-set!;c-bytevector-u8-set! and so on
          pffi-pointer-get;c-bytevector-u8-ref and so on

          ;; c-bytevector
          make-c-bytevector
          c-bytevector ;; TODO Documentation, Testing
          make-c-null
          c-null?
          c-free
          c-bytevector-string-length ;; TODO Documentation, Testing
          bytevector->c-bytevector
          c-bytevector->bytevector
          call-with-address-of-c-bytevector ;; Todo Documentation
          string->c-bytevector
          c-bytevector->string

          ;c-bytevector-u8-ref ;; TODO Documentation, Testing

          ;; c-struct
          pffi-define-struct;define-c-struct
          pffi-struct-pointer;c-struct-bytevector
          pffi-struct-offset-get;c-struct-offset
          pffi-struct-set!;c-struct-set!
          pffi-struct-get;c-struct-get

          ;; c-array
          ;define-c-array (?)
          pffi-array-allocate;make-c-array
          pffi-array-pointer;c-array-pointer
          pffi-array?;c-array?
          pffi-pointer->array;c-bytevector->array
          pffi-array-get;c-array-get
          pffi-array-set!;c-array-set!
          pffi-list->array;list->c-array
          pffi-array->list;c-array->list

          ;; c-variable
          ;define-c-variable (?)
          )
  (cond-expand
    (chibi (include "pffi/chibi.scm"))
    (chicken-5 (export foreign-declare
                       foreign-safe-lambda
                       void)
               (include "pffi/chicken.scm"))
    (chicken-6 (include-relative "pffi/chicken.scm"))
    (cyclone (export calculate-struct-size-and-offsets
                     struct-make)
             (include "pffi/cyclone.scm"))
    (gambit (include "pffi/gambit.scm"))
    (gauche (include "pffi/gauche.scm"))
    (gerbil (include "pffi/gerbil.scm"))
    (guile (include "pffi/guile.scm"))
    (kawa (include "pffi/kawa.scm"))
    (larceny (include "pffi/larceny.scm"))
    (mosh (include "pffi/mosh.scm"))
    (racket (include "pffi/racket.scm"))
    (sagittarius (include "pffi/sagittarius.scm"))
    (skint (include "pffi/skint.scm"))
    (stklos (include "pffi/stklos.scm"))
    (tr7 (include "pffi/tr7.scm"))
    (ypsilon (export c-function)
             (include "pffi/ypsilon.scm")))
  (cond-expand
    (chicken-6 (include-relative "pffi/shared/main.scm")
               (include-relative "pffi/shared/pointer.scm")
               (include-relative "pffi/shared/array.scm")
               (include-relative "pffi/shared/struct.scm"))
    (else (include "pffi/shared/main.scm")
          (include "pffi/shared/struct.scm")
          (include "pffi/shared/pointer.scm")
          (include "pffi/shared/array.scm"))))
