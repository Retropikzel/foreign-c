(define-library
  (foreign c ypsilon-primitives)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme inexact)
          (scheme process-context)
          (ypsilon c-ffi)
          (ypsilon c-types)
          (only (core)
                define-macro
                syntax-case
                bytevector-c-int8-set!
                bytevector-c-uint8-ref))
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
          ;; Ypsilon specific
          c-function
          c-callback
          bytevector-c-int8-set!
          bytevector-c-uint8-ref)
  (include "ypsilon-primitives.scm"))
