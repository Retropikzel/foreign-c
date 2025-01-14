(import (scheme base)
        (scheme write)
        (scheme char)
        (scheme process-context)
        (retropikzel r7rs-pffi))

(define print-header
  (lambda (title)
    (set-tag title)
    (display "=========================================")
    (newline)
    (display title)
    (newline)
    (display "=========================================")
    (newline)))

(define count 0)
(define assert-tag 'none)

(define set-tag
  (lambda (tag)
    (set! assert-tag tag)
    (set! count 0)))

(define-syntax assert
  (syntax-rules ()
    ((_ check value-a value-b)
     (let ((result (apply check (list value-a value-b))))
       (set! count (+ count 1))
       (if (not result) (display "FAIL ") (display "PASS "))
       (display "[")
       (display assert-tag)
       (display " - ")
       (display count)
       (display "]")
       (display ": ")
       (write (list 'check 'value-a 'value-b))
       (newline)
       (when (not result) (exit 1))))))

(define-syntax debug
  (syntax-rules ()
    ((_ value)
     (begin
       (display 'value)
       (display ": ")
       (write value)
       (newline)))))

;; pffi-init

(print-header 'pffi-init)

(pffi-init)

;; pffi-size-of

(print-header 'pffi-size-of)

(define size-int8 (pffi-size-of 'int8))
(debug size-int8)
(assert equal? (number? size-int8) #t)
(assert = size-int8 1)

(define size-uint8 (pffi-size-of 'uint8))
(debug size-uint8)
(assert equal? (number? size-uint8) #t)
(assert = size-uint8 1)

(assert equal? (number? (pffi-size-of 'uint8)) #t)
(define size-int16 (pffi-size-of 'int16))
(debug size-int16)
(assert equal? (number? size-int16) #t)
(assert = size-int16 2)

(assert equal? (number? (pffi-size-of 'int16)) #t)
(define size-uint16 (pffi-size-of 'uint16))
(debug size-uint16)
(assert equal? (number? size-uint16) #t)
(assert = size-uint16 2)

(assert equal? (number? (pffi-size-of 'uint16)) #t)
(define size-int32 (pffi-size-of 'int32))
(debug size-int32)
(assert equal? (number? size-int32) #t)
(assert = size-int32 4)

(assert equal? (number? (pffi-size-of 'int32)) #t)
(define size-uint32 (pffi-size-of 'uint32))
(debug size-uint32)
(assert equal? (number? size-uint32) #t)
(assert = size-uint32 4)

(assert equal? (number? (pffi-size-of 'uint32)) #t)
(define size-int64 (pffi-size-of 'int64))
(debug size-int64)
(assert equal? (number? size-int64) #t)
(assert = size-int64 8)

(assert equal? (number? (pffi-size-of 'int64)) #t)
(define size-uint64 (pffi-size-of 'uint64))
(debug size-uint64)
(assert equal? (number? size-uint64) #t)
(assert = size-uint64 8)

(assert equal? (number? (pffi-size-of 'uint64)) #t)
(define size-char (pffi-size-of 'char))
(debug size-char)
(assert equal? (number? size-char) #t)
(assert = size-char 1)

(assert equal? (number? (pffi-size-of 'char)) #t)
(define size-unsigned-char (pffi-size-of 'unsigned-char))
(debug size-unsigned-char)
(assert equal? (number? size-unsigned-char) #t)
(assert = size-unsigned-char 1)

(assert equal? (number? (pffi-size-of 'unsigned-char)) #t)
(define size-short (pffi-size-of 'short))
(debug size-short)
(assert equal? (number? size-short) #t)
(assert = size-short 2)

(assert equal? (number? (pffi-size-of 'short)) #t)
(define size-unsigned-short (pffi-size-of 'unsigned-short))
(debug size-unsigned-short)
(assert equal? (number? size-unsigned-short) #t)
(assert = size-unsigned-short 2)

(assert equal? (number? (pffi-size-of 'unsigned-short)) #t)
(define size-int (pffi-size-of 'int))
(debug size-int)
(assert equal? (number? size-int) #t)
(assert = size-int 4)

(assert equal? (number? (pffi-size-of 'int)) #t)
(define size-unsigned-int (pffi-size-of 'unsigned-int))
(debug size-unsigned-int)
(assert equal? (number? size-unsigned-int) #t)
(assert = size-unsigned-int 4)

(cond-expand
  (larceny ;; Works on 32 bit mode
    (assert equal? (number? (pffi-size-of 'long)) #t)
    (define size-long (pffi-size-of 'long))
    (debug size-long)
    (assert equal? (number? size-long) #t)
    (assert = size-long 4))
  (else
    (assert equal? (number? (pffi-size-of 'long)) #t)
    (define size-long (pffi-size-of 'long))
    (debug size-long)
    (assert equal? (number? size-long) #t)
    (assert = size-long 8)))

(cond-expand
  (larceny ;; Works on 32 bit mode
    (assert equal? (number? (pffi-size-of 'unsigned-long)) #t)
    (define size-unsigned-long (pffi-size-of 'unsigned-long))
    (debug size-unsigned-long)
    (assert equal? (number? size-unsigned-long) #t)
    (assert = size-unsigned-long 4))
  (else
    (assert equal? (number? (pffi-size-of 'long)) #t)
    (define size-unsigned-long (pffi-size-of 'unsigned-long))
    (debug size-unsigned-long)
    (assert equal? (number? size-unsigned-long) #t)
    (assert = size-unsigned-long 8)))

(assert equal? (number? (pffi-size-of 'float)) #t)
(define size-float (pffi-size-of 'float))
(debug size-float)
(assert equal? (number? size-float) #t)
(assert = size-float 4)

(assert equal? (number? (pffi-size-of 'double)) #t)
(define size-double (pffi-size-of 'double))
(debug size-double)
(assert equal? (number? size-double) #t)
(assert = size-double 8)

(cond-expand
  (larceny ;; Works on 32 bit mode
    (define size-pointer (pffi-size-of 'pointer))
    (debug size-pointer)
    (assert equal? (number? size-pointer) #t)
    (assert = size-pointer 4))
  (else
    (define size-pointer (pffi-size-of 'pointer))
    (debug size-pointer)
    (assert equal? (number? size-pointer) #t)
    (assert = size-pointer 8)))

;; pffi-align-of

(print-header 'pffi-align-of)

(define align-int8 (pffi-align-of 'int8))
(debug align-int8)
(assert equal? (number? align-int8) #t)
(assert = align-int8 1)

(define align-uint8 (pffi-align-of 'uint8))
(debug align-uint8)
(assert equal? (number? align-uint8) #t)
(assert = align-uint8 1)

(assert equal? (number? (pffi-align-of 'uint8)) #t)
(define align-int16 (pffi-align-of 'int16))
(debug align-int16)
(assert equal? (number? align-int16) #t)
(assert = align-int16 2)

(assert equal? (number? (pffi-align-of 'int16)) #t)
(define align-uint16 (pffi-align-of 'uint16))
(debug align-uint16)
(assert equal? (number? align-uint16) #t)
(assert = align-uint16 2)

(assert equal? (number? (pffi-align-of 'uint16)) #t)
(define align-int32 (pffi-align-of 'int32))
(debug align-int32)
(assert equal? (number? align-int32) #t)
(assert = align-int32 4)

(assert equal? (number? (pffi-align-of 'int32)) #t)
(define align-uint32 (pffi-align-of 'uint32))
(debug align-uint32)
(assert equal? (number? align-uint32) #t)
(assert = align-uint32 4)

(assert equal? (number? (pffi-align-of 'uint32)) #t)
(define align-int64 (pffi-align-of 'int64))
(debug align-int64)
(assert equal? (number? align-int64) #t)
(assert = align-int64 8)

(assert equal? (number? (pffi-align-of 'int64)) #t)
(define align-uint64 (pffi-align-of 'uint64))
(debug align-uint64)
(assert equal? (number? align-uint64) #t)
(assert = align-uint64 8)

(assert equal? (number? (pffi-align-of 'uint64)) #t)
(define align-char (pffi-align-of 'char))
(debug align-char)
(assert equal? (number? align-char) #t)
(assert = align-char 1)

(assert equal? (number? (pffi-align-of 'char)) #t)
(define align-unsigned-char (pffi-align-of 'unsigned-char))
(debug align-unsigned-char)
(assert equal? (number? align-unsigned-char) #t)
(assert = align-unsigned-char 1)

(assert equal? (number? (pffi-align-of 'unsigned-char)) #t)
(define align-short (pffi-align-of 'short))
(debug align-short)
(assert equal? (number? align-short) #t)
(assert = align-short 2)

(assert equal? (number? (pffi-align-of 'short)) #t)
(define align-unsigned-short (pffi-align-of 'unsigned-short))
(debug align-unsigned-short)
(assert equal? (number? align-unsigned-short) #t)
(assert = align-unsigned-short 2)

(assert equal? (number? (pffi-align-of 'unsigned-short)) #t)
(define align-int (pffi-align-of 'int))
(debug align-int)
(assert equal? (number? align-int) #t)
(assert = align-int 4)

(assert equal? (number? (pffi-align-of 'int)) #t)
(define align-unsigned-int (pffi-align-of 'unsigned-int))
(debug align-unsigned-int)
(assert equal? (number? align-unsigned-int) #t)
(assert = align-unsigned-int 4)

(cond-expand
  (larceny ;; Works on 32 bit mode
    (assert equal? (number? (pffi-align-of 'long)) #t)
    (define align-long (pffi-align-of 'long))
    (debug align-long)
    (assert equal? (number? align-long) #t)
    (assert = align-long 4))
  (else
    (assert equal? (number? (pffi-align-of 'long)) #t)
    (define align-long (pffi-align-of 'long))
    (debug align-long)
    (assert equal? (number? align-long) #t)
    (assert = align-long 8)))

(cond-expand
  (larceny ;; Works on 32 bit mode
    (assert equal? (number? (pffi-align-of 'unsigned-long)) #t)
    (define align-unsigned-long (pffi-align-of 'unsigned-long))
    (debug align-unsigned-long)
    (assert equal? (number? align-unsigned-long) #t)
    (assert = align-unsigned-long 4))
  (else
    (assert equal? (number? (pffi-align-of 'long)) #t)
    (define align-unsigned-long (pffi-align-of 'unsigned-long))
    (debug align-unsigned-long)
    (assert equal? (number? align-unsigned-long) #t)
    (assert = align-unsigned-long 8)))

(assert equal? (number? (pffi-align-of 'float)) #t)
(define align-float (pffi-align-of 'float))
(debug align-float)
(assert equal? (number? align-float) #t)
(assert = align-float 4)

(assert equal? (number? (pffi-align-of 'double)) #t)
(define align-double (pffi-align-of 'double))
(debug align-double)
(assert equal? (number? align-double) #t)
(assert = align-double 8)

(cond-expand
  (larceny ;; Works on 32 bit mode
    (define align-pointer (pffi-align-of 'pointer))
    (debug align-pointer)
    (assert equal? (number? align-pointer) #t)
    (assert = align-pointer 4))
  (else
    (define align-pointer (pffi-align-of 'pointer))
    (debug align-pointer)
    (assert equal? (number? align-pointer) #t)
    (assert = align-pointer 8)))

;; pffi-shared-object-auto-load

(print-header 'pffi-shared-object-auto-load)

(define libc-stdlib
  (cond-expand
    (windows (pffi-shared-object-auto-load (list "stdlib.h") (list) "ucrtbase" (list "")))
    (else (pffi-shared-object-auto-load (list "stdlib.h") (list) "c" (list "" ".6")))))

(debug libc-stdlib)

;; pffi-pointer-null

(print-header 'pffi-pointer-null)

(define null-pointer (pffi-pointer-null))
(debug null-pointer)
(assert equal? (pffi-pointer-null? null-pointer) #t)

;; pffi-pointer-null?

(print-header 'pffi-pointer-null?)

(define is-null-pointer (pffi-pointer-null))
(debug is-null-pointer)
(assert equal? (pffi-pointer-null? is-null-pointer) #t)
(assert equal? (pffi-pointer-null? 100) #f)
(assert equal? (pffi-pointer-null? 'bar) #f)

;; pffi-pointer-allocate

(print-header 'pffi-pointer-allocate)

(define test-pointer (pffi-pointer-allocate 100))
(debug test-pointer)
(assert equal? (pffi-pointer? test-pointer) #t)
(assert equal? (pffi-pointer-null? test-pointer) #f)

;; pffi-pointer?

(print-header 'pffi-pointer?)

(define is-pointer (pffi-pointer-allocate 100))
(debug is-pointer)
(assert equal? (pffi-pointer? is-pointer) #t)
(assert equal? (pffi-pointer? 100) #f)
(assert equal? (pffi-pointer? 'bar) #f)

;; pffi-pointer-free

(print-header 'pffi-pointer-free)

(define pointer-to-be-freed (pffi-pointer-allocate 100))
(debug pointer-to-be-freed)
(pffi-pointer-free pointer-to-be-freed)
(debug pointer-to-be-freed)

;; pffi-pointer-set! and pffi-pointer-get 1/2

(print-header "pffi-pointer-set! and pffi-pointer-get 1/2")

(define set-pointer (pffi-pointer-allocate 256))
(define offset 50)
(define value 1)
(debug set-pointer)
(debug offset)
(debug value)

(define-syntax test-type
  (syntax-rules ()
    ((_ type)
     (begin
       (pffi-pointer-set! set-pointer type offset value)
       (assert = (pffi-pointer-get set-pointer type offset) value)))))

(test-type 'int8)
(test-type 'uint8)
(test-type 'int16)
(test-type 'uint16)
(test-type 'int32)
(test-type 'uint32)
(test-type 'int64)
(test-type 'uint64)
(test-type 'short)
(test-type 'unsigned-short)
(test-type 'int)
(test-type 'unsigned-int)
(test-type 'long)
(test-type 'unsigned-long)

(pffi-pointer-set! set-pointer 'char offset #\X)
(debug (pffi-pointer-get set-pointer 'char offset))
(assert char=? (pffi-pointer-get set-pointer 'char offset) #\X)

(pffi-pointer-set! set-pointer 'float offset 1.5)
(debug (pffi-pointer-get set-pointer 'float offset))
(assert = (pffi-pointer-get set-pointer 'float offset) 1.5)

(pffi-pointer-set! set-pointer 'double offset 1.5)
(debug (pffi-pointer-get set-pointer 'double offset))
(assert = (pffi-pointer-get set-pointer 'double offset) 1.5)

; pffi-struct-allocate

(print-header "pffi-struct")

(define struct1 (pffi-struct-allocate 'test '((int . r) (int . g) (int . b))))
(debug struct1)
(debug (pffi-struct-size struct1))
(assert = (pffi-struct-size struct1) 12)

(define struct2 (pffi-struct-allocate 'test '((int8 . r) (int8 . g) (int . b))))
(debug struct2)
(debug (pffi-struct-size struct2))
(assert = (pffi-struct-size struct2) 8)

(define struct3 (pffi-struct-allocate 'test '((int8 . r) (int8 . g) (int . b))))
(debug struct3)
(debug (pffi-struct-size struct3))
(assert = (pffi-struct-size struct3) 8)

(define struct4 (pffi-struct-allocate 'test '((int8 . r) (pointer . a) (int8 . g) (int . b))))
(debug struct4)
(debug (pffi-struct-size struct4))
(assert = (pffi-struct-size struct4) 24)

(define struct5 (pffi-struct-allocate 'test '((int8 . r) (char . b) (pointer . a) (int8 . g) (int . b))))
(debug struct5)
(debug (pffi-struct-size struct5))
(assert = (pffi-struct-size struct5) 24)

(define struct6 (pffi-struct-allocate 'test '((int8 . r)
                                              (char . b)
                                              (double . c)
                                              (char bb)
                                              (pointer . a)
                                              (float . d)
                                              (pointer . aa)
                                              (int8 . g)
                                              (pointer . aaa)
                                              (int . bbb)
                                              (int . bbbb)
                                              (int . bbbb)
                                              (double . c)
                                              (float . d)
                                              )))
(debug struct6)
(debug (pffi-struct-size struct6))
(assert = (pffi-struct-size struct6) 96)

#|
;; pffi-string->pointer

(print-header 'pffi-string->pointer)

(define string-pointer (pffi-string->pointer "Hello world"))
(debug string-pointer)
(assert equal? (pffi-pointer? string-pointer) #t)
(assert equal? (pffi-pointer-null? string-pointer) #f)
(debug (pffi-pointer-get string-pointer 'char 0))
(assert char=? (pffi-pointer-get string-pointer 'char 0) #\H)
(debug (pffi-pointer-get string-pointer 'char 1))
(assert char=? (pffi-pointer-get string-pointer 'char 1) #\e)
(debug (pffi-pointer-get string-pointer 'char 2))
(assert char=? (pffi-pointer-get string-pointer 'char 2) #\l)
(debug (pffi-pointer-get string-pointer 'char 3))
(assert char=? (pffi-pointer-get string-pointer 'char 3) #\l)
(debug (pffi-pointer-get string-pointer 'char 4))
(assert char=? (pffi-pointer-get string-pointer 'char 4) #\o)
(debug (pffi-pointer-get string-pointer 'char 10))
(assert char=? (pffi-pointer-get string-pointer 'char 10) #\d)

;; pffi-pointer->string

(print-header 'pffi-pointer->string)

(define pointer-string (pffi-pointer->string string-pointer))
(debug pointer-string)
(assert equal? (string? pointer-string) #t)
(assert string=? pointer-string "Hello world")
(assert string=? (pffi-pointer->string (pffi-string->pointer "https://scheme.org")) "https://scheme.org")
(define test-url-string "https://scheme.org")
(debug test-url-string)
(define test-url (pffi-string->pointer test-url-string))
(debug test-url)
(debug (pffi-pointer->string test-url))
(assert equal? (string=? (pffi-pointer->string test-url) test-url-string) #t)

;; pffi-pointer-get

(print-header "pffi-pointer-get")

(define hello-string "hello")
(define hello-string-pointer (pffi-string->pointer hello-string))

(debug (pffi-pointer-get hello-string-pointer 'char 0))
(assert char=? (pffi-pointer-get hello-string-pointer 'char 0) #\h)
(debug (pffi-pointer-get hello-string-pointer 'char 1))
(assert char=? (pffi-pointer-get hello-string-pointer 'char 1) #\e)
(debug (pffi-pointer-get hello-string-pointer 'char 4))
(assert char=? (pffi-pointer-get hello-string-pointer 'char 4) #\o)

;; pffi-pointer-set! and pffi-pointer-get 2/2

(print-header "pffi-pointer-set! and pffi-pointer-get 2/2")

(define pointer-to-be-set (pffi-string->pointer "FOOBAR"))
(debug pointer-to-be-set)
(debug (pffi-pointer->string pointer-to-be-set))
(pffi-pointer-set! set-pointer 'pointer offset pointer-to-be-set)

(debug (pffi-pointer-get set-pointer 'pointer offset))
(assert equal?
        (pffi-pointer? (pffi-pointer-get set-pointer 'pointer offset))
        #t)
(debug (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)))
(assert equal?
        (string? (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)))
        #t)
(assert string=?
        (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset))
        "FOOBAR")

(define string-to-be-set "FOOBAR")
(debug string-to-be-set)
(pffi-pointer-set! set-pointer 'pointer offset (pffi-string->pointer string-to-be-set))
(assert string=? (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)) "FOOBAR")

;; pffi-define

(print-header 'pffi-define)

(pffi-define puts libc-stdlib 'puts 'int (list 'pointer))
(let ((chars-writter (puts (pffi-string->pointer "Hello from testing, I am C function puts"))))
  (display "I have written: ")
  (display chars-writter)
  (display " characters.")
  (newline))

(pffi-define atoi libc-stdlib 'atoi 'int (list 'pointer))
(assert = (atoi (pffi-string->pointer "100")) 100)

;; pffi-define-callback

(print-header 'pffi-define-callback)

(define array (pffi-pointer-allocate (* (pffi-size-of 'int) 3)))
(pffi-pointer-set! array 'int (* (pffi-size-of 'int) 0) 3)
(pffi-pointer-set! array 'int (* (pffi-size-of 'int) 1) 2)
(pffi-pointer-set! array 'int (* (pffi-size-of 'int) 2) 1)

(pffi-define qsort libc-stdlib 'qsort 'void (list 'pointer 'int 'int 'callback))

(pffi-define-callback compare
                      'int
                      (list 'pointer 'pointer)
                      (lambda (pointer-a pointer-b)
                        (let ((a (pffi-pointer-get pointer-a 'int 0))
                              (b (pffi-pointer-get pointer-b 'int 0)))
                          (cond ((> a b) 1)
                                ((= a b) 0)
                                ((< a b) -1)))))
(write compare)
(newline)

(display "Unsorted: ")
(write (list (pffi-pointer-get array 'int (* (pffi-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 2))))
(newline)
(qsort array 3 (pffi-size-of 'int) compare)

(display "Sorted: ")
(write (list (pffi-pointer-get array 'int (* (pffi-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 2))))
(newline)

|#
(exit 0)
