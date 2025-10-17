(define c-type-signed?
  (lambda (type)
    (if (member type '(int8 int16 int32 int64 char short int long float double))
      #t
      #f)))

(define c-type-unsigned?
  (lambda (type)
    (if (member type '(uint8 uint16 uint32 uint64 unsigned-char unsigned-short unsigned-int unsigned-long))
      #t
      #f)))

(define c-type-size
  (lambda (type)
    (size-of-type type)))

(define c-type-align
  (lambda (type)
    (align-of-type type)))

(define foreign-c:string-split
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
  (gambit #t) ; Defined in gambit.scm
  (chicken
    (define-syntax define-c-library
      (syntax-rules ()
        ((_ scheme-name headers object-name options)
         (begin
           (define scheme-name #t)
           (shared-object-load headers))))))
  (cyclone #t) ; Defined in cyclone.scm
  (else
    (define-syntax define-c-library
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
                            (if (get-environment-variable "FOREIGN_C_LOAD_PATH")
                              (foreign-c:string-split (get-environment-variable "FOREIGN_C_LOAD_PATH") #\;)
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
                              (foreign-c:string-split (get-environment-variable "PATH") #\;)
                              (list))
                            (if (get-environment-variable "PWD")
                              (list (get-environment-variable "PWD"))
                              (list))))
                        (else
                          (append
                           (if (get-environment-variable "FOREIGN_C_LOAD_PATH")
                              (foreign-c:string-split (get-environment-variable "FOREIGN_C_LOAD_PATH") #\:)
                              (list))
                            ; Guix
                            (list (if (get-environment-variable "GUIX_ENVIRONMENT")
                                    (string-append (get-environment-variable "GUIX_ENVIRONMENT") slash "lib")
                                    "")
                                  "/run/current-system/profile/lib")
                            ; Debian
                            (if (get-environment-variable "LD_LIBRARY_PATH")
                              (foreign-c:string-split (get-environment-variable "LD_LIBRARY_PATH") #\:)
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
                              ; Haiku
                              "/boot/system/lib")))))
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
                 (else (shared-object-load shared-object
                                        `((additional-versions ,additional-versions)))))))))))))

(cond-expand
  (windows
    (define libc-name "ucrtbase"))
  (else
    (define libc-name
      (cond ((get-environment-variable "BE_HOST_CPU") "root") ; Haiku
            (else "c")))))


(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

;(define-c-procedure c-calloc libc 'calloc 'pointer '(int int))
(cond-expand
  (gambit
    (define c-memset-address->pointer
     (c-lambda (unsigned-int64 unsigned-int8 int)
               (pointer void)
     "___return(memset((void*)___arg1, ___arg2, ___arg3));")))
  (chicken
    (define c-memset-address->pointer
             (lambda (address value offset)
               (address->pointer address))))
  (else
    (define-c-procedure c-memset-address->pointer libc 'memset 'pointer '(uint64 uint8 int))))

(cond-expand
  (gambit
    (define c-memset-pointer->address
     (c-lambda ((pointer void) unsigned-int8 int)
               unsigned-int64
     "___return((uint64_t)memset(___arg1, ___arg2, ___arg3));")))
  (chicken (define c-memset-pointer->address
             (lambda (pointer value offset)
               (pointer->address pointer))))
  (else (define-c-procedure c-memset-pointer->address libc 'memset 'uint64 '(pointer uint8 int))))
;(define-c-procedure c-memset-address libc 'memset 'pointer '(uint64 uint8 int))
;(define-c-procedure c-printf libc 'printf 'int '(pointer pointer))
(define-c-procedure c-malloc libc 'malloc 'pointer '(int))
(define-c-procedure c-strlen libc 'strlen 'int '(pointer))

(define make-c-bytevector
  (lambda (k . byte)
    (if (null? byte)
      (c-malloc k)
      (bytevector->c-bytevector (make-bytevector k (car byte))))))

(define c-bytevector
  (lambda bytes
    (bytevector->c-bytevector (apply bytevector bytes))))

(cond-expand
  (else (define-c-procedure c-free libc 'free 'void '(pointer))))

(define bytevector->c-bytevector
  (lambda (bytes)
    (letrec* ((bytes-length (bytevector-length bytes))
              (pointer (make-c-bytevector bytes-length))
              (looper (lambda (index)
                        (when (< index bytes-length)
                          (c-bytevector-u8-set! pointer
                                                index
                                                (bytevector-u8-ref bytes index))
                          (looper (+ index 1))))))
      (looper 0)
      pointer)))

(define c-bytevector->bytevector
  (lambda (pointer size)
    (letrec* ((bytes (make-bytevector size))
              (looper (lambda (index)
                        (let ((byte (c-bytevector-u8-ref pointer index)))
                          (if (= index size)
                            bytes
                            (begin
                              (bytevector-u8-set! bytes index byte)
                              (looper (+ index 1))))))))
      (looper 0))))

(define c-string-length
  (lambda (bytevector-var)
    (c-strlen bytevector-var)))

(define c-utf8->string
  (lambda (c-bytevector)
    (when (c-null? c-bytevector)
      (error "Can not turn null pointer into string" c-bytevector))
    (let ((size (c-strlen c-bytevector)))
      (utf8->string (c-bytevector->bytevector c-bytevector size)))))

(define string->c-utf8
  (lambda (string-var)
    (bytevector->c-bytevector
      (string->utf8 (string-append string-var (string #\null))))))

(cond-expand
  ;; FIXME
  (chicken
    (define make-c-null
      (lambda ()
        (address->pointer 0))))
  ;; FIXME
  (kawa
    (define make-c-null
      (lambda ()
        (static-field java.lang.foreign.MemorySegment 'NULL))))
  ;(chibi #t)
  (else (define make-c-null
          (lambda ()
            (cond-expand (stklos (let ((pointer (make-c-bytevector 1)))
                                   (free-bytes pointer)
                                   pointer))
                         (else (c-memset-address->pointer 0 0 0)))))))

(cond-expand
  ;; FIXME
  (chicken
    (define c-null?
      (lambda (pointer)
        (if (and (not (pointer? pointer))
                 pointer)
          #f
          (or (not pointer) ; #f counts as null pointer on Chicken
              (= (pointer->address pointer) 0))))))
  ;; FIXME
  (kawa
    (define c-null?
      (lambda (pointer)
        (invoke pointer 'equals null-pointer))))
  ;; FIXME
  (chibi #t) ;; In chibi-primitives.stub
  (gauche (define c-null? pointer-null?))
  (stklos (define c-null?
            (lambda (pointer)
              (cond ((void? pointer) #t)
                    ((= (c-memset-pointer->address pointer 0 0) 0) #t)
                    (else #f)))))
  (else (define c-null?
          (lambda (pointer)
            (if (c-bytevector? pointer)
              (= (c-memset-pointer->address pointer 0 0) 0)
              #f)))))

(define c-bytevector->address
  (lambda (c-bytevector)
    (c-memset-pointer->address c-bytevector 0 0)))

(define address->c-bytevector
  (lambda (address)
    (c-memset-address->pointer address 0 0)))

#;(define c-bytevector-pointer-set!
  (lambda (c-bytevector k pointer)
    (c-bytevector-uint-set! c-bytevector
                            0
                            (c-bytevector->address pointer)
                            (native-endianness)
                            (c-type-size 'pointer))))

#;(define c-bytevector-pointer-ref
  (lambda (c-bytevector k)
    (address->c-bytevector (c-bytevector-uint-ref c-bytevector
                                                  0
                                                  (native-endianness)
                                                  (c-type-size 'pointer)))))

(cond-expand
  ;(kawa #t) ; Defined in kawa.scm
  (else (define-syntax call-with-address-of
          (syntax-rules ()
            ((_ input-pointer thunk)
             (let ((address-pointer (make-c-bytevector (c-type-size 'pointer))))
               (c-bytevector-pointer-set! address-pointer 0 input-pointer)
               (let ((result (apply thunk (list address-pointer))))
                 (set! input-pointer (c-bytevector-pointer-ref address-pointer 0))
                 (c-free address-pointer)
                 result)))))))
