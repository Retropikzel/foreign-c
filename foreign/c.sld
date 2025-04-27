(define-library
  (foreign c)
  (cond-expand
    (chibi
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chibi ast)
              (scheme inexact)
              (chibi))
      (include-shared "c/lib/chibi"))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (chicken base)
              (chicken foreign)
              (chicken locative)
              (chicken syntax)
              (chicken memory)
              (chicken random)))
    #;(cyclone
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (cyclone foreign)
              (scheme cyclone primitives)))
    #;(gambit
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (only (gambit) c-declare c-lambda c-define define-macro)))
    (gauche
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (gauche base)
              (foreign c primitives gauche)))
    #;(gerbil
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (system foreign)
              (system foreign-library)
              (only (guile) include-from-path)))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)))
    #;(larceny
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (rename (primitives r5rs:require) (r5rs:require require))
              (primitives std-ffi)
              (primitives foreign-procedure)
              (primitives foreign-file)
              (primitives foreign-stdlib)
              (primitives system-interface)))
    (mosh
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme inexact)
              (scheme process-context)
              (mosh ffi)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (only (racket base) system-type)
              (ffi winapi)
              (compatibility mlist)
              (ffi unsafe)
              (ffi vector)))
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (except (sagittarius ffi) c-free c-malloc)
              (sagittarius)))
    #;(skint
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (only (stklos)
                    %make-callback
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
                    void?))
      (export ; calculate-struct-size-and-offsets
              ;struct-make
              foreign-c:string-split
              c-bytevector-pointer-set!
              c-bytevector-pointer-ref))
    #;(tr7
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              ;(scheme inexact)
              (scheme process-context)))
    (ypsilon
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (ypsilon c-ffi)
              (ypsilon c-types)
              (only (core) define-macro syntax-case))))
  (export ;; Primitives
          c-size-of
          define-c-library
          define-c-procedure
          define-c-callback
          c-bytevector?
          c-bytevector-u8-ref

          ;; c-bytevector
          native-endianness
          ;; TODO Docs for all of these
          c-bytevector->address
          address->c-bytevector
          c-bytevector-s8-set!
          c-bytevector-s8-ref
          c-bytevector-u8-set!
          c-bytevector-s16-set!
          c-bytevector-s16-native-set!
          c-bytevector-s16-ref
          c-bytevector-s16-native-ref
          c-bytevector-u16-set!
          c-bytevector-u16-native-set!
          c-bytevector-u16-ref
          c-bytevector-u16-native-ref
          c-bytevector-s32-set!
          c-bytevector-s32-native-set!
          c-bytevector-s32-ref
          c-bytevector-s32-native-ref
          c-bytevector-u32-set!
          c-bytevector-u32-native-set!
          c-bytevector-u32-ref
          c-bytevector-u32-native-ref
          c-bytevector-s64-set!
          c-bytevector-s64-native-set!
          c-bytevector-s64-ref
          c-bytevector-s64-native-ref
          c-bytevector-u64-set!
          c-bytevector-u64-native-set!
          c-bytevector-u64-ref
          c-bytevector-u64-native-ref
          c-bytevector-sint-set!
          c-bytevector-sint-ref
          c-bytevector-uint-set!
          c-bytevector-uint-ref
          c-bytevector-ieee-single-set!
          c-bytevector-ieee-single-native-set!
          c-bytevector-ieee-single-ref
          c-bytevector-ieee-single-native-ref
          c-bytevector-ieee-double-set!
          c-bytevector-ieee-double-native-set!
          c-bytevector-ieee-double-ref
          c-bytevector-ieee-double-native-ref

          ;; c-bytevector
          make-c-bytevector
          ;c-bytevector ;; TODO docs, tests
          make-c-null
          c-null?
          c-free


          c-string-length ;; TODO Documentation, Testing
          bytevector->c-bytevector
          c-bytevector->bytevector
          call-with-address-of-c-bytevector ;; Todo Documentation
          string->c-utf8
          c-utf8->string

          ;c-bytevector-u8-ref ;; TODO Documentation, Testing

          ;; c-struct
          ;pffi-define-struct;define-c-struct
          ;pffi-struct-pointer;c-struct-bytevector
          ;pffi-struct-offset-get;c-struct-offset
          ;pffi-struct-set!;c-struct-set!
          ;pffi-struct-get;c-struct-get

          ;; c-array
          ;define-c-array (?)
          ;pffi-array-allocate;make-c-array
          ;pffi-array-pointer;c-array-pointer
          ;pffi-array?;c-array?
          ;pffi-pointer->array;c-bytevector->array
          ;pffi-array-get;c-array-get
          ;pffi-array-set!;c-array-set!
          ;pffi-list->array;list->c-array
          ;pffi-array->list;c-array->list

          ;; c-variable
          ;define-c-variable (?)
          )
  (cond-expand
    (chicken-6 (include-relative "c/types.scm"))
    (else (include "c/types.scm")))
  (cond-expand
    (chibi (include "c/primitives/chibi.scm"))
    (chicken-5 (export foreign-declare
                       foreign-safe-lambda
                       void)
               (include "c/primitives/chicken.scm"))
    (chicken-6 (include-relative "c/primitives/chicken.scm"))
    ;(cyclone (include "c/primitives/cyclone.scm"))
    ;(gambit (include "c/primitives/gambit.scm"))
    (gauche (include "c/primitives/gauche.scm"))
    ;(gerbil (include "c/primitives/gerbil.scm"))
    (guile (include "c/primitives/guile.scm"))
    (kawa (include "c/primitives/kawa.scm"))
    ;(larceny (include "c/primitives/larceny.scm"))
    (mosh (include "c/primitives/mosh.scm"))
    (racket (include "c/primitives/racket.scm"))
    (sagittarius (include "c/primitives/sagittarius.scm"))
    ;(skint (include "c/primitives/skint.scm"))
    (stklos (include "c/primitives/stklos.scm"))
    ;(tr7 (include "c/primitives/tr7.scm"))
    (ypsilon (export c-function c-callback)
             (include "c/primitives/ypsilon.scm")))
  (cond-expand
    (chicken-6 (include-relative "c/main.scm")
               (include-relative "c/c-bytevectors.scm")
               (include-relative "c/pointer.scm")
               ;(include-relative "c/array.scm")
               ;(include-relative "c/struct.scm")
               )
    (else (include "c/main.scm")
          ;(include "c/struct.scm")
          (include "c/c-bytevectors.scm")
          (include "c/pointer.scm")
          ;(include "c/array.scm")
          )))
