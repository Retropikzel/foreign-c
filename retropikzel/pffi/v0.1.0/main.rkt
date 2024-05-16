#lang r7rs
;> # pffi

;> ## Procedures
(define-library
  (retropikzel pffi v0.1.0 main)
  (cond-expand
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 sagittarius)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 guile)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 racket)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (stklos)
              (retropikzel pffi v0.1.0 stklos)))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)))
    (cyclone
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 cyclone)))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 gambit)))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 chicken)))
    (chibi
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0.1.0 chibi))))
  (export pffi-shared-object-auto-load
          pffi-shared-object-load
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



    (define library-version "v0.1.0")

    ;> ## Procedures

    (define platform-file-extension
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so"))
        (windows ".dll")
        (else ".so")))

    (define platform-version-file-extension
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so.0"))
        (windows ".dll")
        (else ".so.0")))

    (define platform-lib-prefix
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) "" "lib"))
        (windows "")
        (else "lib")))

    (define pffi-types
      '(int8
         uint8
         int16
         uint16
         int32
         uint32
         int64
         uint64
         intptr
         uintptr
         char
         unsigned-char
         short
         unsigned-short
         int
         unsigned-int
         long
         unsigned-long
         float
         double
         pointer))

    (define string-split
      (lambda (str mark)
        (let* ((str-l (string->list str))
               (res (list))
               (last-index 0)
               (index 0)
               (splitter (lambda (c)
                           (cond ((char=? c mark)
                                  (begin
                                    (set! res (append res (list (string-copy str last-index index))))
                                    (set! last-index (+ index 1))))
                                 ((equal? (length str-l) (+ index 1))
                                  (set! res (append res (list (string-copy str last-index (+ index 1)))))))
                           (set! index (+ index 1)))))
          (for-each splitter str-l)
          res)))

    (define auto-load-paths
      (append
        (cond-expand
          (windows
            (append
              (if (get-environment-variable "SYSTEM")
                (list (get-environment-variable "SYSTEM"))
                (list))
              (if (get-environment-variable "WINDIR")
                (list (get-environment-variable "WINDIR"))
                (list))
              (list ".")
              (string-split (get-environment-variable "PATH") #\;)))
          (else
            (append
              ; Guix
              (list (if (get-environment-variable "GUIX_ENVIRONMENT")
                      (string-append (get-environment-variable "GUIX_ENVIRONMENT") "/lib")
                      "")
                    "/run/current-system/profile/lib")
              ; Debian
              (if (get-environment-variable "LD_LIBRARY_PATH")
                (list (string-split (get-environment-variable "LD_LIBRARY_PATH") #\:))
                (list))
              (list "/lib/x86_64-linux-gnu"
                    "/usr/lib/x86_64-linux-gnu"
                    "/usr/local/lib"))))))

    ;> ### pffi-shared-object-load
    ;>
    ;> Arguments:
    ;> - path (string) The path to the shared object you want to load, including any "lib" infront and .so/.dll at the end
    ;>
    ;> Returns:
    ;>




    ;> ### pffi-shared-object-auto-load
    ;>
    ;> Arguments:
    ;> - object-name (symbol)
    ;>  - The name of the dynamic library file you want to load without the "lib" in fron of it or .so/.dll at the end
    ;> - addition-paths (list (string)...)
    ;>  - Any additional paths you want to search for the library
    ;>
    ;> Returns:
    ;> - (object) Shared object, the type depends on the implementation

    (define-syntax pffi-shared-object-auto-load
      (syntax-rules ()
        ((pffi-shared-object-auto-load headers object-name additional-paths)
         (cond-expand
           (cyclone (pffi-shared-object-load headers object-path))
           (else
             (let* ((paths (append auto-load-paths additional-paths))
                    (shared-object #f))
               (for-each
                 (lambda (path)
                   (if (not shared-object)
                     (let ((object-path
                             (string-append path
                                            "/"
                                            object-name
                                            platform-file-extension))
                           (object-version-path
                             (string-append path
                                            "/"
                                            object-name
                                            platform-version-file-extension))
                           (object-lib-path
                             (string-append path
                                            "/"
                                            platform-lib-prefix
                                            object-name
                                            platform-file-extension))
                           (object-version-lib-path
                             (string-append path
                                            "/"
                                            platform-lib-prefix
                                            object-name
                                            platform-version-file-extension)))
                       (cond
                         ((file-exists? object-path)
                          (set! shared-object (pffi-shared-object-load headers object-path)))
                         ((file-exists? object-version-path)
                          (set! shared-object (pffi-shared-object-load headers object-version-path)))
                         ((file-exists? object-lib-path)
                          (set! shared-object (pffi-shared-object-load headers object-lib-path)))
                         ((file-exists? object-version-lib-path)
                          (set! shared-object (pffi-shared-object-load headers object-version-lib-path)))))))
                 paths)
               (if (not shared-object)
                 (error "Could not load shared object" object-name)
                 shared-object)))))))

    (cond-expand
      (kawa
        (include "kawa.scm"))
      (else #t))))
