(import (scheme base)
        (scheme write)
        (scheme load)
        (scheme process-context)
        (retropikzel r7rs-pffi version main))

(define exit-on-fail? #t)

(define tag 'none)
(define-syntax assert
  (syntax-rules ()
    ((_ check value)
     (let ((result (apply check (list value))))
       (if (not result) (display "FAIL: ") (display "PASS: "))
       (display "[")
       (display tag)
       (display "] ")
       (write (list 'check 'value))
       (newline)
       (when (and exit-on-fail? (not result)) (exit 1))
       ))))

;; pffi-init

(set! tag 'pffi-init)

(pffi-init)

;; pffi-shared-object-auto-load
(set! tag 'pffi-shared-object-auto-load-libc)

(define libc-stdlib
  (if (string=? pffi-os-name "windows")
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "ucrtbase" (list ""))
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "c" (list "" ".6"))))

;; pffi-define
(set! tag 'pffi-define-atoi)
(pffi-define atoi libc-stdlib 'atoi 'int (list 'pointer))
(assert number? (atoi (pffi-string->pointer "100")))

;; Size of

(set! tag 'size-of)
(assert number? (pffi-size-of 'int8))
(assert number? (pffi-size-of 'uint8))
(assert number? (pffi-size-of 'int16))
(assert number? (pffi-size-of 'uint16))
(assert number? (pffi-size-of 'int32))
(assert number? (pffi-size-of 'uint32))
(assert number? (pffi-size-of 'int64))
(assert number? (pffi-size-of 'uint64))
(assert number? (pffi-size-of 'char))
(assert number? (pffi-size-of 'unsigned-char))
(assert number? (pffi-size-of 'short))
(assert number? (pffi-size-of 'unsigned-short))
(assert number? (pffi-size-of 'int))
(assert number? (pffi-size-of 'unsigned-int))
(assert number? (pffi-size-of 'long))
(assert number? (pffi-size-of 'unsigned-long))
(assert number? (pffi-size-of 'float))
(assert number? (pffi-size-of 'double))
(assert number? (pffi-size-of 'string))
(assert number? (pffi-size-of 'pointer))

(exit 0)
