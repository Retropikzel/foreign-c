(import (scheme base)
        (scheme write)
        (scheme read)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (srfi 64)
        (foreign c))

(test-begin "foreign-c")

(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

(test-assert libc)

;; c-type-size

(test-begin "c-type-size")

(test-eq (c-type-size 'int8) 1)
(test-eq (c-type-size 'uint8) 1)
(test-eq (c-type-size 'int16) 2)
(test-eq (c-type-size 'uint16) 2)
(test-eq (c-type-size 'int32) 4)
(test-eq (c-type-size 'uint32) 4)
(test-eq (c-type-size 'int64) 8)
(test-eq (c-type-size 'uint64) 8)
(test-eq (c-type-size 'char) 1)
(test-eq (c-type-size 'unsigned-char) 1)
(test-eq (c-type-size 'short) 2)
(test-eq (c-type-size 'unsigned-short) 2)
(test-eq (c-type-size 'int) 4)
(test-eq (c-type-size 'unsigned-int) 4)

(cond-expand
  (i386 (test-eq (c-type-size 'long) 4))
  (else (test-eq (c-type-size 'long) 8)))

(cond-expand
  (i386 (test-eq (c-type-size 'unsigned-long) 4))
  (else (test-eq (c-type-size 'unsigned-long) 8)))

(test-eq (c-type-size 'float) 4)
(test-eq (c-type-size 'double) 8)

(cond-expand
  (i386 (test-eq (c-type-size 'pointer) 4))
  (else (test-eq (c-type-size 'pointer) 8)))

(test-end "c-type-size")

(test-begin "define-c-library")

(define-c-library c-testlib
                     '("libtest.h")
                     "test"
                     '((additional-paths ("." "./tests"))))

(define-c-procedure c-abs libc 'abs 'int '(int))
(test-eq (c-abs -2) 2)

(define-c-procedure c-takes-no-args c-testlib 'takes_no_args 'void '())
(c-takes-no-args)

(define-c-procedure c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int '())
(define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
(test-eq takes-no-args-returns-int-result 0)

(test-end "define-c-library")

(test-begin "make-c-bytevector and c-bytevector?")
(define bytes (make-c-bytevector 100))
(test-assert (c-bytevector? bytes))

(define is-pointer (make-c-bytevector 100))
(test-assert (c-bytevector? is-pointer))
(test-assert (c-bytevector? 100))
(test-assert (c-bytevector? #f))
(test-assert (not (c-bytevector? "Hello")))
(test-assert (not (c-bytevector? 'bar)))

(test-end "make-c-bytevector and c-bytevector?")

(test-begin "c-bytevector-u8-set! and c-bytevector-u8-ref")

(define u8-pointer (make-c-bytevector (c-type-size 'uint8)))
(test-assert (c-bytevector? u8-pointer))
(c-bytevector-u8-set! u8-pointer 0 42)
(test-eq (c-bytevector-u8-ref u8-pointer 0) 42)

(test-end "c-bytevector-u8-set! and c-bytevector-u8-ref")


(test-begin "c-bytevector-pointer-set! and c-bytevector-pointer-ref")

(define p-pointer (make-c-bytevector (c-type-size 'pointer)))
(test-assert (c-bytevector? p-pointer))
(c-bytevector-pointer-set! p-pointer 0 u8-pointer)
(test-eq (c-bytevector-u8-ref (c-bytevector-pointer-ref p-pointer 0) 0) 42)

(test-end "c-bytevector-pointer-set! and c-bytevector-pointer-ref")

(test-begin "string->c-utf8 c-utf8->string")
(for-each
  (lambda (str)
    (let ((utf-eight (string->c-utf8 str)))
      (let ((str1 (c-utf8->string utf-eight)))
        (test-assert (string=? str1 str)))))
  (list "100" "Hello world" "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"))
(test-end "string->c-utf8 c-utf8->string")

(test-begin "define-c-procedure")

(define-c-procedure c-atoi libc 'atoi 'int '(pointer))
(test-eq (c-atoi (string->c-utf8 "100")) 100)

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(define chars-written (c-puts (string->c-utf8 "puts: Hello from testing, I am C function puts")))
(test-eq chars-written 47)

(define-c-procedure c-strcat libc 'strcat 'pointer '(pointer pointer))
(define c-string1 (string->c-utf8 "test123"))
(test-assert (string=? (c-utf8->string (c-strcat (string->c-utf8 "con2")
                                                 (string->c-utf8 "cat2")))
                       "con2cat2"))

(when (file-exists? "testfile.test") (delete-file "testfile.test"))
(define-c-procedure c-fopen libc 'fopen 'pointer '(pointer pointer))
(define output-file (c-fopen (string->c-utf8 "testfile.test")
                              (string->c-utf8 "w")))
(define-c-procedure c-fprintf libc 'fprintf 'int '(pointer pointer int))
(define characters-written (c-fprintf output-file (string->c-utf8 "Hello world %i") 1))
(test-eq characters-written 13)
(define-c-procedure c-fclose libc 'fclose 'int '(pointer))
(define closed-status (c-fclose output-file))
(test-eq closed-status 0)
(test-assert (file-exists? "testfile.test"))
(define file-content (with-input-from-file "testfile.test"
                                           (lambda () (read-line))))
(test-assert (string=? file-content "Hello world 1"))

(test-end "define-c-procedure")

(test-end "foreign-c")
