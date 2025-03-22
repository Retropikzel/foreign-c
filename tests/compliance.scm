(import (scheme base)
        (scheme write)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (retropikzel pffi))

(define header-count 1)

(define print-header
  (lambda (title)
    (set-tag title)
    (display "=========================================")
    (newline)
    (display header-count)
    (display " ")
    (display title)
    (newline)
    (display "=========================================")
    (newline)
    (set! header-count (+ header-count 1))))

(define count 0)
(define assert-tag 'none)

(define set-tag
  (lambda (tag)
    (set! assert-tag tag)
    (set! count 0)))

(cond-expand
  (gambit
    (define assert
      (lambda (check value-a value-b)
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
  (else
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
           (when (not result) (exit 1))))))))

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

;; pffi-type?

(print-header 'pffi-type?)

(debug (pffi-type? 'int8))
(assert equal? (pffi-type? 'int8) #t)
(debug (pffi-type? 'uint8))
(assert equal? (pffi-type? 'uint8) #t)
(debug (pffi-type? 'int16))
(assert equal? (pffi-type? 'int16) #t)
(debug (pffi-type? 'uint16))
(assert equal? (pffi-type? 'uint16) #t)
(debug (pffi-type? 'int32))
(assert equal? (pffi-type? 'int32) #t)
(debug (pffi-type? 'uint32))
(assert equal? (pffi-type? 'uint32) #t)
(debug (pffi-type? 'int64))
(assert equal? (pffi-type? 'int64) #t)
(debug (pffi-type? 'uint64))
(assert equal? (pffi-type? 'uint64) #t)
(debug (pffi-type? 'char))
(assert equal? (pffi-type? 'char) #t)
(debug (pffi-type? 'unsigned-char))
(assert equal? (pffi-type? 'unsigned-char) #t)
(debug (pffi-type? 'short))
(assert equal? (pffi-type? 'short) #t)
(debug (pffi-type? 'unsigned-short))
(assert equal? (pffi-type? 'unsigned-short) #t)
(debug (pffi-type? 'int))
(assert equal? (pffi-type? 'int) #t)
(debug (pffi-type? 'unsigned-int))
(assert equal? (pffi-type? 'unsigned-int) #t)
(debug (pffi-type? 'long))
(assert equal? (pffi-type? 'long) #t)
(debug (pffi-type? 'unsigned-long))
(assert equal? (pffi-type? 'unsigned-long) #t)
(debug (pffi-type? 'float))
(assert equal? (pffi-type? 'float) #t)
(debug (pffi-type? 'double))
(assert equal? (pffi-type? 'double) #t)
(debug (pffi-type? 'pointer))
(assert equal? (pffi-type? 'pointer) #t)
(debug (pffi-type? 'void))
(assert equal? (pffi-type? 'void) #t)
(debug (pffi-type? 'callback))
(assert equal? (pffi-type? 'callback) #t)

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
  (i386
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
  (i386
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
  (i386
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
  (i386
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
  (i386
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
  (i386
    (define align-pointer (pffi-align-of 'pointer))
    (debug align-pointer)
    (assert equal? (number? align-pointer) #t)
    (assert = align-pointer 4))
  (else
    (define align-pointer (pffi-align-of 'pointer))
    (debug align-pointer)
    (assert equal? (number? align-pointer) #t)
    (assert = align-pointer 8)))

;; pffi-define-library

(print-header 'pffi-define-library)

(cond-expand
  (windows (pffi-define-library libc-stdlib
                                '("stdlib.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library libc-stdlib
                             '("stdlib.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(debug libc-stdlib)

(cond-expand
  (windows (pffi-define-library libc-stdio
                                '("stdio.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library libc-stdio
                             '("stdio.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(debug libc-stdio)

(pffi-define-library c-testlib
                     '("libtest.h")
                     "test"
                     '((additional-paths ("." "./tests"))))

(debug c-testlib)

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
;(assert equal? (pffi-pointer? 0) #f)
;(assert equal? (pffi-pointer? #t) #f)
;(assert equal? (pffi-pointer? "Hello world") #f)
(assert equal? (pffi-pointer-null? test-pointer) #f)

;; pffi-pointer-address

(print-header 'pffi-pointer-allocate)

(define test-pointer1 (pffi-pointer-allocate 100))
(debug test-pointer1)
(debug (pffi-pointer? test-pointer1))
(assert equal? (pffi-pointer? test-pointer1) #t)
(debug (pffi-pointer-address test-pointer1))
;(assert equal? (number? (pffi-pointer-address test-pointer1)) #t)
;(assert equal? (> (pffi-pointer-address test-pointer1) 0) #t)

;; pffi-pointer?

(print-header 'pffi-pointer?)

(define is-pointer (pffi-pointer-allocate 100))
(debug is-pointer)
(assert equal? (pffi-pointer? is-pointer) #t)
;(assert equal? (pffi-pointer? 100) #f)
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
(define offset 64)
(define value 1)
(debug set-pointer)
(debug offset)
(debug value)

(cond-expand
  (gambit
    (define test-type
      (lambda (type)
        (begin
          (pffi-pointer-set! set-pointer type offset value)
          (assert = (pffi-pointer-get set-pointer type offset) value)))))
  (else
    (define-syntax test-type
      (syntax-rules ()
        ((_ type)
         (begin
           (pffi-pointer-set! set-pointer type offset value)
           (assert = (pffi-pointer-get set-pointer type offset) value)))))))

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

; pffi-struct-make

(print-header "pffi-struct")

(define struct1 (pffi-struct-make 'test '((int . r) (int . g) (int . b))))
(debug struct1)
(debug (pffi-size-of struct1))
(assert = (pffi-size-of struct1) 12)

(define struct2 (pffi-struct-make 'test '((int8 . r) (int8 . g) (int . b))))
(debug struct2)
(debug (pffi-size-of struct2))
(assert = (pffi-size-of struct2) 8)

(define struct3 (pffi-struct-make 'test '((int8 . r) (int8 . g) (int . b))))
(debug struct3)
(debug (pffi-size-of struct3))
(assert = (pffi-size-of struct3) 8)

(define struct4 (pffi-struct-make 'test '((int8 . r) (pointer . a) (int8 . g) (int . b))))
(debug struct4)
(debug (pffi-size-of struct4))
(assert = (pffi-size-of struct4) 24)

(define struct5 (pffi-struct-make 'test '((int8 . r) (char . b) (pointer . a) (int8 . g) (int . b))))
(debug struct5)
(debug (pffi-size-of struct5))
(assert = (pffi-size-of struct5) 24)

(define struct6 (pffi-struct-make 'test '((int8 . a)
                                          (char . b)
                                          (double . c)
                                          (char . d)
                                          (pointer . e)
                                          (float . f)
                                          (pointer . g)
                                          (int8 . h)
                                          (pointer . i)
                                          (int . j)
                                          (int . k)
                                          (int . l)
                                          (double . m)
                                          (float . n))))
(debug struct6)
(debug (pffi-size-of struct6))
(assert = (pffi-size-of struct6) 96)

;; pffi-string->pointer

(print-header 'pffi-string->pointer)

(define string-pointer (pffi-string->pointer "Hello world"))
(debug string-pointer)
(debug (pffi-pointer->string string-pointer))
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
(debug (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)))
(assert equal?
        (string=? (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)) "FOOBAR")
        #t)

(define string-to-be-set "FOOBAR")
(debug string-to-be-set)
(pffi-pointer-set! set-pointer 'pointer offset (pffi-string->pointer string-to-be-set))
(assert string=? (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset)) "FOOBAR")

;; pffi-define

(print-header 'pffi-define)

(pffi-define c-abs libc-stdlib 'abs 'int (list 'int))
(debug c-abs)
(define absoluted (c-abs -2))
(debug absoluted)
(assert = absoluted 2)

(pffi-define c-puts libc-stdlib 'puts 'int (list 'pointer))
(debug c-puts)
(define chars-written (c-puts (pffi-string->pointer "puts: Hello from testing, I am C function puts")))
(debug chars-written)
(assert = chars-written 47)

(pffi-define c-atoi libc-stdlib 'atoi 'int (list 'pointer))
(assert = (c-atoi (pffi-string->pointer "100")) 100)

(pffi-define c-fopen libc-stdio 'fopen 'pointer (list 'pointer 'pointer))
(define output-file (c-fopen (pffi-string->pointer "testfile.test")
                              (pffi-string->pointer "w")))
(debug output-file)
(pffi-define c-fprintf libc-stdio 'fprintf 'int (list 'pointer 'pointer))
(define characters-written
  (c-fprintf output-file (pffi-string->pointer "Hello world")))
(debug characters-written)
(assert equal? (= characters-written 11) #t)
(pffi-define c-fclose libc-stdio 'fclose 'int (list 'pointer))
(define closed-status (c-fclose output-file))
(debug closed-status)
(assert equal? (= closed-status 0) #t)
(assert equal? (file-exists? "testfile.test") #t)
(assert equal? (string=? (with-input-from-file "testfile.test"
                                               (lambda () (read-line)))
                         "Hello world") #t)

(pffi-define c-takes-no-args c-testlib 'takes_no_args 'void (list))
(debug c-takes-no-args)
(c-takes-no-args)

(pffi-define c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int (list))
(debug c-takes-no-args)
(define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
(assert equal? (= takes-no-args-returns-int-result 0) #t)

;; pffi-struct-get

(print-header 'pffi-struct-get)

(pffi-define c-init-struct c-testlib 'init_struct 'pointer (list 'pointer))
(pffi-define c-check-offset c-testlib 'check_offset 'void (list 'int 'int))
(define struct-test (pffi-struct-make 'test
                                          '((int8 . a)
                                            (char . b)
                                            (double . c)
                                            (char . d)
                                            (pointer . e)
                                            (float . f)
                                            (pointer . g)
                                            (int8 . h)
                                            (pointer . i)
                                            (int . j)
                                            (int . k)
                                            (int . l)
                                            (double . m)
                                            (float . n))))
(c-check-offset 1 (pffi-struct-offset-get struct-test 'a))
(c-check-offset 2 (pffi-struct-offset-get struct-test 'b))
(c-check-offset 3 (pffi-struct-offset-get struct-test 'c))
(c-check-offset 4 (pffi-struct-offset-get struct-test 'd))
(c-check-offset 5 (pffi-struct-offset-get struct-test 'e))
(c-check-offset 6 (pffi-struct-offset-get struct-test 'f))
(c-check-offset 7 (pffi-struct-offset-get struct-test 'g))
(c-check-offset 8 (pffi-struct-offset-get struct-test 'h))
(c-check-offset 9 (pffi-struct-offset-get struct-test 'i))
(c-check-offset 10 (pffi-struct-offset-get struct-test 'j))
(c-check-offset 11 (pffi-struct-offset-get struct-test 'k))
(c-check-offset 12 (pffi-struct-offset-get struct-test 'l))
(c-check-offset 13 (pffi-struct-offset-get struct-test 'm))
(c-check-offset 14 (pffi-struct-offset-get struct-test 'n))
(debug struct-test)
(c-init-struct (pffi-struct-pointer struct-test))
(debug struct-test)

(debug (pffi-struct-get struct-test 'a))
(assert = (pffi-struct-get struct-test 'a) 1)
(debug (pffi-struct-get struct-test 'b))
(assert char=? (pffi-struct-get struct-test 'b) #\b)
(debug (pffi-struct-get struct-test 'c))
(assert = (pffi-struct-get struct-test 'c) 3.0)
(debug (pffi-struct-get struct-test 'd))
(assert char=? (pffi-struct-get struct-test 'd) #\d)
(debug (pffi-struct-get struct-test 'e))
(debug (pffi-pointer-null? (pffi-struct-get struct-test 'e)))
(assert equal? (pffi-pointer-null? (pffi-struct-get struct-test 'e)) #t)
(debug (pffi-struct-get struct-test 'f))
(assert = (pffi-struct-get struct-test 'f) 6.0)
(debug (pffi-struct-get struct-test 'g))
(debug (pffi-pointer->string (pffi-struct-get struct-test 'g)))
(assert equal? (string=? (pffi-pointer->string (pffi-struct-get struct-test 'g)) "FOOBAR")  #t)
(debug (pffi-struct-get struct-test 'h))
(assert = (pffi-struct-get struct-test 'h) 8)
(debug (pffi-struct-get struct-test 'i))
(debug (pffi-pointer-null? (pffi-struct-get struct-test 'i)))
(assert equal? (pffi-pointer-null? (pffi-struct-get struct-test 'i)) #t)
(debug (pffi-struct-get struct-test 'j))
(assert = (pffi-struct-get struct-test 'j) 10)
(debug (pffi-struct-get struct-test 'k))
(assert = (pffi-struct-get struct-test 'k) 11)
(debug (pffi-struct-get struct-test 'l))
(assert = (pffi-struct-get struct-test 'l) 12)
(debug (pffi-struct-get struct-test 'm))
(assert = (pffi-struct-get struct-test 'm) 13.0)
(debug (pffi-struct-get struct-test 'n))
(assert = (pffi-struct-get struct-test 'n) 14.0)

;; pffi-struct-set! 1

(print-header "pffi-struct-set! 1")

(pffi-define c-test-check c-testlib 'test_check 'int (list 'pointer))
(define struct-test1 (pffi-struct-make 'test
                                          '((int8 . a)
                                            (char . b)
                                            (double . c)
                                            (char . d)
                                            (pointer . e)
                                            (float . f)
                                            (pointer . g)
                                            (int8 . h)
                                            (pointer . i)
                                            (int . j)
                                            (int . k)
                                            (int . l)
                                            (double . m)
                                            (float . n))))
(pffi-struct-set! struct-test1 'a 1)
(pffi-struct-set! struct-test1 'b #\b)
(pffi-struct-set! struct-test1 'c 3.0)
(pffi-struct-set! struct-test1 'd #\d)
(pffi-struct-set! struct-test1 'e (pffi-pointer-null))
(pffi-struct-set! struct-test1 'f 6.0)
(pffi-struct-set! struct-test1 'g (pffi-string->pointer "foo"))
(pffi-struct-set! struct-test1 'h 8)
(pffi-struct-set! struct-test1 'i (pffi-pointer-null))
(pffi-struct-set! struct-test1 'j 10)
(pffi-struct-set! struct-test1 'k 11)
(pffi-struct-set! struct-test1 'l 12)
(pffi-struct-set! struct-test1 'm 13.0)
(pffi-struct-set! struct-test1 'n 14.0)
(c-test-check (pffi-struct-pointer struct-test1))

;; pffi-struct-make with pointer

(print-header "pffi-struct-make with pointer")

(pffi-define c-test-new c-testlib 'test_new 'pointer (list))
(define struct-test2-pointer (c-test-new))
(define struct-test2 (pffi-struct-make 'test
                                       '((int8 . a)
                                         (char . b)
                                         (double . c)
                                         (char . d)
                                         (pointer . e)
                                         (float . f)
                                         (pointer . g)
                                         (int8 . h)
                                         (pointer . i)
                                         (int . j)
                                         (int . k)
                                         (int . l)
                                         (double . m)
                                         (float . n))
                                       struct-test2-pointer))
(debug struct-test2)

(debug (pffi-pointer-get struct-test2-pointer 'int8 0))
(debug (pffi-struct-get struct-test2 'a))
(assert = (pffi-struct-get struct-test2 'a) 1)
(debug (pffi-pointer-get struct-test2-pointer 'char 1))
(debug (pffi-struct-get struct-test2 'b))
(assert char=? (pffi-struct-get struct-test2 'b) #\b)
(debug (pffi-struct-get struct-test2 'c))
(assert = (pffi-struct-get struct-test2 'c) 3)
(debug (pffi-struct-get struct-test2 'd))
(assert char=? (pffi-struct-get struct-test2 'd) #\d)
(debug (pffi-struct-get struct-test2 'e))
(debug (pffi-pointer-null? (pffi-struct-get struct-test2 'e)))
(assert equal? (pffi-pointer-null? (pffi-struct-get struct-test2 'e)) #t)
(debug (pffi-struct-get struct-test2 'f))
(assert = (pffi-struct-get struct-test2 'f) 6.0)
(debug (pffi-pointer->string (pffi-struct-get struct-test2 'g)))
(assert equal? (string=? (pffi-pointer->string (pffi-struct-get struct-test2 'g)) "FOOBAR") #t)
(debug (pffi-struct-get struct-test2 'h))
(assert = (pffi-struct-get struct-test2 'h) 8)
(debug (pffi-struct-get struct-test2 'i))
(debug (pffi-pointer-null? (pffi-struct-get struct-test2 'i)))
(assert (lambda (p t) (pffi-pointer-null? p)) (pffi-struct-get struct-test2 'i) #t)
(debug (pffi-struct-get struct-test2 'j))
(assert = (pffi-struct-get struct-test2 'j) 10)
(debug (pffi-struct-get struct-test2 'k))
(assert = (pffi-struct-get struct-test2 'k) 11)
(debug (pffi-struct-get struct-test2 'l))
(assert = (pffi-struct-get struct-test2 'l) 12)
(debug (pffi-struct-get struct-test2 'm))
(assert = (pffi-struct-get struct-test2 'm) 13.0)
(debug (pffi-struct-get struct-test2 'n))
(assert = (pffi-struct-get struct-test2 'n) 14.0)

;; pffi-struct-dereference

;(print-header "pffi-struct-dereference 1")
;(pffi-define c-color-check-by-value c-testlib 'color_check_by_value 'int (list 'struct))
#;(define struct-color (pffi-struct-make 'color '((int8 . r)
                                                (int8 . g)
                                                (int8 . b)
                                                (int8 . a))))
;(debug (pffi-struct-set! struct-color 'r 100))
;(debug (pffi-struct-set! struct-color 'g 101))
;(debug (pffi-struct-set! struct-color 'b 102))
;(debug (pffi-struct-set! struct-color 'a 103))
;(assert = (c-color-check-by-value (pffi-struct-dereference struct-color)) 0)

;(print-header "pffi-struct-dereference 2")

;(pffi-define c-test-check-by-value c-testlib 'test_check_by_value 'int (list 'struct))
#;(define struct-test3 (pffi-struct-make 'test
                                          '((int8 . a)
                                            (char . b)
                                            (double . c)
                                            (char . d)
                                            (pointer . e)
                                            (float . f)
                                            (pointer . g)
                                            (int8 . h)
                                            (pointer . i)
                                            (int . j)
                                            (int . k)
                                            (int . l)
                                            (double . m)
                                            (float . n))))
;(debug (pffi-struct-set! struct-test3 'a 1))
;(debug (pffi-struct-set! struct-test3 'b #\b))
;(debug (pffi-struct-set! struct-test3 'c 3.0))
;(debug (pffi-struct-set! struct-test3 'd #\d))
;(debug (pffi-struct-set! struct-test3 'e (pffi-pointer-null)))
;(debug (pffi-struct-set! struct-test3 'f 6.0))
;(debug (pffi-struct-set! struct-test3 'g (pffi-string->pointer "foo")))
;(debug (pffi-struct-set! struct-test3 'h 8))
;(debug (pffi-struct-set! struct-test3 'i (pffi-pointer-null)))
;(debug (pffi-struct-set! struct-test3 'j 10))
;(debug (pffi-struct-set! struct-test3 'k 11))
;(debug (pffi-struct-set! struct-test3 'l 12))
;(debug (pffi-struct-set! struct-test3 'm 13.0))
;(debug (pffi-struct-set! struct-test3 'n 14.0))
;(debug (pffi-struct-get struct-test3 'a))
;(debug (pffi-struct-get struct-test3 'b))
;(debug (pffi-struct-get struct-test3 'c))
;(debug (pffi-struct-get struct-test3 'd))
;(debug (pffi-struct-get struct-test3 'e))
;(debug (pffi-struct-get struct-test3 'f))
;(debug (pffi-struct-get struct-test3 'g))
;(debug (pffi-struct-get struct-test3 'h))
;(debug (pffi-struct-get struct-test3 'i))
;(debug (pffi-struct-get struct-test3 'j))
;(debug (pffi-struct-get struct-test3 'k))
;(debug (pffi-struct-get struct-test3 'l))
;(debug (pffi-struct-get struct-test3 'm))
;(debug (pffi-struct-get struct-test3 'n))
;(c-test-check-by-value (pffi-struct-dereference struct-test3))

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

(define unsorted (list (pffi-pointer-get array 'int (* (pffi-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 2))))
(debug unsorted)
(assert equal? unsorted (list 3 2 1))

(qsort array 3 (pffi-size-of 'int) compare)

(define sorted (list (pffi-pointer-get array 'int (* (pffi-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (pffi-size-of 'int) 2))))
(debug sorted)
(assert equal? sorted (list 1 2 3))

(exit 0)
