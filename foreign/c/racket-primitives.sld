(define-library
  (foreign c racket-primitives)
  (cond-expand
    (r6rs (import (rnrs base)
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
                        quotient)))
    (else
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme inexact)
              (scheme process-context)
              (only (racket base)
                    system-type
                    system-big-endian?)
              (ffi winapi)
              (compatibility mlist)
              (ffi unsafe)
              (ffi vector))))
  (export size-of-type
          align-of-type
          shared-object-load
          define-c-procedure
          c-bytevector?
          c-bytevector-u8-ref
          c-bytevector-u8-set!
          c-bytevector-pointer-ref
          c-bytevector-pointer-set!
          ;; Racket specific
          system-big-endian?
          )
  (include "racket-primitives.scm"))
