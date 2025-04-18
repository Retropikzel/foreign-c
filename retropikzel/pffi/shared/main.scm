(cond-expand
  (mosh (define pffi-init (lambda () #t)))
  (chicken
   (define-syntax pffi-init
     (er-macro-transformer
       (lambda (expr rename compare)
         '(import (chicken foreign)
                  (chicken memory))
         #t))))
  (gambit #t)
  (ypsilon
    (define-syntax pffi-init
      (syntax-rules ()
        ((_)
         (import (ypsilon ffi)
                 (ypsilon c-types))))))
  (else (define pffi-init (lambda () #t))))

(define pffi-type?
  (lambda (object)
    (if (equal? (size-of-type object) #f)
      #f
      #t)))

(define pffi-size-of
  (lambda (object)
    (cond ((pffi-struct? object) (pffi-struct-size object))
          ((pffi-type? object) (size-of-type object))
          (else (error "Not pffi-struct, pffi-enum of pffi-type" object)))))

(define pffi-string->pointer
  (lambda (str)
    (letrec* ((str-length (string-length str))
              (pointer (pffi-pointer-allocate (+ str-length 1)))
              (looper (lambda (index)
                        (when (< index str-length)
                          (pffi-pointer-set! pointer
                                             'char
                                             index
                                             (string-ref str index))
                          (looper (+ index 1))))))
      (looper 0)
      (pffi-pointer-set! pointer 'char str-length #\null)
      pointer)))

(define pffi-pointer->string
  (lambda (pointer)
    (letrec* ((looper (lambda (index str)
                        (let ((c (pffi-pointer-get pointer 'char index)))
                          (if (char=? c #\null)
                            str
                            (looper (+ index 1) (cons c str)))))))
      (list->string (reverse (looper 0 (list)))))))


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

(cond-expand
  (gambit #t)
  ((or chicken cyclone)
   (define-syntax pffi-define-library
     (syntax-rules ()
       ((_ scheme-name headers object-name options)
        (begin
          (define scheme-name #t)
          (pffi-shared-object-load headers))))))
  (else
    (define-syntax pffi-define-library
      (syntax-rules ()
        ((_ scheme-name headers object-name options)
         (define scheme-name
           (let* ((internal-options (if (null? 'options)
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
                  (slash (cond-expand (windows (string #\\)) (else "/")))
                  (auto-load-paths
                      (cond-expand
                        (windows
                          (append
                            (if (get-environment-variable "PFFI_LOAD_PATH")
                              (string-split (get-environment-variable "PFFI_LOAD_PATH") #\;)
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
                              (string-split (get-environment-variable "PATH") #\;)
                              (list))
                            (if (get-environment-variable "PWD")
                              (list (get-environment-variable "PWD"))
                              (list))))
                        (else
                          (append
                           (if (get-environment-variable "PFFI_LOAD_PATH")
                              (string-split (get-environment-variable "PFFI_LOAD_PATH") #\:)
                              (list))
                            ; Guix
                            (list (if (get-environment-variable "GUIX_ENVIRONMENT")
                                    (string-append (get-environment-variable "GUIX_ENVIRONMENT") slash "lib")
                                    "")
                                  "/run/current-system/profile/lib")
                            ; Debian
                            (if (get-environment-variable "LD_LIBRARY_PATH")
                              (string-split (get-environment-variable "LD_LIBRARY_PATH") #\:)
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
                              ; NetBSD
                              "/usr/pkg/lib")))))
                  (auto-load-versions (list ""))
                  (paths (append auto-load-paths additional-paths))
                  (versions (append additional-versions auto-load-versions))
                  (platform-lib-prefix (cond-expand (windows "") (else "lib")))
                  (platform-file-extension (cond-expand (windows ".dll") (else ".so")))
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
                                            (cond-expand
                                              (windows "")
                                              (else platform-file-extension))
                                            (if (string=? version "")
                                              ""
                                              (string-append
                                                (cond-expand (windows "-")
                                                             (else "."))
                                                version))
                                            (cond-expand
                                              (windows platform-file-extension)
                                              (else ""))))
                           (library-path-without-suffixes (string-append path
                                                                         slash
                                                                         platform-lib-prefix
                                                                         object-name)))
                       (set! searched-paths (append searched-paths (list library-path)))
                       (when (and (not shared-object)
                                  (file-exists? library-path))
                         (set! shared-object
                           (cond-expand (racket library-path-without-suffixes)
                                        (else library-path))))))
                   versions))
               paths)
             (if (not shared-object)
               (begin
                 (display "Could not load shared object: ")
                 (write (list (cons 'object object-name)
                              (cons 'paths paths)
                              (cons 'platform-file-extension platform-file-extension)
                              (cons 'versions versions)))
                 (newline)
                 (display "Searched paths: ")
                 (write searched-paths)
                 (newline)
                 (exit 1))
               (cond-expand
                 (stklos shared-object)
                 (else (pffi-shared-object-load shared-object
                                        `((additional-versions ,additional-versions)))))))))))))
