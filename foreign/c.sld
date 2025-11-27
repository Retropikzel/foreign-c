(define-library
  (foreign c)
  (import (scheme base)
          (scheme write)
          (scheme char)
          (scheme file)
          (scheme process-context)
          (scheme inexact))
  (import (foreign c-bytevectors))
  (cond-expand
    (chezscheme (import (foreign c chez-primitives))
                (export foreign-procedure))
    (chibi (import (foreign c chibi-primitives)))
    (chicken (import (foreign c chicken-primitives)
                     (chicken base)
                     (chicken foreign))
             (export foreign-declare
                     foreign-safe-lambda))
    ;(cyclone (import (foreign c cyclone-primitives)))
    ;(gambit (import (foreign c gambit-primitives)))
    (gauche (import (foreign c gauche-primitives)))
    (guile (import (foreign c guile-primitives)))
    (ikarus (import (foreign c ikarus-primitives)))
    (ironscheme (import (foreign c ironscheme-primitives)
                        ;(rename (ironscheme environment) (get-environment-variable getenv))
                        ))
    (kawa (import (foreign c kawa-primitives)))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    (larceny (import (foreign c larceny-primitives)))
    (mosh (import (foreign c mosh-primitives)))
    (racket (import (only (scheme base) cond-expand)
                    (foreign c racket-primitives)))
    (sagittarius (import (foreign c sagittarius-primitives)))
    (stklos (import (foreign c stklos-primitives))
            (export foreign-c:string-split
                    make-external-function
                    free-bytes))
    (ypsilon (import (foreign c ypsilon-primitives))
             (export c-function
                     bytevector-c-int8-set!
                     bytevector-c-uint8-ref))
    (else (begin (error "Unsupported implementation"))))
  (export
    ;;;; Primitives
    c-type-size
    c-type-align
    define-c-library
    define-c-procedure
    c-bytevector?
    c-bytevector-u8-set!
    c-bytevector-u8-ref
    c-bytevector-pointer-set!
    c-bytevector-pointer-ref

    ;;;; c-bytevector
    make-c-null
    c-null?
    c-free
    call-with-address-of

    bytevector->c-bytevector
    c-bytevector->bytevector

    ;;;; Utilities
    libc-name
    c-type-signed?
    c-type-unsigned?

    ;; TODO endianness
    native-endianness
    make-c-bytevector
    c-bytevector->address
    ;; TODO c-bytevector=?
    ;; TODO c-bytevector-fill!
    ;; TODO c-bytevector-copy!
    ;; TODO c-bytevector-copy
    c-bytevector-s8-set!
    c-bytevector-s8-ref
    ;; TODO c-bytevector->u8-list
    ;; TODO u8-list->c-bytevector

    c-bytevector-uchar-ref
    c-bytevector-char-ref
    c-bytevector-char-set!
    c-bytevector-uchar-set!

    c-bytevector-uint-ref
    c-bytevector-sint-ref
    c-bytevector-sint-set!
    c-bytevector-uint-set!
    ;; TODO bytevector->uint-list
    ;; TODO bytevector->sint-list
    ;; TODO uint-list->bytevector
    ;; TODO sint-list->bytevector

    c-bytevector-u16-ref
    c-bytevector-s16-ref
    c-bytevector-u16-native-ref
    c-bytevector-s16-native-ref
    c-bytevector-u16-set!
    c-bytevector-s16-set!
    c-bytevector-u16-native-set!
    c-bytevector-s16-native-set!

    c-bytevector-u32-ref
    c-bytevector-s32-ref
    c-bytevector-u32-native-ref
    c-bytevector-s32-native-ref
    c-bytevector-u32-set!
    c-bytevector-s32-set!
    c-bytevector-u32-native-set!
    c-bytevector-s32-native-set!

    c-bytevector-u64-ref
    c-bytevector-s64-ref
    c-bytevector-s64-native-ref
    c-bytevector-u64-native-ref
    c-bytevector-u64-set!
    c-bytevector-s64-set!
    c-bytevector-u64-native-set!
    c-bytevector-s64-native-set!

    c-bytevector-ieee-single-native-ref
    c-bytevector-ieee-single-ref

    c-bytevector-ieee-double-native-ref
    c-bytevector-ieee-double-ref

    c-bytevector-ieee-single-native-set!
    c-bytevector-ieee-single-set!

    c-bytevector-ieee-double-native-set!
    c-bytevector-ieee-double-set!

    string->c-utf8
    ;; TODO string->c-utf16
    ;; TODO string->c-utf32

    c-utf8->string
    ;; TODO c-utf16->string
    ;; TODO c-utf32->string


    ;c-utf8-length ;; TODO ??

    ;; c-variable
    ;define-c-variable (?)
    )
  (cond-expand
    (gauche (begin (define implementation 'gauche)))
    (racket (begin (define implementation 'racket)))
    (stklos (begin (define implementation 'stklos)))
    (else (begin (define implementation 'other))))
  (cond-expand
    (i386 (begin (define arch 'i386)))
    (else (begin (define arch 'x86_64))))
  (cond-expand
    (windows
      (begin
        (define os 'windows)
        (define libc-name "ucrtbase")))
    (haiku
      (begin
        (define os 'haiku)
        (define libc-name "root")))
    (else
      (begin
        (define os 'unix)
        (define libc-name "c"))))
  (cond-expand
    (chicken
      (begin
        (define-syntax define-c-library
          (syntax-rules ()
            ((_ scheme-name headers object-name options)
             (begin
               (define scheme-name #t)
               (shared-object-load headers)))))))
    (else
      (begin
        (define-syntax define-c-library
          (syntax-rules ()
            ((_ scheme-name headers object-name options)
             (define scheme-name
               (let* ((string-split
                        (lambda (str mark)
                          (let* ((str-l (string->list str))
                                 (res (list))
                                 (last-index 0)
                                 (index 0)
                                 (splitter (lambda (c)
                                             (cond ((char=? c mark)
                                                    (begin
                                                      (set! res (append res (list (substring str last-index index))))
                                                      (set! last-index (+ index 1))))
                                                   ((equal? (length str-l) (+ index 1))
                                                    (set! res (append res (list (substring str last-index (+ index 1)))))))
                                             (set! index (+ index 1)))))
                            (for-each splitter str-l)
                            res)))
                      (internal-options (if (null? 'options)
                                          (list)
                                          (cadr 'options)))
                      (additional-paths (if (assoc 'additional-paths internal-options)
                                          (cadr (assoc 'additional-paths internal-options))
                                          (list)))
                      (additional-versions (if (assoc 'additional-versions internal-options)
                                             (map (lambda (version)
                                                    (if (number? version)
                                                      (number->string version)
                                                      version))
                                                  (cadr (assoc 'additional-versions internal-options)))
                                             (list)))
                      (slash (if (symbol=? os 'windows) "\\" "/"))
                      (auto-load-paths
                        (cond
                          ((symbol=? os 'windows)
                           (append
                             (if (get-environment-variable "FOREIGN_C_LOAD_PATH")
                               (string-split (get-environment-variable "FOREIGN_C_LOAD_PATH") (string-ref ";" 0))
                               (list))
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
                                       slash
                                       "system32"))
                               (list))
                             (list ".")
                             (if (get-environment-variable "PATH")
                               (string-split (get-environment-variable "PATH") (string-ref ";" 0))
                               (list))
                             (if (get-environment-variable "PWD")
                               (list (get-environment-variable "PWD"))
                               (list))))
                          (else
                            (append
                              (if (get-environment-variable "FOREIGN_C_LOAD_PATH")
                                (string-split (get-environment-variable "FOREIGN_C_LOAD_PATH") (string-ref ":" 0))
                                (list))
                              ; Guix
                              (list (if (get-environment-variable "GUIX_ENVIRONMENT")
                                      (string-append (get-environment-variable "GUIX_ENVIRONMENT") slash "lib")
                                      "")
                                    "/run/current-system/profile/lib")
                              ; Debian
                              (if (get-environment-variable "LD_LIBRARY_PATH")
                                (string-split (get-environment-variable "LD_LIBRARY_PATH") (string-ref ":" 0))
                                (list))
                              (cond
                                ((symbol=? arch 'i386)
                                 (list
                                   "/lib/i386-linux-gnu"
                                   "/usr/lib/i386-linux-gnu"
                                   "/lib32"
                                   "/usr/lib32"))
                                (else
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
                                    ; NetBSD
                                    "/usr/pkg/lib"
                                    ; Haiku
                                    "/boot/system/lib")))))))
                      (auto-load-versions (list ""))
                      (paths (append auto-load-paths additional-paths))
                      (versions (append additional-versions auto-load-versions))
                      (platform-lib-prefix (if (symbol=? os 'windows) "" "lib"))
                      (platform-file-extension (if (symbol=? os 'windows) ".dll" ".so"))
                      (shared-object #f)
                      (searched-paths (list)))
                 (for-each
                   (lambda (path)
                     (for-each
                       (lambda (version)
                         (let ((library-path
                                 (string-append path
                                                slash
                                                platform-lib-prefix
                                                object-name
                                                (if (symbol=? os 'windows)
                                                  ""
                                                  platform-file-extension)
                                                (if (string=? version "")
                                                  ""
                                                  (string-append
                                                    (if (symbol=? os 'windows)
                                                      "-"
                                                      ".")
                                                    version))
                                                (if (symbol=? os 'windows)
                                                  platform-file-extension
                                                  "")))
                               (library-path-without-suffixes (string-append path
                                                                             slash
                                                                             platform-lib-prefix
                                                                             object-name)))
                           (set! searched-paths (append searched-paths (list library-path)))
                           (when (and (not shared-object)
                                      (file-exists? library-path))
                             (set! shared-object
                               (cond
                                 ((or (symbol=? implementation 'gauche)
                                      (symbol=? implementation 'racket))
                                  library-path-without-suffixes)
                                 (else library-path))))))
                       versions))
                   paths)
                 (if (not shared-object)
                   (begin
                     (display "Could not load shared object: ")
                     (write (list (cons 'object object-name)
                                  (cons 'searched-paths searched-paths)
                                  (cons 'platform-file-extension platform-file-extension)
                                  (cons 'versions versions)))
                     (newline)
                     (display "Searched paths: ")
                     (write searched-paths)
                     (newline)
                     (exit 1))
                   (cond ((symbol=? implementation 'stklos) shared-object)
                         (else (shared-object-load shared-object
                                                   `((additional-versions ,additional-versions))))))))))))))
  (include "c.scm"))

