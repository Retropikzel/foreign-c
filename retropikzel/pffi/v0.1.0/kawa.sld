(define-library
  (retropikzel pffi v0.1.0 guile)
  (import (scheme base)
          (scheme write)
          (scheme file)
          (scheme process-context)
          (retropikzel pffi v0.1.0 kawa))
  (export pffi-shared-object-load
          pffi-define
          pffi-size-of
          pffi-pointer-allocate
          pffi-pointer-null
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer->bytevector
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-pointer-set!
          pffi-pointer-get
          pffi-pointer-deref)
  (begin


    ))
