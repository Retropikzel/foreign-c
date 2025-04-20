(cond-expand
  (windows (pffi-define-library pffi-libc-stdlib
                                '("stdlib.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library pffi-libc-stdlib
                             '("stdlib.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(cond-expand
  (windows (pffi-define-library pffi-libc-stdio
                                '("stdio.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library pffi-libc-stdio
                             '("stdio")
                             "c"
                             '((additional-versions ("0" "6"))))))
;(pffi-define-function c-snprintf pffi-libc-stdio 'snprintf 'int '(pointer int pointer pointer))
;(pffi-define-function c-strtol pffi-libc-stdio 'strtol 'uint64 '(pointer pointer int))

(cond-expand
  (chibi #t) ; FIXME
  (else (pffi-define-function pffi-pointer-allocate pffi-libc-stdlib 'malloc 'pointer '(int))))

(pffi-define-function pffi-pointer-allocate-calloc pffi-libc-stdlib 'calloc 'pointer '(int int))

(cond-expand
  (chibi #t) ; FIXME
  (else (pffi-define-function pffi-pointer-free pffi-libc-stdlib 'free 'void '(pointer))))

#;(define pffi-pointer-null
  (lambda ()
    (let ((pointer (pffi-pointer-allocate (pffi-size-of 'pointer))))
      (pffi-pointer-set! pointer 'int 0 0)
      pointer)))

#;(define pffi-pointer-null?
  (lambda (pointer)
    (let ((address
            (let ((str (pffi-pointer-allocate 512)))
              (c-snprintf str 512 (pffi-string->pointer "%p") pointer)
              (display "Scheme: p1 address: ")
              (write (pffi-pointer->string str))
              (newline)
              (display "Scheme: p1 address int: ")
              (write (c-strtol str (pffi-pointer-null) 16))
              (newline)
              (c-strtol str (pffi-pointer-null) 16))))
      (= address 0))))

#;(define pffi-pointer-address
  (lambda (pointer)
    (let* ((address-number
             (let ((str (pffi-pointer-allocate 512)))
               (c-snprintf str 512 (pffi-string->pointer "%p") pointer)
               (display "Scheme: p1 address: ")
               (write (pffi-pointer->string str))
               (newline)
               (display "Scheme: p1 address int: ")
               (write (c-strtol str (pffi-pointer-null) 16))
               (newline)
               (c-strtol str (pffi-pointer-null) 16)))
           (address (pffi-pointer-allocate (pffi-size-of 'uint64))))
               (display "Scheme: p2 address: ")
               (write address)
               (newline)
      ;address-number
      (pffi-pointer-set! address 'uint64 0 address-number)
      ;address-number
      ;(pffi-pointer-get address 'pointer 0)
      address
      )
    ))
