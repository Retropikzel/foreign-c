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
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback
              scheme-procedure-to-pointer
              )
      (include-shared "pffi/chibi-pffi"))
    (chicken-5
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chicken foreign)
              (chicken locative)
              (chicken syntax)
              (chicken memory)
              (chicken random))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
    (chicken6
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (chicken foreign)
              (chicken locative)
              (chicken syntax)
              (chicken memory)
              (chicken random))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
              pffi-pointer-null
              pffi-pointer-null?
              pffi-pointer-allocate
              pffi-pointer?
              pffi-pointer-free
              pffi-pointer-set!
              pffi-pointer-get
              pffi-string->pointer
              pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
    (cyclone
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (cyclone foreign)
              (scheme cyclone primitives))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
              pffi-pointer-null
              pffi-pointer-null?
              pffi-pointer-allocate
              pffi-pointer?
              pffi-pointer-free
              pffi-pointer-set!
              pffi-pointer-get
              pffi-string->pointer
              pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              ;pffi-define-callback
              ))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (only (gambit) c-declare c-lambda c-define define-macro))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
              ;pffi-pointer-null
              ;pffi-pointer-null?
              ;pffi-pointer-allocate
              ;pffi-pointer-address
              ;pffi-pointer?
              ;pffi-pointer-free
              ;pffi-pointer-set!
              ;pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (gauche
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (gauche base)
              (retropikzel pffi gauche))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              ;pffi-define-callback
              ))
    (gerbil
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context))
      (export pffi-init
              ;pffi-size-of
              pffi-type?
              ;pffi-align-of
              ;pffi-load
              ;pffi-pointer-null
              ;pffi-pointer-null?
              ;pffi-pointer-allocate
              ;pffi-pointer?
              ;pffi-pointer-free
              ;pffi-pointer-set!
              ;pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (rnrs bytevectors)
              (system foreign)
              (system foreign-library))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback
              ))
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
              (primitives foreign-stdlib)
              )
      (export pffi-init
              ;pffi-size-of
              pffi-type?
              ;pffi-align-of
              ;pffi-load
              ;pffi-pointer-null
              ;pffi-pointer-null?
              ;pffi-pointer-allocate
              ;pffi-pointer?
              ;pffi-pointer-free
              ;pffi-pointer-set!
              ;pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (mosh
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (mosh ffi))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
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
              (ffi vector))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (sagittarius ffi)
              (sagittarius))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
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
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              pffi-define
              pffi-define-callback))
    (skint
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context))
      (export pffi-init
              ;pffi-size-of
              pffi-type?
              ;pffi-align-of
              ;pffi-load
              ;pffi-pointer-null
              ;pffi-pointer-null?
              ;pffi-pointer-allocate
              ;pffi-pointer?
              ;pffi-pointer-free
              ;pffi-pointer-set!
              ;pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context)
              (stklos))
      (export pffi-init
              pffi-size-of
              pffi-type?
              pffi-align-of
              pffi-load
              pffi-pointer-null
              pffi-pointer-null?
              pffi-pointer-allocate
              pffi-pointer-address
              pffi-pointer?
              pffi-pointer-free
              pffi-pointer-set!
              pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (tr7
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context))
      (export pffi-init
              ;pffi-size-of
              pffi-type?
              ;pffi-align-of
              ;pffi-load
              ;pffi-shared-object-load
              ;pffi-pointer-null
              ;pffi-pointer-null?
              ;pffi-pointer-allocate
              ;pffi-pointer?
              ;pffi-pointer-free
              ;pffi-pointer-set!
              ;pffi-pointer-get
              ;pffi-string->pointer
              ;pffi-pointer->string
              pffi-struct-make
              pffi-struct-pointer
              pffi-struct-offset-get
              pffi-struct-get
              pffi-struct-set!
              ;pffi-define
              ;pffi-define-callback
              ))
    (ypsilon
      (import (scheme base)
              (scheme write)
              (scheme char)
              (scheme file)
              (scheme process-context))
      (export ;pffi-init
        ;pffi-size-of
        pffi-type?
        ;pffi-align-of
        ;pffi-load
        ;pffi-pointer-null
        ;pffi-pointer-null?
        ;pffi-pointer-allocate
        ;pffi-pointer?
        ;pffi-pointer-free
        ;pffi-pointer-set!
        ;pffi-pointer-get
        ;pffi-string->pointer
        ;pffi-pointer->string
        pffi-struct-make
        pffi-struct-pointer
        pffi-struct-offset-get
        pffi-struct-get
        pffi-struct-set!
        ;pffi-define
        ;pffi-define-callback
        ))
    (else (error "Unsupported implementation")))
  (cond-expand
    (chibi (include "pffi/chibi.scm"))
    (chicken-5 (include "pffi/chicken5.scm"))
    (chicken-6 (include "chicken6.scm"))
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
  (include "pffi/shared/struct.scm")
  (include "pffi/shared/union.scm")
  (include "pffi/shared/main.scm"))
