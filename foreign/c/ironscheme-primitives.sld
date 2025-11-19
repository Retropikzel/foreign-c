(define-library
  (foreign c ironscheme-primitives)
  (import (rnrs base)
          (rnrs lists)
          (rnrs control)
          (rnrs files)
          (rnrs io simple)
          (rnrs programs)
          (only (rnrs bytevectors)
                make-bytevector
                bytevector-length
                utf8->string
                string->utf8
                bytevector-u8-ref
                bytevector-u8-set!)
          (only (rnrs r5rs)
                remainder
                quotient)
          (ironscheme)
          (ironscheme clr)
          (ironscheme clr internal)
          (ironscheme ffi)
          (srfi 0)
          (srfi :98))
  (export size-of-type
          align-of-type
          shared-object-load
          define-c-procedure
          c-bytevector?
          c-bytevector-u8-ref
          c-bytevector-u8-set!
          c-bytevector-pointer-ref
          c-bytevector-pointer-set!)
  (include "foreign/c/ironscheme-primitives.scm"))
