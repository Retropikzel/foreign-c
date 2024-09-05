(import (scheme base)
        (scheme write)
        (scheme load)
        (scheme process-context)
        (retropikzel r7rs-pffi version main))

(define-syntax assert
  (syntax-rules ()
    ((_ check value-a value-b)
     (let ((result (apply check (list value-a value-b))))
       (if (not result) (display "FAIL: ") (display "PASS: "))
       (write (list 'check 'value-a 'value-b))
       (newline)
       (when (not result) (exit 1))))))

;; pffi-init

(pffi-init)

;; pffi-shared-object-auto-load

(define libc-stdlib
  (if (string=? pffi-os-name "windows")
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "ucrtbase" (list ""))
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "c" (list "" ".6"))))

;; pffi-define
(pffi-define atoi libc-stdlib 'atoi 'int (list 'pointer))
(assert = (atoi (pffi-string->pointer "100")) 100)

;; Size of

(assert equal? (number? (pffi-size-of 'int8)) #t)
(assert equal? (number? (pffi-size-of 'uint8)) #t)
(assert equal? (number? (pffi-size-of 'int16)) #t)
(assert equal? (number? (pffi-size-of 'uint16)) #t)
(assert equal? (number? (pffi-size-of 'int32)) #t)
(assert equal? (number? (pffi-size-of 'uint32)) #t)
(assert equal? (number? (pffi-size-of 'int64)) #t)
(assert equal? (number? (pffi-size-of 'uint64)) #t)
(assert equal? (number? (pffi-size-of 'char)) #t)
(assert equal? (number? (pffi-size-of 'unsigned-char)) #t)
(assert equal? (number? (pffi-size-of 'short)) #t)
(assert equal? (number? (pffi-size-of 'unsigned-short)) #t)
(assert equal? (number? (pffi-size-of 'int)) #t)
(assert equal? (number? (pffi-size-of 'unsigned-int)) #t)
(assert equal? (number? (pffi-size-of 'long)) #t)
(assert equal? (number? (pffi-size-of 'unsigned-long)) #t)
(assert equal? (number? (pffi-size-of 'float)) #t)
(assert equal? (number? (pffi-size-of 'double)) #t)
(assert equal? (number? (pffi-size-of 'string)) #t)
(assert equal? (number? (pffi-size-of 'pointer)) #t)

(exit 0)
