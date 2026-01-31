(define-library
  (foreign c)
  ;; SCHEME-primitives.scm must implement:
  ;; size-of-type
  ;; align-of-type
  ;; shared-object-load
  ;; define-c-procedure
  ;; c-bytevector?
  ;; c-bytevector-u8-ref
  ;; c-bytevector-u8-set!
  ;; c-bytevector-pointer-ref
  ;; c-bytevector-pointer-set!
  ;; make-c-null
  ;; c-null?
  (cond-expand
    ;(capyscheme (import (foreign c capyscheme-primitives)))
    (chezscheme (import (chezscheme)
                        (only (rnrs bytevectors) native-endianness)
                        (srfi :0)
                        (srfi :98))
                (include "c/chezscheme-primitives.scm")
                (export foreign-procedure
                        type->native-type
                        make-c-null
                        c-null?))
    (chibi (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact))
           (include-shared "c/chibi-primitives")
           (include "c/chibi-primitives.scm"))
    (chicken (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact)
                     (chicken base)
                     (chicken foreign)
                     (chicken locative)
                     (chicken syntax)
                     (chicken memory)
                     (chicken random))
             (export foreign-declare
                     foreign-safe-lambda
                     foreign-value
                     unspecified
                     u8->s8
                     s8->u8
                     shared-object-load
                     define-c-procedure)
             (include "c/chicken-primitives.scm"))
    ;(cyclone (import (foreign c cyclone-primitives)))
    ;(gambit (import (foreign c gambit-primitives)))
    ;(gauche (import (scheme base) (scheme write) (scheme char) (scheme file) (scheme process-context) (scheme inexact)) ;(rename (gauche ffi) (size-of-type gauche:size-of-type) (align-of-type gauche:align-of-type)) (include "c/gauche-primitives.scm"))
    (guile (import (scheme base)
                   (scheme write)
                   (scheme char)
                   (scheme file)
                   (scheme process-context)
                   (scheme inexact)
                   (system foreign)
                   (system foreign-library))
           (include "c/guile-primitives.scm"))
    (ikarus (import (except (scheme base) include)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (ikarus include)
                    (ikarus foreign))
            (include "c/ikarus-primitives.scm"))
    (ironscheme (import (except (scheme base) cond-expand)
                        (scheme write)
                        (scheme char)
                        (scheme file)
                        (scheme process-context)
                        (scheme inexact)
                        (ironscheme clr)
                        (ironscheme clr internal)
                        (ironscheme ffi))
                (include "c/ironscheme-primitives.scm"))
    #;(kawa (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact))
          (include "c/kawa-primitives.scm"))
    ;(mit-scheme (import (foreign c mit-scheme-primitives)))
    ;(larceny (import (foreign c larceny-primitives)))
    (mosh (import (scheme base)
                  (scheme write)
                  (scheme char)
                  (scheme file)
                  (scheme process-context)
                  (scheme inexact)
                  (mosh ffi))
          (include "c/mosh-primitives.scm"))
    (racket (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (ffi winapi)
                    (compatibility mlist)
                    (ffi unsafe)
                    (ffi vector))
            (include "c/racket-primitives.scm"))
    (sagittarius (import (scheme base)
                         (scheme write)
                         (scheme char)
                         (scheme file)
                         (scheme process-context)
                         (scheme inexact)
                         (except (sagittarius ffi)
                                 c-free
                                 c-malloc
                                 define-c-struct))
                 (include "c/sagittarius-primitives.scm"))
    (stklos (import (scheme base)
                    (scheme write)
                    (scheme char)
                    (scheme file)
                    (scheme process-context)
                    (scheme inexact)
                    (only (stklos)
                          %make-callback
                          make-external-function
                          allocate-bytes
                          free-bytes
                          cpointer?
                          cpointer-null?
                          cpointer-data
                          cpointer-data-set!
                          cpointer-set-abs!
                          cpointer-ref-abs
                          c-size-of
                          void?))
            (include "c/stklos-primitives.scm")
            (export make-external-function
                    free-bytes
                    file-exists?
                    c-bytevector-pointer-set!
                    c-bytevector-pointer-ref))
    (ypsilon (import (scheme base)
                     (scheme write)
                     (scheme char)
                     (scheme file)
                     (scheme process-context)
                     (scheme inexact)
                     (ypsilon c-ffi)
                     (ypsilon c-types)
                     (only (core)
                           define-macro
                           syntax-case
                           bytevector-c-int8-set!
                           bytevector-c-uint8-ref))
             (include "c/ypsilon-primitives.scm")
             (export c-function
                     bytevector-c-int8-set!
                     bytevector-c-uint8-ref)))
  (export
    ;; Types
    c-type-size
    c-type-align

    ;; Libraries and procedures
    define-c-library
    define-c-procedure
    ;define-c-callback ;; TODO

    ;; c-bytevectors
    make-c-bytevector
    c-bytevector
    c-bytevector?
    c-free
    make-c-null
    c-null?
    c-bytevector-set!
    c-bytevector-ref
    bytevector->c-bytevector
    c-bytevector->bytevector
    c-bytevector->integer
    integer->c-bytevector

    ;; Strings
    string->c-utf8
    c-utf8->string

    ;; Pass pointer by address
    call-with-address-of

    ;; Structs
    define-c-struct

    ;; Utilities
    libc-name)
  (include "c-r6rs-bytevectors.scm")
  (include "c-types.scm")
  (include "c-bytevector.scm")
  (include "c-call-with-address-of.scm")
  (include "c-struct.scm")
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
               (let* ((os (cond-expand (windows 'windows) (guile 'unix) (else 'unix)))
                      (arch (cond-expand (i386 'i386) (guile 'x86_64) (else 'x86_64)))
                      (string-split
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
                        (if (symbol=? os 'windows)
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
                              (list)))
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
                            (if (symbol=? arch 'i386)
                              (list
                                "/lib/i386-linux-gnu"
                                "/usr/lib/i386-linux-gnu"
                                "/lib32"
                                "/usr/lib32")
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
                                "/boot/system/lib")))))
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
                               (cond-expand
                                 (gauche library-path-without-suffixes)
                                 (racket library-path-without-suffixes)
                                 (guile library-path)
                                 (else library-path))))))
                       versions))
                   paths)
                 (if (not shared-object)
                   (error "Could not load shared object: "
                          (list (cons 'object object-name)
                                (cons 'searched-paths searched-paths)
                                (cons 'platform-file-extension platform-file-extension)
                                (cons 'versions versions)))
                   (cond-expand
                     (stklos shared-object)
                     (guile (shared-object-load shared-object
                                                `((additional-versions ,additional-versions))))
                     (else (shared-object-load shared-object
                                               `((additional-versions ,additional-versions))))))))))))))

  (cond-expand
    (chicken
      (begin
        (define libc-name
          (cond-expand
            (windows "ucrtbase")
            (haiku "root")
            (else "c")))
        (define-c-library libc
                          '("stdlib.h" "stdio.h" "string.h")
                          libc-name
                          '((additional-versions ("0" "6"))))

        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define (c-memset-address->pointer address value offset) (address->pointer address))
        (define (c-memset-pointer->address pointer value offset) (pointer->address pointer))))
    (else
      (begin
        (define libc-name
          (cond-expand
            (windows "ucrtbase")
            (haiku "root")
            (guile "c")
            (else "c")))
        (define-c-library libc
                          '("stdlib.h" "stdio.h" "string.h")
                          libc-name
                          '((additional-versions ("0" "6"))))

        (define-c-procedure c-malloc libc 'malloc 'pointer '(int))
        (define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
        (define-c-procedure c-perror libc 'perror 'void '(pointer))
        (define-c-procedure c-free libc 'free 'void '(pointer))
        (define-c-procedure c-strlen libc 'strlen 'int '(pointer))
        (define-c-procedure c-memset-address->pointer libc 'memset 'pointer '(u64 u8 int))
        (define-c-procedure c-memset-pointer->address libc 'memset 'u64 '(pointer u8 int)))))
  (cond-expand
    ;; FIXME
    (ypsilon
      (begin
        (define (make-c-null) (c-memset-address->pointer 0 0 0))
        (define (c-null? pointer)
          (call-with-current-continuation
            (lambda (k)
              (with-exception-handler
                (lambda (x) (k #f))
                (lambda ()
                  (and (c-bytevector? pointer)
                       (= (c-memset-pointer->address pointer 0 0) 0)))))))))
    (else)))

