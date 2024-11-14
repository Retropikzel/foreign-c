(define-library
  (retropikzel r7rs-pffi)
  (cond-expand
    (chibi
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chibi ast)
              (chibi))
      (include-shared "r7rs-pffi/r7rs-pffi-chibi"))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme char)
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
              (scheme char)
              (scheme file)
              (scheme process-context)
              (cyclone foreign)
              (scheme cyclone primitives)))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (only (gambit) c-declare c-lambda c-define)))
    (gauche
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (gerbil
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (rnrs bytevectors)
              (system foreign)
              (system foreign-library)))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (larceny
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (mosh
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (mosh ffi)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme char)
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
              (scheme char)
              (scheme file)
              (scheme process-context)
              (sagittarius ffi)
              (sagittarius)))
    (skint
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (stklos)))
    (tr7
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (ypsilon
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)))
    (else (error "Unsupported implementation")))
  (export pffi-init
          pffi-size-of
          pffi-shared-object-auto-load
          pffi-shared-object-load
          pffi-pointer-null
          pffi-pointer-null?
          pffi-pointer-allocate
          pffi-pointer?
          pffi-pointer-free
          pffi-pointer-set!
          pffi-pointer-get
          pffi-string->pointer
          pffi-pointer->string
          pffi-define
          ;pffi-define-callback
          ;pffi-pointer-address
          pffi-pointer-dereference
          )
  (cond-expand
    (chibi (include "r7rs-pffi/chibi.scm"))
    (chicken (include "r7rs-pffi/chicken.scm"))
    (cyclone (include "retropikzel/r7rs-pffi/cyclone.scm"))
    (gambit (include "r7rs-pffi/gambit.scm"))
    (gauche (include "r7rs-pffi/gauche.scm"))
    (gerbil (include "r7rs-pffi/gerbil.scm"))
    (guile (include "r7rs-pffi/guile.scm"))
    (kawa (include "r7rs-pffi/kawa.scm"))
    (larceny (include "r7rs-pffi/larceny.scm"))
    (mosh (include "r7rs-pffi/mosh.scm"))
    (racket (include "r7rs-pffi/racket.scm"))
    (sagittarius (include "r7rs-pffi/sagittarius.scm"))
    (skint (include "r7rs-pffi/skint.scm"))
    (stklos (include "retropikzel/r7rs-pffi/stklos.scm"))
    (tr7 (include "retropikzel/r7rs-pffi/tr7.scm"))
    (ypsilon (include "r7rs-pffi/ypsilon.scm"))
    (else #t))
  (cond-expand
    (cyclone (include "retropikzel/r7rs-pffi/main.scm"))
    (stklos (include "retropikzel/r7rs-pffi/main.scm"))
    (else (include "r7rs-pffi/main.scm"))))
