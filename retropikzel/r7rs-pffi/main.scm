
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


(define auto-load-versions (list ""))

(cond-expand
  (gambit
    (define-macro
      (pffi-shared-object-auto-load headers additional-paths object-name additional-versions)
      `(pffi-shared-object-load ,(car headers))))
  (else
    (define-syntax pffi-shared-object-auto-load
      (syntax-rules ()
        ((pffi-shared-object-auto-load headers additional-paths object-name additional-versions)
         (cond-expand
           (cyclone (pffi-shared-object-load headers))
           (chicken (pffi-shared-object-load headers))
           (else
             (let* ((slash (cond-expand (windows (string #\\)) (else "/")))
                    (auto-load-paths
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
                              "/usr/pkg/lib"
                              )))))
                    (auto-load-versions (list))
                    (paths (append auto-load-paths additional-paths))
                    (versions (append auto-load-versions additional-versions))
                    (platform-lib-prefix
                      (cond-expand
                        (racket (if (equal? (system-type 'os) 'windows) "" "lib"))
                        (windows "")
                        (else "lib")))
                    (platform-file-extension
                      (cond-expand
                        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so"))
                        (windows ".dll")
                        (else ".so")))
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
                 (pffi-shared-object-load headers shared-object))))))))))
