(repository
  (package
    (git
      (hash "42fab0ece4a374b6b384069b64dadc786408cb64")
      (url "https://codeberg.org/foreign-c/foreign-c.git"))
    (authors "Retropikzel")
    (version "0.23.3")
    (library
      (name
        (foreign c))
      (path "foreign/c.sld")
      (foreign-depends "ffi")
      (cond-expand
        (capy
          (depends
            (core foreign)
            (core foreign-library)))
        (chezscheme
          (depends
            (chezscheme)
            (chezscheme)))
        (chibi
          (depends
            (chibi)))
        (chicken
          (depends
            (chicken base)
            (chicken foreign)
            (chicken locative)
            (chicken syntax)
            (chicken memory)
            (chicken random)))
        (gauche
          (depends
            (gauche keyword)
            (gauche base)
            (gauche ffi)
            (gauche uvector)
            (gauche native-type)
            (gauche ffi native)
            (gauche ffi ffiaux)))
        (guile
          (depends
            (scheme base)
            (scheme write)
            (scheme char)
            (scheme file)
            (scheme process-context)
            (scheme inexact)
            (system foreign)
            (system foreign-library)
            (rnrs bytevectors)))
        (ikarus
          (depends
            (ikarus foreign)))
        (ironscheme
          (depends
            (ironscheme clr)
            (ironscheme clr internal)
            (ironscheme ffi)))
        (kawa
          (depends
            (kawa reflect)))
        (mosh
          (depends
            (mosh ffi)))
        (racket
          (depends
            (ffi winapi)
            (compatibility mlist)
            (ffi unsafe)
            (ffi vector)))
        (sagittarius
          (depends
            (sagittarius ffi)))
        (stklos
          (depends
            (stklos)))
        (ypsilon
          (depends
            (ypsilon c-ffi)
            (ypsilon c-types)
            (core))))
      (cond-expand
        (chicken
          (depends))
        (else
          (depends)))
      (cond-expand
        (capy
          (depends))
        (chicken
          (depends))
        (kawa
          (depends))
        (else
          (depends)))
      (depends
        (scheme base)
        (scheme write)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (scheme inexact)
        (scheme cxr)))
    (manual "foreign/c.html")
    (description "Portable foreign function interface for R6RS and R7RS Schemes")
    (updated "2026-08-29T13:25:15+00:00")))
