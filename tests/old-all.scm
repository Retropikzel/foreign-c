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

;(print-header 'pffi-init)

;(pffi-init)

;; pffi-type?

;(print-header 'pffi-type?)

;(debug (pffi-type? 'int8))
;(assert equal? (pffi-type? 'int8) #t)
;(debug (pffi-type? 'uint8))
;(assert equal? (pffi-type? 'uint8) #t)
;(debug (pffi-type? 'int16))
;(assert equal? (pffi-type? 'int16) #t)
;(debug (pffi-type? 'uint16))
;(assert equal? (pffi-type? 'uint16) #t)
;(debug (pffi-type? 'int32))
;(assert equal? (pffi-type? 'int32) #t)
;(debug (pffi-type? 'uint32))
;(assert equal? (pffi-type? 'uint32) #t)
;(debug (pffi-type? 'int64))
;(assert equal? (pffi-type? 'int64) #t)
;(debug (pffi-type? 'uint64))
;(assert equal? (pffi-type? 'uint64) #t)
;(debug (pffi-type? 'char))
;(assert equal? (pffi-type? 'char) #t)
;(debug (pffi-type? 'unsigned-char))
;(assert equal? (pffi-type? 'unsigned-char) #t)
;(debug (pffi-type? 'short))
;(assert equal? (pffi-type? 'short) #t)
;(debug (pffi-type? 'unsigned-short))
;(assert equal? (pffi-type? 'unsigned-short) #t)
;(debug (pffi-type? 'int))
;(assert equal? (pffi-type? 'int) #t)
;(debug (pffi-type? 'unsigned-int))
;(assert equal? (pffi-type? 'unsigned-int) #t)
;(debug (pffi-type? 'long))
;(assert equal? (pffi-type? 'long) #t)
;(debug (pffi-type? 'unsigned-long))
;(assert equal? (pffi-type? 'unsigned-long) #t)
;(debug (pffi-type? 'float))
;(assert equal? (pffi-type? 'float) #t)
;(debug (pffi-type? 'double))
;(assert equal? (pffi-type? 'double) #t)
;(debug (pffi-type? 'pointer))
;(assert equal? (pffi-type? 'pointer) #t)
;(debug (pffi-type? 'void))
;(assert equal? (pffi-type? 'void) #t)
;(debug (pffi-type? 'callback))
;(assert equal? (pffi-type? 'callback) #t)

;; c-size-of

(print-header 'c-size-of)

(define size-int8 (c-size-of 'int8))
(debug size-int8)
(assert equal? (number? size-int8) #t)
(assert = size-int8 1)

(define size-uint8 (c-size-of 'uint8))
(debug size-uint8)
(assert equal? (number? size-uint8) #t)
(assert = size-uint8 1)

(assert equal? (number? (c-size-of 'uint8)) #t)
(define size-int16 (c-size-of 'int16))
(debug size-int16)
(assert equal? (number? size-int16) #t)
(assert = size-int16 2)

(assert equal? (number? (c-size-of 'int16)) #t)
(define size-uint16 (c-size-of 'uint16))
(debug size-uint16)
(assert equal? (number? size-uint16) #t)
(assert = size-uint16 2)

(assert equal? (number? (c-size-of 'uint16)) #t)
(define size-int32 (c-size-of 'int32))
(debug size-int32)
(assert equal? (number? size-int32) #t)
(assert = size-int32 4)

(assert equal? (number? (c-size-of 'int32)) #t)
(define size-uint32 (c-size-of 'uint32))
(debug size-uint32)
(assert equal? (number? size-uint32) #t)
(assert = size-uint32 4)

(assert equal? (number? (c-size-of 'uint32)) #t)
(define size-int64 (c-size-of 'int64))
(debug size-int64)
(assert equal? (number? size-int64) #t)
(assert = size-int64 8)

(assert equal? (number? (c-size-of 'int64)) #t)
(define size-uint64 (c-size-of 'uint64))
(debug size-uint64)
(assert equal? (number? size-uint64) #t)
(assert = size-uint64 8)

(assert equal? (number? (c-size-of 'uint64)) #t)
(define size-char (c-size-of 'char))
(debug size-char)
(assert equal? (number? size-char) #t)
(assert = size-char 1)

(assert equal? (number? (c-size-of 'char)) #t)
(define size-unsigned-char (c-size-of 'unsigned-char))
(debug size-unsigned-char)
(assert equal? (number? size-unsigned-char) #t)
(assert = size-unsigned-char 1)

(assert equal? (number? (c-size-of 'unsigned-char)) #t)
(define size-short (c-size-of 'short))
(debug size-short)
(assert equal? (number? size-short) #t)
(assert = size-short 2)

(assert equal? (number? (c-size-of 'short)) #t)
(define size-unsigned-short (c-size-of 'unsigned-short))
(debug size-unsigned-short)
(assert equal? (number? size-unsigned-short) #t)
(assert = size-unsigned-short 2)

(assert equal? (number? (c-size-of 'unsigned-short)) #t)
(define size-int (c-size-of 'int))
(debug size-int)
(assert equal? (number? size-int) #t)
(assert = size-int 4)

(assert equal? (number? (c-size-of 'int)) #t)
(define size-unsigned-int (c-size-of 'unsigned-int))
(debug size-unsigned-int)
(assert equal? (number? size-unsigned-int) #t)
(assert = size-unsigned-int 4)

(cond-expand
  (i386
    (assert equal? (number? (c-size-of 'long)) #t)
    (define size-long (c-size-of 'long))
    (debug size-long)
    (assert equal? (number? size-long) #t)
    (assert = size-long 4))
  (else
    (assert equal? (number? (c-size-of 'long)) #t)
    (define size-long (c-size-of 'long))
    (debug size-long)
    (assert equal? (number? size-long) #t)
    (assert = size-long 8)))

(cond-expand
  (i386
    (assert equal? (number? (c-size-of 'unsigned-long)) #t)
    (define size-unsigned-long (c-size-of 'unsigned-long))
    (debug size-unsigned-long)
    (assert equal? (number? size-unsigned-long) #t)
    (assert = size-unsigned-long 4))
  (else
    (assert equal? (number? (c-size-of 'long)) #t)
    (define size-unsigned-long (c-size-of 'unsigned-long))
    (debug size-unsigned-long)
    (assert equal? (number? size-unsigned-long) #t)
    (assert = size-unsigned-long 8)))

(assert equal? (number? (c-size-of 'float)) #t)
(define size-float (c-size-of 'float))
(debug size-float)
(assert equal? (number? size-float) #t)
(assert = size-float 4)

(assert equal? (number? (c-size-of 'double)) #t)
(define size-double (c-size-of 'double))
(debug size-double)
(assert equal? (number? size-double) #t)
(assert = size-double 8)

(cond-expand
  (i386
    (define size-pointer (c-size-of 'pointer))
    (debug size-pointer)
    (assert equal? (number? size-pointer) #t)
    (assert = size-pointer 4))
  (else
    (define size-pointer (c-size-of 'pointer))
    (debug size-pointer)
    (assert equal? (number? size-pointer) #t)
    (assert = size-pointer 8)))

;; c-align-of
;
;(print-header 'c-align-of)
;
;(define align-int8 (c-align-of 'int8))
;(debug align-int8)
;(assert equal? (number? align-int8) #t)
;(assert = align-int8 1)
;
;(define align-uint8 (c-align-of 'uint8))
;(debug align-uint8)
;(assert equal? (number? align-uint8) #t)
;(assert = align-uint8 1)
;
;(assert equal? (number? (c-align-of 'uint8)) #t)
;(define align-int16 (c-align-of 'int16))
;(debug align-int16)
;(assert equal? (number? align-int16) #t)
;(assert = align-int16 2)
;
;(assert equal? (number? (c-align-of 'int16)) #t)
;(define align-uint16 (c-align-of 'uint16))
;(debug align-uint16)
;(assert equal? (number? align-uint16) #t)
;(assert = align-uint16 2)
;
;(assert equal? (number? (c-align-of 'uint16)) #t)
;(define align-int32 (c-align-of 'int32))
;(debug align-int32)
;(assert equal? (number? align-int32) #t)
;(assert = align-int32 4)
;
;(assert equal? (number? (c-align-of 'int32)) #t)
;(define align-uint32 (c-align-of 'uint32))
;(debug align-uint32)
;(assert equal? (number? align-uint32) #t)
;(assert = align-uint32 4)
;
;(assert equal? (number? (c-align-of 'uint32)) #t)
;(define align-int64 (c-align-of 'int64))
;(debug align-int64)
;(assert equal? (number? align-int64) #t)
;(assert = align-int64 8)
;
;(assert equal? (number? (c-align-of 'int64)) #t)
;(define align-uint64 (c-align-of 'uint64))
;(debug align-uint64)
;(assert equal? (number? align-uint64) #t)
;(assert = align-uint64 8)
;
;(assert equal? (number? (c-align-of 'uint64)) #t)
;(define align-char (c-align-of 'char))
;(debug align-char)
;(assert equal? (number? align-char) #t)
;(assert = align-char 1)
;
;(assert equal? (number? (c-align-of 'char)) #t)
;(define align-unsigned-char (c-align-of 'unsigned-char))
;(debug align-unsigned-char)
;(assert equal? (number? align-unsigned-char) #t)
;(assert = align-unsigned-char 1)
;
;(assert equal? (number? (c-align-of 'unsigned-char)) #t)
;(define align-short (c-align-of 'short))
;(debug align-short)
;(assert equal? (number? align-short) #t)
;(assert = align-short 2)
;
;(assert equal? (number? (c-align-of 'short)) #t)
;(define align-unsigned-short (c-align-of 'unsigned-short))
;(debug align-unsigned-short)
;(assert equal? (number? align-unsigned-short) #t)
;(assert = align-unsigned-short 2)
;
;(assert equal? (number? (c-align-of 'unsigned-short)) #t)
;(define align-int (c-align-of 'int))
;(debug align-int)
;(assert equal? (number? align-int) #t)
;(assert = align-int 4)
;
;(assert equal? (number? (c-align-of 'int)) #t)
;(define align-unsigned-int (c-align-of 'unsigned-int))
;(debug align-unsigned-int)
;(assert equal? (number? align-unsigned-int) #t)
;(assert = align-unsigned-int 4)
;
;(cond-expand
;  (i386
;    (assert equal? (number? (c-align-of 'long)) #t)
;    (define align-long (c-align-of 'long))
;    (debug align-long)
;    (assert equal? (number? align-long) #t)
;    (assert = align-long 4))
;  (else
;    (assert equal? (number? (c-align-of 'long)) #t)
;    (define align-long (c-align-of 'long))
;    (debug align-long)
;    (assert equal? (number? align-long) #t)
;    (assert = align-long 8)))
;
;(cond-expand
;  (i386
;    (assert equal? (number? (c-align-of 'unsigned-long)) #t)
;    (define align-unsigned-long (c-align-of 'unsigned-long))
;    (debug align-unsigned-long)
;    (assert equal? (number? align-unsigned-long) #t)
;    (assert = align-unsigned-long 4))
;  (else
;    (assert equal? (number? (c-align-of 'long)) #t)
;    (define align-unsigned-long (c-align-of 'unsigned-long))
;    (debug align-unsigned-long)
;    (assert equal? (number? align-unsigned-long) #t)
;    (assert = align-unsigned-long 8)))
;
;(assert equal? (number? (c-align-of 'float)) #t)
;(define align-float (c-align-of 'float))
;(debug align-float)
;(assert equal? (number? align-float) #t)
;(assert = align-float 4)
;
;(assert equal? (number? (c-align-of 'double)) #t)
;(define align-double (c-align-of 'double))
;(debug align-double)
;(assert equal? (number? align-double) #t)
;(assert = align-double 8)
;
;(cond-expand
;  (i386
;    (define align-pointer (c-align-of 'pointer))
;    (debug align-pointer)
;    (assert equal? (number? align-pointer) #t)
;    (assert = align-pointer 4))
;  (else
;    (define align-pointer (c-align-of 'pointer))
;    (debug align-pointer)
;    (assert equal? (number? align-pointer) #t)
;    (assert = align-pointer 8)))

;; define-c-library

(print-header 'pffi-define-library)

(cond-expand
  (windows (define-c-library libc-stdlib
                                '("stdlib.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (define-c-library libc-stdlib
                             '("stdlib.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(debug libc-stdlib)

(cond-expand
  (windows (define-c-library libc-stdio
                                '("stdio.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (define-c-library libc-stdio
                             '("stdio.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(debug libc-stdio)

(define-c-library c-testlib
                     '("libtest.h")
                     "test"
                     '((additional-paths ("." "./tests"))))

(debug c-testlib)

;; define-c-procedure

(print-header 'define-c-procedure)

(define-c-procedure c-abs libc-stdlib 'abs 'int '(int))
(debug c-abs)
(define absoluted (c-abs -2))
(debug absoluted)
(assert = absoluted 2)

(define-c-procedure c-puts libc-stdlib 'puts 'int '(pointer))
(debug c-puts)
(define chars-written (c-puts (string->c-utf8 "puts: Hello from testing, I am C function puts")))
(debug chars-written)
(assert = chars-written 47)

(define-c-procedure c-atoi libc-stdlib 'atoi 'int '(pointer))
(assert = (c-atoi (string->c-utf8 "100")) 100)

(define-c-procedure c-fopen libc-stdio 'fopen 'pointer '(pointer pointer))
(define output-file (c-fopen (string->c-utf8 "testfile.test")
                              (string->c-utf8 "w")))
(debug output-file)
(define-c-procedure c-fprintf libc-stdio 'fprintf 'int '(pointer pointer))
(define characters-written
  (c-fprintf output-file (string->c-utf8 "Hello world")))
(debug characters-written)
(assert equal? (= characters-written 11) #t)
(define-c-procedure c-fclose libc-stdio 'fclose 'int '(pointer))
(define closed-status (c-fclose output-file))
(debug closed-status)
(assert equal? (= closed-status 0) #t)
(assert equal? (file-exists? "testfile.test") #t)
(assert equal? (string=? (with-input-from-file "testfile.test"
                                               (lambda () (read-line)))
                         "Hello world") #t)

(define-c-procedure c-takes-no-args c-testlib 'takes_no_args 'void '())
(debug c-takes-no-args)
(c-takes-no-args)

(define-c-procedure c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int '())
(debug c-takes-no-args)
(define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
(assert equal? (= takes-no-args-returns-int-result 0) #t)

;; c-bytevector?

(print-header 'c-bytevector?)

(define is-pointer (make-c-bytevector 100))
(debug is-pointer)
(assert equal? (c-bytevector? is-pointer) #t)
;(assert equal? (c-bytevector? 100) #f)
(assert equal? (c-bytevector? 'bar) #f)

;; make-c-null

(print-header 'make-c-null)

(define null-pointer (make-c-null))
(debug null-pointer)
(assert equal? (c-null? null-pointer) #t)

;; c-null?

(print-header 'c-null?)

(define is-null-pointer (make-c-null))
(debug is-null-pointer)
(assert equal? (c-null? is-null-pointer) #t)
(assert equal? (c-null? 100) #f)
(assert equal? (c-null? 'bar) #f)

;; make-c-bytevector

(print-header 'make-c-bytevector )

(define test-pointer (make-c-bytevector 100))
(debug test-pointer)
(assert equal? (c-bytevector? test-pointer) #t)
;(assert equal? (c-bytevector? 0) #f)
;(assert equal? (c-bytevector? #t) #f)
;(assert equal? (c-bytevector? "Hello world") #f)
(assert equal? (c-null? test-pointer) #f)

(print-header "c-bytevector-u8-set! c-bytevector-u8-ref")

(define u8-pointer (make-c-bytevector (c-size-of 'uint8)))
(c-bytevector-u8-set! u8-pointer 0 42)
(debug u8-pointer)
(debug (c-bytevector-u8-ref u8-pointer 0))
(assert equal? (= (c-bytevector-u8-ref u8-pointer 0) 42) #t)

;; call-with-address-of-c-bytevector

(print-header 'call-with-address-of-c-bytevector)

(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))

(define input-pointer (make-c-bytevector (c-size-of 'int)))
(c-bytevector-s32-native-set! input-pointer 0 100)
(debug (c-bytevector-s32-native-ref input-pointer 0))
(call-with-address-of-c-bytevector
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(debug input-pointer)
(debug (c-bytevector-s32-native-ref input-pointer 0))
(assert equal? (= (c-bytevector-s32-native-ref input-pointer 0) 42) #t)

;; c-free

(print-header 'c-free)

(define pointer-to-be-freed (make-c-bytevector 100))
(debug pointer-to-be-freed)
(c-free pointer-to-be-freed)
(debug pointer-to-be-freed)

; pffi-define-struct

;(print-header "pffi-define-struct")
;
;(pffi-define-struct test-struct1 'teststruct1 '((int . r) (int . g) (int . b)))
;(define struct1 (test-struct1))
;(debug struct1)
;(debug (c-size-of struct1))
;(assert = (c-size-of struct1) 12)
;
;(pffi-define-struct test-struct2 'test2 '((int8 . r) (int8 . g) (int . b)))
;(define struct2 (test-struct2))
;(debug struct2)
;(debug (c-size-of struct2))
;(assert = (c-size-of struct2) 8)
;
;(pffi-define-struct test-struct3 'test3 '((int8 . r) (int8 . g) (int . b)))
;(define struct3 (test-struct3))
;(debug struct3)
;(debug (c-size-of struct3))
;(assert = (c-size-of struct3) 8)
;
;(pffi-define-struct test-struct4 'test4 '((int8 . r) (pointer . a) (int8 . g) (int . b)))
;(define struct4 (test-struct4))
;(debug struct4)
;(debug (c-size-of struct4))
;(assert = (c-size-of struct4) 24)
;
;(pffi-define-struct test-struct5 'test5 '((int8 . r) (char . b) (pointer . a) (int8 . g) (int . b)))
;(define struct5 (test-struct5))
;(debug struct5)
;(debug (c-size-of struct5))
;(assert = (c-size-of struct5) 24)

;(pffi-define-struct test-struct6 'test6 '((int8 . a)
;                                          (char . b)
;                                          (double . c)
;                                          (char . d)
;                                          (pointer . e)
;                                          (float . f)
;                                          (pointer . g)
;                                          (int8 . h)
;                                          (pointer . i)
;                                          (int . j)
;                                          (int . k)
;                                          (int . l)
;                                          (double . m)
;                                          (float . n)))
;(define struct6 (test-struct6))
;(debug struct6)
;(debug (c-size-of struct6))
;(assert = (c-size-of struct6) 96)

;; bytevector->c-bytevector c-bytevector->bytevector

(print-header "bytevector->c-bytevector c-bytevector->bytevector")

(define bt1 (bytevector 1 2 3 4 5 6 7 8))
(debug bt1)
(define btp1 (bytevector->c-bytevector bt1))
(debug btp1)
(assert equal? (c-bytevector? btp1) #t)
(define bt2 (c-bytevector->bytevector btp1 (bytevector-length bt1)))
(debug bt2)
(assert equal? (bytevector? bt2) #t)
(debug (list bt1 bt2))
(assert equal? bt1 bt2)

;; pffi-struct-get

;(print-header 'pffi-struct-get)
;
;(define-c-procedure c-init-struct c-testlib 'init_struct 'pointer '(pointer))
;(define-c-procedure c-check-offset c-testlib 'check_offset 'void '(int int))
;(pffi-define-struct struct-test-get1 'test_get1
;                                          '((int8 . a)
;                                            (char . b)
;                                            (double . c)
;                                            (char . d)
;                                            (pointer . e)
;                                            (float . f)
;                                            (pointer . g)
;                                            (int8 . h)
;                                            (pointer . i)
;                                            (int . j)
;                                            (int . k)
;                                            (int . l)
;                                            (double . m)
;                                            (float . n)))
;(define struct-test (struct-test-get1))
;(c-check-offset 1 (pffi-struct-offset-get struct-test 'a))
;(c-check-offset 2 (pffi-struct-offset-get struct-test 'b))
;(c-check-offset 3 (pffi-struct-offset-get struct-test 'c))
;(c-check-offset 4 (pffi-struct-offset-get struct-test 'd))
;(c-check-offset 5 (pffi-struct-offset-get struct-test 'e))
;(c-check-offset 6 (pffi-struct-offset-get struct-test 'f))
;(c-check-offset 7 (pffi-struct-offset-get struct-test 'g))
;(c-check-offset 8 (pffi-struct-offset-get struct-test 'h))
;(c-check-offset 9 (pffi-struct-offset-get struct-test 'i))
;(c-check-offset 10 (pffi-struct-offset-get struct-test 'j))
;(c-check-offset 11 (pffi-struct-offset-get struct-test 'k))
;(c-check-offset 12 (pffi-struct-offset-get struct-test 'l))
;(c-check-offset 13 (pffi-struct-offset-get struct-test 'm))
;(c-check-offset 14 (pffi-struct-offset-get struct-test 'n))
;(debug struct-test)
;(c-init-struct (pffi-struct-pointer struct-test))
;(debug struct-test)
;
;(debug (pffi-struct-get struct-test 'a))
;(assert = (pffi-struct-get struct-test 'a) 1)
;(debug (pffi-struct-get struct-test 'b))
;(assert char=? (pffi-struct-get struct-test 'b) #\b)
;(debug (pffi-struct-get struct-test 'c))
;(assert = (pffi-struct-get struct-test 'c) 3.0)
;(debug (pffi-struct-get struct-test 'd))
;(assert char=? (pffi-struct-get struct-test 'd) #\d)
;(debug (pffi-struct-get struct-test 'e))
;(debug (c-null? (pffi-struct-get struct-test 'e)))
;(assert equal? (c-null? (pffi-struct-get struct-test 'e)) #t)
;(debug (pffi-struct-get struct-test 'f))
;(assert = (pffi-struct-get struct-test 'f) 6.0)
;(debug (pffi-struct-get struct-test 'g))
;(debug (c-utf8->string (pffi-struct-get struct-test 'g)))
;(assert equal? (string=? (c-utf8->string (pffi-struct-get struct-test 'g)) "FOOBAR")  #t)
;(debug (pffi-struct-get struct-test 'h))
;(assert = (pffi-struct-get struct-test 'h) 8)
;(debug (pffi-struct-get struct-test 'i))
;(debug (c-null? (pffi-struct-get struct-test 'i)))
;(assert equal? (c-null? (pffi-struct-get struct-test 'i)) #t)
;(debug (pffi-struct-get struct-test 'j))
;(assert = (pffi-struct-get struct-test 'j) 10)
;(debug (pffi-struct-get struct-test 'k))
;(assert = (pffi-struct-get struct-test 'k) 11)
;(debug (pffi-struct-get struct-test 'l))
;(assert = (pffi-struct-get struct-test 'l) 12)
;(debug (pffi-struct-get struct-test 'm))
;(assert = (pffi-struct-get struct-test 'm) 13.0)
;(debug (pffi-struct-get struct-test 'n))
;(assert = (pffi-struct-get struct-test 'n) 14.0)
;
;;; pffi-struct-set! 1
;
;(print-header "pffi-struct-set! 1")
;
;(define-c-procedure c-test-check c-testlib 'test_check 'int '(pointer))
;(pffi-define-struct struct-test-set1 'test_set1
;                                          '((int8 . a)
;                                            (char . b)
;                                            (double . c)
;                                            (char . d)
;                                            (pointer . e)
;                                            (float . f)
;                                            (pointer . g)
;                                            (int8 . h)
;                                            (pointer . i)
;                                            (int . j)
;                                            (int . k)
;                                            (int . l)
;                                            (double . m)
;                                            (float . n)))
;(define struct-test1 (struct-test-set1))
;(pffi-struct-set! struct-test1 'a 1)
;(pffi-struct-set! struct-test1 'b #\b)
;(pffi-struct-set! struct-test1 'c 3.0)
;(pffi-struct-set! struct-test1 'd #\d)
;(pffi-struct-set! struct-test1 'e (make-c-null))
;(pffi-struct-set! struct-test1 'f 6.0)
;(pffi-struct-set! struct-test1 'g (string->c-utf8 "foo"))
;(pffi-struct-set! struct-test1 'h 8)
;(pffi-struct-set! struct-test1 'i (make-c-null))
;(pffi-struct-set! struct-test1 'j 10)
;(pffi-struct-set! struct-test1 'k 11)
;(pffi-struct-set! struct-test1 'l 12)
;(pffi-struct-set! struct-test1 'm 13.0)
;(pffi-struct-set! struct-test1 'n 14.0)
;(c-test-check (pffi-struct-pointer struct-test1))

;; pffi-struct constructor with pointer

;(print-header "pffi-struct constructor with pointer")

;(define-c-procedure c-test-new c-testlib 'test_new 'pointer '())
;(define struct-test2-pointer (c-test-new))
#;(define struct-test2 (pffi-struct-make 'test
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
;(debug struct-test2)

;(debug (pffi-pointer-get struct-test2-pointer 'int8 0))
;(debug (pffi-struct-get struct-test2 'a))
;(assert = (pffi-struct-get struct-test2 'a) 1)
;(debug (pffi-pointer-get struct-test2-pointer 'char 1))
;(debug (pffi-struct-get struct-test2 'b))
;(assert char=? (pffi-struct-get struct-test2 'b) #\b)
;(debug (pffi-struct-get struct-test2 'c))
;(assert = (pffi-struct-get struct-test2 'c) 3)
;(debug (pffi-struct-get struct-test2 'd))
;(assert char=? (pffi-struct-get struct-test2 'd) #\d)
;(debug (pffi-struct-get struct-test2 'e))
;(debug (c-null? (pffi-struct-get struct-test2 'e)))
;(assert equal? (c-null? (pffi-struct-get struct-test2 'e)) #t)
;(debug (pffi-struct-get struct-test2 'f))
;(assert = (pffi-struct-get struct-test2 'f) 6.0)
;(debug (c-utf8->string (pffi-struct-get struct-test2 'g)))
;(assert equal? (string=? (c-bytevector->utf8 (pffi-struct-get struct-test2 'g)) "FOOBAR") #t)
;(debug (pffi-struct-get struct-test2 'h))
;(assert = (pffi-struct-get struct-test2 'h) 8)
;(debug (pffi-struct-get struct-test2 'i))
;(debug (c-null? (pffi-struct-get struct-test2 'i)))
;(assert (lambda (p t) (c-null? p)) (pffi-struct-get struct-test2 'i) #t)
;(debug (pffi-struct-get struct-test2 'j))
;(assert = (pffi-struct-get struct-test2 'j) 10)
;(debug (pffi-struct-get struct-test2 'k))
;(assert = (pffi-struct-get struct-test2 'k) 11)
;(debug (pffi-struct-get struct-test2 'l))
;(assert = (pffi-struct-get struct-test2 'l) 12)
;(debug (pffi-struct-get struct-test2 'm))
;(assert = (pffi-struct-get struct-test2 'm) 13.0)
;(debug (pffi-struct-get struct-test2 'n))
;(assert = (pffi-struct-get struct-test2 'n) 14.0)

; Array utilities

;(print-header "Array utilities")
;
;(define test-list1 (list 1 2 3))
;(debug test-list1)
;(debug (pffi-list->array 'int test-list1))
;(assert equal? (pffi-array->list (pffi-list->array 'int test-list1)) test-list1)
;
;(define test-array1 (make-c-bytevector (* (c-size-of 'int) 3)))
;;(pffi-pointer-set! test-array1 'int (* (c-size-of 'int) 0) 4)
;(c-bytevector-s32-set! test-array1 0 4 (native-endianness))
;;(pffi-pointer-set! test-array1 'int (* (c-size-of 'int) 1) 5)
;(c-bytevector-s32-set! test-array1 1 5 (native-endianness))
;;(pffi-pointer-set! test-array1 'int (* (c-size-of 'int) 2) 6)
;(c-bytevector-s32-set! test-array1 2 6 (native-endianness))
;(debug test-array1)
;(define check-list1 (list 4 5 6))
;(debug (pffi-array->list (pffi-pointer->array test-array1 'int 3)))
;(assert equal? (pffi-array->list (pffi-pointer->array test-array1 'int 3)) check-list1)
;
;(define test-array2 (pffi-array-allocate 'int 5))
;(debug (pffi-array->list test-array2))
;(assert equal? (pffi-array->list test-array2) (list 0 0 0 0 0))
;(pffi-array-set! test-array2 2 1)
;(debug (pffi-array->list test-array2))
;(assert equal? (pffi-array->list test-array2) (list 0 0 1 0 0))
;(assert = (pffi-array-get test-array2 1) 0)
;(assert = (pffi-array-get test-array2 2) 1)
;(assert = (pffi-array-get test-array2 3) 0)

;; pffi-struct-dereference 1

;(print-header "pffi-struct-dereference 1")
;(define-c-procedure c-color-check-by-value c-testlib 'color_check_by_value 'int '((struct . color)))
#;(pffi-define-struct make-struct-color 'color '((int8 . r)
                                               (int8 . g)
                                               (int8 . b)
                                               (int8 . a)))
;(define struct-color (make-struct-color))
;(debug (pffi-struct-set! struct-color 'r 100))
;(debug (pffi-struct-set! struct-color 'g 101))
;(debug (pffi-struct-set! struct-color 'b 102))
;(debug (pffi-struct-set! struct-color 'a 103))
;(assert = (c-color-check-by-value (pffi-struct-dereference struct-color)) 0)

;(print-header "pffi-struct-dereference 2")

;(define-c-procedure c-test-check-by-value c-testlib 'test_check_by_value 'int '((struct . test)))
#;(pffi-define-struct make-struct-test-dereference2
                    'test
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
                      (float . n)))
;(define struct-test3 (make-struct-test-dereference2))
;(debug (pffi-struct-set! struct-test3 'a 1))
;(debug (pffi-struct-set! struct-test3 'b #\b))
;(debug (pffi-struct-set! struct-test3 'c 3.0))
;(debug (pffi-struct-set! struct-test3 'd #\d))
;(debug (pffi-struct-set! struct-test3 'e (make-c-null)))
;(debug (pffi-struct-set! struct-test3 'f 6.0))
;(debug (pffi-struct-set! struct-test3 'g (string->c-utf8 "foo")))
;(debug (pffi-struct-set! struct-test3 'h 8))
;(debug (pffi-struct-set! struct-test3 'i (make-c-null)))
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

;(print-header 'pffi-define-callback)

;(define array (make-c-bytevector (* (c-size-of 'int) 3)))
;(pffi-pointer-set! array 'int (* (c-size-of 'int) 0) 3)
;(pffi-pointer-set! array 'int (* (c-size-of 'int) 1) 2)
;(pffi-pointer-set! array 'int (* (c-size-of 'int) 2) 1)

;(define-c-procedure qsort libc-stdlib 'qsort 'void '(pointer int int callback))

#;(pffi-define-callback compare
                      'int
                      '(pointer pointer)
                      (lambda (pointer-a pointer-b)
                        (let ((a (pffi-pointer-get pointer-a 'int 0))
                              (b (pffi-pointer-get pointer-b 'int 0)))
                          (cond ((> a b) 1)
                                ((= a b) 0)
                                ((< a b) -1)))))
;(write compare)
;(newline)

#;(define unsorted (list (pffi-pointer-get array 'int (* (c-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (c-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (c-size-of 'int) 2))))
;(debug unsorted)
;(assert equal? unsorted (list 3 2 1))

;(qsort array 3 (c-size-of 'int) compare)

#;(define sorted (list (pffi-pointer-get array 'int (* (c-size-of 'int) 0))
             (pffi-pointer-get array 'int (* (c-size-of 'int) 1))
             (pffi-pointer-get array 'int (* (c-size-of 'int) 2))))
;(debug sorted)
;(assert equal? sorted (list 1 2 3))

(exit 0)
