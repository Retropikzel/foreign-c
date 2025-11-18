(define-library
  (foreign c larceny-primitives)
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
          (primitives system-interface))
  (export size-of-type
          align-of-type
          shared-object-load
          define-c-procedure
          c-bytevector?
          c-bytevector-u8-ref
          c-bytevector-u8-set!
          c-bytevector-pointer-ref
          c-bytevector-pointer-set!)
  (include "larceny-primitives.scm"))
