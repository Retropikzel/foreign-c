(define-library
  (retropikzel pffi v0-2-2 main)
  (cond-expand
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 sagittarius)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 guile)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (only (racket base) system-type)
              (retropikzel pffi v0-2-2 racket)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (stklos)
              (retropikzel pffi v0-2-2 stklos)))
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
              (retropikzel pffi v0-2-2 cyclone)))
    (gambit
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 gambit)))
    (chicken
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 chicken)))
    (chibi
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 chibi)))
    (mit-scheme
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (retropikzel pffi v0-2-2 mit-scheme))))
  (export pffi-shared-object-auto-load
          pffi-shared-object-load
          pffi-define
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
          pffi-pointer-deref)
  (begin


    #|doc Testing multiline comment |#



    (define library-version "v0-2-2")
    (define slash (cond-expand (windows (string #\\)) (else "/")))

    (define platform-file-extension
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so"))
        (windows ".dll")
        (else ".so")))

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
         string
         pointer
         void))

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
              (if (get-environment-variable "WINEDLLDIR0")
                (list (get-environment-variable "WINEDLLDIR0"))
                (list))
              (if (get-environment-variable "SystemRoot")
                (list (string-append
                        (get-environment-variable "SystemRoot")
                        "system32"))
                (list))
              (list "."
                    )
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
              (list
                ;;; x86-64
                ; Debian
                "/lib/x86_64-linux-gnu"
                "/usr/lib/x86_64-linux-gnu"
                "/usr/local/lib"
                ; Fedora/Alpine
                "/usr/lib"
                "/usr/lib64"
                ;;; aarch64
                ; Debian
                "/lib/aarch64-linux-gnu"
                "/usr/lib/aarch64-linux-gnu"
                "/usr/local/lib"
                ; Fedora/Alpine
                "/usr/lib"
                "/usr/lib64"
                ))))))

    (define auto-load-versions (list ""))

    (define-syntax pffi-shared-object-auto-load
      (syntax-rules ()
        ((pffi-shared-object-auto-load headers additional-paths object-name additional-versions)
         (cond-expand
           (cyclone (pffi-shared-object-load headers))
           (chicken (pffi-shared-object-load headers))
           (gambit (pffi-shared-object-load headers))
           (else
             (let* ((paths (append auto-load-paths additional-paths))
                    (versions (append auto-load-versions additional-versions))
                    (shared-object #f))
               (for-each
                 (lambda (path)
                   (for-each
                     (lambda (version)
                       (let ((library-path (string-append path
                                                          slash
                                                          platform-lib-prefix
                                                          object-name
                                                          platform-file-extension
                                                          version)))
                         (if (file-exists? library-path)
                           (set! shared-object library-path))))
                     versions))
                 paths)
               (if (not shared-object)
                 (error "Could not load shared object"
                        (list (cons 'object object-name)
                              (cons 'paths paths)
                              (cons 'platform-file-extension platform-file-extension)
                              (cons 'versions versions)))
                 (pffi-shared-object-load headers shared-object))))))))

    (cond-expand
      (kawa (include "kawa.scm"))
      (else #t))))
