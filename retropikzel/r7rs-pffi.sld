(define-library
  (retropikzel r7rs-pffi)
  (cond-expand
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (chicken foreign)
              (chicken locative)
              (chicken syntax)
              (chicken memory)
              (chicken random)))
    (cyclone
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (cyclone foreign)
              (scheme cyclone primitives)))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (rnrs bytevectors)
              (system foreign)
              (system foreign-library)))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (only (racket base) system-type)
              (ffi winapi)
              (compatibility mlist)
              (ffi unsafe)
              (ffi vector)))
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (sagittarius ffi)
              (sagittarius)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (stklos)))
    (else (error "Unsupported implementation")))
  (export pffi-init
          pffi-shared-object-auto-load
          pffi-shared-object-load
          pffi-define
          pffi-define-callback
          pffi-size-of
          pffi-pointer-allocate
          pffi-pointer-null
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-pointer-set!
          pffi-pointer-get
          pffi-pointer-deref
          pffi-os-name)
  (begin
    (include "r7rs-pffi/main.scm")
    (cond-expand
      (chicken (include "r7rs-pffi/chicken.scm"))
      (cyclone (include "r7rs-pffi/cyclone.scm"))
      (gambit (include "r7rs-pffi/gambit.scm"))
      (guile (include "r7rs-pffi/guile.scm"))
      (kawa (include "r7rs-pffi/kawa.scm"))
      (racket (include "r7rs-pffi/racket.scm"))
      (sagittarius (include "r7rs-pffi/sagittarius.scm"))
      (stklos (include "r7rs-pffi/stklos.scm"))
      (else #t))))
