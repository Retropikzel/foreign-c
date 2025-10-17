(define-library
  (foreign c chibi-primitives)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme process-context)
          (chibi ast)
          (scheme inexact)
          (chibi))
  (export size-of-type
          align-of-type
          shared-object-load
          define-c-procedure
          define-c-callback
          c-bytevector?
          c-bytevector-u8-ref
          c-bytevector-u8-set!
          c-bytevector-pointer-ref
          c-bytevector-pointer-set!
          ;; Chibi specific
          c-null?
          )
  (include-shared "chibi-primitives")
  (include "chibi-primitives.scm")
  (include "c-bytevectors.scm"))
