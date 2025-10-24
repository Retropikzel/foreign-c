(define-library
  (foreign c)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme process-context)
          (scheme inexact))
  (cond-expand
    (chibi (import (foreign c chibi-primitives)))
    (chicken (import (foreign c chicken-primitives)))
    ;(cyclone (import (foreign c cyclone-primitives)))
    ;(gambit (import (foreign c gambit-primitives)))
    ;(gauche (import (foreign c gauche-primitives)))
    (guile (import (foreign c guile-primitives)))
    (kawa (import (foreign c kawa-primitives)))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (foreign c mosh-primitives)))
    (racket (import (foreign c racket-primitives)))
    (sagittarius (import (foreign c sagittarius-primitives)))
    (stklos (import (foreign c stklos-primitives))
            (export foreign-c:string-split))
    (ypsilon (import (foreign c ypsilon-primitives))
             (export c-function
                     c-callback
                     bytevector-c-int8-set!
                     bytevector-c-uint8-ref)))
  (export ;;;; Primitives 1
          c-type-size
          c-type-align
          define-c-library
          define-c-procedure
          c-bytevector?
          c-bytevector-u8-set!
          c-bytevector-u8-ref
          c-bytevector-pointer-set!
          c-bytevector-pointer-ref

          ;;;; Primitives 2
          define-c-callback

          ;;;; c-bytevector
          make-c-null
          c-null?
          c-free
          call-with-address-of

          bytevector->c-bytevector
          c-bytevector->bytevector

          ;;;; Utilities
          libc-name
          c-type-signed?
          c-type-unsigned?

          ;; TODO endianness
          native-endianness
          make-c-bytevector
          c-bytevector->address
          ;; TODO c-bytevector=?
          ;; TODO c-bytevector-fill!
          ;; TODO c-bytevector-copy!
          ;; TODO c-bytevector-copy
          c-bytevector-s8-set!
          c-bytevector-s8-ref
          ;; TODO c-bytevector->u8-list
          ;; TODO u8-list->c-bytevector

          c-bytevector-uchar-ref
          c-bytevector-char-ref
          c-bytevector-char-set!
          c-bytevector-uchar-set!

          c-bytevector-uint-ref
          c-bytevector-sint-ref
          c-bytevector-sint-set!
          c-bytevector-uint-set!
          ;; TODO bytevector->uint-list
          ;; TODO bytevector->sint-list
          ;; TODO uint-list->bytevector
          ;; TODO sint-list->bytevector

          c-bytevector-u16-ref
          c-bytevector-s16-ref
          c-bytevector-u16-native-ref
          c-bytevector-s16-native-ref
          c-bytevector-u16-set!
          c-bytevector-s16-set!
          c-bytevector-u16-native-set!
          c-bytevector-s16-native-set!

          c-bytevector-u32-ref
          c-bytevector-s32-ref
          c-bytevector-u32-native-ref
          c-bytevector-s32-native-ref
          c-bytevector-u32-set!
          c-bytevector-s32-set!
          c-bytevector-u32-native-set!
          c-bytevector-s32-native-set!

          c-bytevector-u64-ref
          c-bytevector-s64-ref
          c-bytevector-s64-native-ref
          c-bytevector-u64-native-ref
          c-bytevector-u64-set!
          c-bytevector-s64-set!
          c-bytevector-u64-native-set!
          c-bytevector-s64-native-set!

          c-bytevector-ieee-single-native-ref
          c-bytevector-ieee-single-ref

          c-bytevector-ieee-double-native-ref
          c-bytevector-ieee-double-ref

          c-bytevector-ieee-single-native-set!
          c-bytevector-ieee-single-set!

          c-bytevector-ieee-double-native-set!
          c-bytevector-ieee-double-set!

          string->c-utf8
          ;; TODO string->c-utf16
          ;; TODO string->c-utf32

          c-utf8->string
          ;; TODO c-utf16->string
          ;; TODO c-utf32->string


          ;c-utf8-length ;; TODO ??

          ;; c-variable
          ;define-c-variable (?)
          )
  (include "c/c-bytevectors.scm")
  (include "c.scm"))
