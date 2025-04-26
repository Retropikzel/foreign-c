(import (scheme base)
        (scheme write)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (foreign c))

;; util
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

;; c-bytevector-u8-ref

(print-header "c-bytevector-u8-ref")

(define u8-pointer (make-c-bytevector (c-size-of 'uint8)))
(c-bytevector-u8-set! u8-pointer 0 42)
(debug u8-pointer)
(debug (c-bytevector-u8-ref u8-pointer 0))
(assert equal? (= (c-bytevector-u8-ref u8-pointer 0) 42) #t)

;; define-c-callback

(print-header 'define-c-callback)

(define array (make-c-bytevector (* (c-size-of 'int) 3)))
(c-bytevector-s32-native-set! array (* (c-size-of 'int) 0) 3)
(c-bytevector-s32-native-set! array (* (c-size-of 'int) 1) 2)
(c-bytevector-s32-native-set! array (* (c-size-of 'int) 2) 1)

(define-c-procedure qsort libc-stdlib 'qsort 'void '(pointer int int callback))

(define-c-callback compare
                   'int
                   '(pointer pointer)
                   (lambda (pointer-a pointer-b)
                     (let ((a (c-bytevector-s32-native-ref pointer-a 0))
                           (b (c-bytevector-s32-native-ref pointer-b 0)))
                       (cond ((> a b) 1)
                             ((= a b) 0)
                             ((< a b) -1)))))
(write compare)
(newline)

(define unsorted (list (c-bytevector-s32-native-ref array (* (c-size-of 'int) 0))
                       (c-bytevector-s32-native-ref array (* (c-size-of 'int) 1))
                       (c-bytevector-s32-native-ref array (* (c-size-of 'int) 2))))
(debug unsorted)
(assert equal? unsorted (list 3 2 1))

(qsort array 3 (c-size-of 'int) compare)

(define sorted (list (c-bytevector-s32-native-ref array (* (c-size-of 'int) 0))
                       (c-bytevector-s32-native-ref array (* (c-size-of 'int) 1))
                       (c-bytevector-s32-native-ref array (* (c-size-of 'int) 2))))
(debug sorted)
(assert equal? sorted (list 1 2 3))

(exit 0)
