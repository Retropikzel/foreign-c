(define-library
  (foreign c-mit-scheme)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme inexact)
          ;(scheme load)
          (scheme process-context)
          ;(only (mit legacy runtime) load-option all-packages)
          (only (mit legacy runtime)
                load
                load-option
                ->pathname
                dld-load-file
                call-alien
                ;compile-file
                make-alien-function
                ;generate-shim
                )
          )
  (export hello)
#;(begin
;(declare (usual-integrations))

;(C-include "mit-scheme-foreign-c")

(define (hello)
  ;(puts "Hello from puts")
  (display "Not from puts")
  (newline)
  ))
;(C-call "puts" "Hello world")
  ;(include "c/internal.scm")
  (include "c/primitives/mit-scheme.scm")
  ;(include "c/c-types.scm")
  ;(include "c/main.scm")
  ;(include "c/libc.scm")
  ;(include "c/c-bytevectors.scm")
  ;(include "c/pointer.scm")
  ;(include "c/array.scm")
  ;(include "c/struct.scm")
  )
