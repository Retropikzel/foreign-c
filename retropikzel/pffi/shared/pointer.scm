(cond-expand
  (windows (define-c-library libc
                             '("stdlib.h" "string.h")
                             "ucrtbase"
                             '((additional-versions ("0" "6")))))
  (else (define-c-library libc
                          '("stdlib.h" "string.h")
                          "c"
                          '((additional-versions ("0" "6"))))))

(define-c-procedure c-strlen libc 'strlen 'int '(pointer))
(define-c-procedure pffi-pointer-allocate-calloc libc 'calloc 'pointer '(int int))
(define-c-procedure c-memset-address->pointer libc 'memset 'pointer '(uint64 uint8 int))
(define-c-procedure c-memset-pointer->address libc 'memset 'uint64 '(pointer uint8 int))
(define-c-procedure c-printf libc 'printf 'int '(pointer pointer))
(define-c-procedure c-malloc libc 'malloc 'pointer '(int))
(define-c-procedure c-strlen libc 'strlen 'int '(pointer))

(cond-expand
  (chibi #t) ; FIXME
  (else (define make-c-bytevector
          (lambda (k . byte)
            (if (null? byte)
              (c-malloc k)
              (bytevector->c-bytevector (make-bytevector k (car byte))))))))

(define c-bytevector
  (lambda bytes
    (bytevector->c-bytevector (apply bytevector bytes))))

(cond-expand
  (chibi #t) ; FIXME
  (else (define-c-procedure c-free libc 'free 'void '(pointer))))

(define bytevector->c-bytevector
  (lambda (bytes)
    (letrec* ((bytes-length (bytevector-length bytes))
              (pointer (make-c-bytevector bytes-length))
              (looper (lambda (index)
                        (when (< index bytes-length)
                          (pffi-pointer-set! pointer
                                             'uint8
                                             index
                                             (bytevector-u8-ref bytes index))
                          (looper (+ index 1))))))
      (looper 0)
      pointer)))

(define c-bytevector->bytevector
  (lambda (pointer size)
    (letrec* ((bytes (make-bytevector size))
              (looper (lambda (index)
                        (let ((byte (pffi-pointer-get pointer 'uint8 index)))
                          (if (= index size)
                            bytes
                            (begin
                              (bytevector-u8-set! bytes index byte)
                              (looper (+ index 1))))))))
      (looper 0))))

(define c-bytevector-string-length
  (lambda (bytevector)
    (c-strlen bytevector)))

(define c-bytevector->string
  (lambda (pointer)
    (when (not (c-bytevector? pointer))
      (error "c-bytevector->string argument not c-bytevector" pointer))
    (let ((size (c-strlen pointer)))
      (utf8->string (c-bytevector->bytevector pointer size)))))

(define string->c-bytevector
  (lambda (text)
    (when (not (string? text))
      (error "string->bytevector argument not string" text))
    (bytevector->c-bytevector (string->utf8 (string-append text (string #\null))))))

(cond-expand
  (kawa #t) ; FIXME
  (chicken #t) ; FIXME
  (else (define make-c-null
          (lambda ()
            (cond-expand (stklos (let ((pointer (make-c-bytevector 1)))
                                   (free-bytes pointer)
                                   pointer))
                         (else (c-memset-address->pointer 0 0 0)))))))

(cond-expand
  (kawa #t) ; FIXME
  (chicken #t) ; FIXME
  (else (define c-null?
          (lambda (pointer)
            (if (c-bytevector? pointer)
              (= (c-memset-pointer->address pointer 0 0) 0)
              #f)))))

(define-syntax call-with-address-of-c-bytevector
  (syntax-rules ()
    ((_ input-pointer thunk)
     (let ((address-pointer (make-c-bytevector (c-size-of 'pointer))))
       (pffi-pointer-set! address-pointer 'pointer 0 input-pointer)
       (apply thunk (list address-pointer))
       (set! input-pointer (pffi-pointer-get address-pointer 'pointer 0))
       (c-free address-pointer)))))

