(define-library
  (foreign c chicken-primitives)
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
          (chicken random))
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
          ;; Chicken specific
          foreign-declare
          foreign-safe-lambda
          void
          pointer?
          foreign-declare
          address->pointer
          pointer->address)
  (include "chicken-primitives.scm"))
