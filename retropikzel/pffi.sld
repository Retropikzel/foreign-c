(define-library
  (retropikzel pffi)
  (cond-expand
    (chibi
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chibi ast)
              (chibi))
      (include-shared "pffi/chibi-pffi"))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chicken base)
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
              (only (gambit) c-declare c-lambda c-define define-macro)))
    (gauche
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (gauche base)
              (retropikzel pffi gauche)))
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
              (scheme process-context)
              (rename (primitives r5rs:require) (r5rs:require require))
              (primitives std-ffi)
              (primitives foreign-procedure)
              (primitives foreign-file)
              (primitives foreign-stdlib)))
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
              (stklos))
      (export make-external-function
              calculate-struct-size-and-offsets
              struct-make))
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
              (scheme process-context)
              (ypsilon c-ffi)
              (ypsilon c-types)
              (only (core) define-macro syntax-case)))
    (else (error "Unsupported implementation")))
  (export pffi-init
          pffi-size-of
          pffi-type?
          pffi-align-of
          pffi-define-library
          pffi-pointer-null
          pffi-pointer-null?
          pffi-pointer-allocate
          pffi-pointer-address
          pffi-pointer?
          pffi-pointer-free
          pffi-pointer-set!
          pffi-pointer-get
          pffi-string->pointer
          pffi-pointer->string
          pffi-define-struct
          pffi-struct-pointer
          pffi-struct-offset-get
          pffi-struct-get
          pffi-struct-set!
          pffi-struct-dereference
          pffi-array-allocate
          pffi-array?
          pffi-pointer->array
          pffi-array-get
          pffi-array-set!
          pffi-list->array
          pffi-array->list
          pffi-define
          pffi-define-callback)
  (cond-expand
    (chibi (include "pffi/chibi.scm"))
    (chicken (include-relative "pffi/chicken.scm"))
    (cyclone (include "pffi/cyclone.scm"))
    (gambit (include "pffi/gambit.scm"))
    (gauche (include "pffi/gauche.scm"))
    (gerbil (include "pffi/gerbil.scm"))
    (guile (include "pffi/guile.scm"))
    (kawa (include "pffi/kawa.scm"))
    (larceny (include "pffi/larceny.scm"))
    (mosh (include "pffi/mosh.scm"))
    (racket (include "pffi/racket.scm"))
    (sagittarius (include "pffi/sagittarius.scm"))
    (skint (include "pffi/skint.scm"))
    (stklos (include "pffi/stklos.scm"))
    (tr7 (include "pffi/tr7.scm"))
    (ypsilon (include "pffi/ypsilon.scm")))
  ;(include "pffi/shared/union.scm")
  (include "pffi/shared/main.scm")
  (include "pffi/shared/pointer.scm")
  (include "pffi/shared/array.scm")
  (include "pffi/shared/struct.scm"))
