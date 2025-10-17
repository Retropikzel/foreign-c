(define-library
  (foreign c stklos-primitives)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme inexact)
          (scheme process-context)
          (only (stklos)
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
  (export size-of-type
          align-of-type
          ;shared-object-load
          define-c-procedure
          define-c-callback
          c-bytevector?
          c-bytevector-u8-ref
          c-bytevector-u8-set!
          c-bytevector-pointer-ref
          c-bytevector-pointer-set!
          ;; STklos specific
          ; calculate-struct-size-and-offsets
          ;struct-make
          get-environment-variable
          file-exists?
          make-external-function
          ;address->c-bytevector
          foreign-c:string-split
          ;c-bytevector-pointer-set!
          ;c-bytevector-pointer-ref
          void?
          )
  (include "c-bytevectors.scm")
  (include "stklos-primitives.scm"))
