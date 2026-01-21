;; Types

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-type-size")

(test-equal "c-type-size i8" (c-type-size 'i8) 1)
(test-equal "c-type-size u8" (c-type-size 'u8) 1)
(test-equal "c-type-size i16" (c-type-size 'i16) 2)
(test-equal "c-type-size u16" (c-type-size 'u16) 2)
(test-equal "c-type-size i32" (c-type-size 'i32) 4)
(test-equal "c-type-size u32" (c-type-size 'u32) 4)
(test-equal "c-type-size i64" (c-type-size 'i64) 8)
(test-equal "c-type-size u64" (c-type-size 'u64) 8)
(test-equal "c-type-size char" (c-type-size 'char) 1)
(test-equal "c-type-size uchar" (c-type-size 'uchar) 1)
(test-equal "c-type-size short" (c-type-size 'short) 2)
(test-equal "c-type-size ushort" (c-type-size 'ushort) 2)
(test-equal "c-type-size int" (c-type-size 'int) 4)
(test-equal "c-type-size uint" (c-type-size 'uint) 4)

#;(cond-expand
  (i386
    (test-equal (c-type-size 'long) 4))
  (else
    (test-equal (c-type-size 'long) 8)))

#;(cond-expand
  (i386
    (test-equal (c-type-size 'unsigned-long) 4))
  (else
    (test-equal (c-type-size 'unsigned-long) 8)))

(test-equal "c-type-size float" (c-type-size 'float) 4)
(test-equal "c-type-size double" (c-type-size 'double) 8)

#;(cond-expand
  (i386
    (test-equal (c-type-size 'pointer) 4))
  (else
    (test-equal (c-type-size 'pointer) 8)))

(test-end "c-type-size")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

#|

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-type-aling")

(test-equal "c-type-align i8" (c-type-align 'i8) 1)
(test-equal "c-type-align u8" (c-type-align 'u8) 1)
(test-equal "c-type-align i16" (c-type-align 'i16) 2)
(test-equal "c-type-align u16" (c-type-align 'u16) 2)
(test-equal "c-type-align i32" (c-type-align 'i32) 4)
(test-equal "c-type-align u32" (c-type-align 'u32) 4)
(test-equal "c-type-align i64" (c-type-align 'i64) 8)
(test-equal "c-type-align u64" (c-type-align 'u64) 8)
(test-equal "c-type-align char" (c-type-align 'char) 1)
(test-equal "c-type-align uchar" (c-type-align 'uchar) 1)
(test-equal "c-type-align short" (c-type-align 'short) 2)
(test-equal "c-type-align ushort" (c-type-align 'ushort) 2)
(test-equal "c-type-align int" (c-type-align 'int) 4)
(test-equal "c-type-align uint" (c-type-align 'uint) 4)

#;(cond-expand
  (i386
    (test-equal (c-type-align 'long) 4))
  (else
    (test-equal (c-type-align 'long) 8)))

#;(cond-expand
  (i386
    (test-equal (c-type-align 'ulong) 4))
  (else
    (test-equal (c-type-align 'ulong) 8)))

(test-equal "c-type-align float" (c-type-align 'float) 4)
(test-equal "c-type-align double" (c-type-align 'double) 8)

#;(cond-expand
  (i386
    (test-equal (c-type-align 'pointer) 4))
  (else
    (test-equal (c-type-align 'pointer) 8)))

(test-end "c-type-aling")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Libraries and procedures

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "define-c-library")
(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h" "stdio.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

(test-assert "test-assert libc" (if libc #t #f))

(define-c-procedure c-abs libc 'abs 'int '(int))
(test-equal "c-abs" (c-abs -2) 2)

(define-c-library c-testlib
                      '("libtest.h")
                      "test"
                      '((additional-paths ("." "./tests"))))

(define-c-procedure c-takes-no-args c-testlib 'takes_no_args 'void '())
(c-takes-no-args)


(define-c-procedure c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int '())
(define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
(test-equal takes-no-args-returns-int-result 0)
(test-end "define-c-library")

(test-begin "define-c-procedure")
(define-c-procedure c-atoi libc 'atoi 'int '(pointer))
(test-equal "1" (c-atoi (string->c-utf8 "100")) 100)

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(define chars-written (c-puts (string->c-utf8 "puts: Hello from testing, I am C function puts")))
(test-equal "2" chars-written 47)

(define-c-procedure c-strcat libc 'strcat 'pointer '(pointer pointer))
(define c-string1 (string->c-utf8 "test123"))
(test-assert "3" (string=? (c-utf8->string (c-strcat (string->c-utf8 "con2")
                                                     (string->c-utf8 "cat2")))
                           "con2cat2"))

(when (file-exists? "testfile.test") (delete-file "testfile.test"))
(define-c-procedure c-fopen libc 'fopen 'pointer '(pointer pointer))
(define output-file (c-fopen (string->c-utf8 "testfile.test")
                             (string->c-utf8 "w")))
(define-c-procedure c-fprintf libc 'fprintf 'int '(pointer pointer int))
(define characters-written (c-fprintf output-file (string->c-utf8 "Hello world %i") 1))
(test-equal "4" characters-written 13)
(define-c-procedure c-fclose libc 'fclose 'int '(pointer))
(define closed-status (c-fclose output-file))
(test-equal "5" closed-status 0)
(test-assert "6" (file-exists? "testfile.test"))

;; Own readline so tests work on R6RS
(define (rl result)
  (let ((c (read-char)))
    (if (eof-object? c)
      result
      (rl (string-append result (string c))))))
(define file-content (with-input-from-file "testfile.test"
                                           (lambda () (rl ""))))
(test-assert "7" (string=? file-content "Hello world 1"))
(test-end "define-c-procedure")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; c-bytevectors

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "make-c-bytevector")
(define bytes (make-c-bytevector 100))
(test-assert "make-c-bytevector-1" (c-bytevector? bytes))
(test-assert "make-c-bytevector-2" (not (c-null? bytes)))
(test-end "make-c-bytevector")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector")
(define is-pointer (make-c-bytevector 100))
(test-assert "1" (c-bytevector? is-pointer))
(test-end "c-bytevector")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector?")
(define is-pointer1 (make-c-bytevector 100))
(test-assert "1" (c-bytevector? is-pointer1))
(test-assert "2" (not (c-bytevector? 100)))
(test-assert "3" (c-bytevector? #f))
(test-assert "4" (not (c-bytevector? "Hello")))
(test-assert "5" (not (c-bytevector? 'bar)))
(test-end "c-bytevector?")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-free")
(define to-be-freed-pointer (make-c-bytevector 64))

(c-free to-be-freed-pointer)
(test-end "c-free")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "make-c-null")
(define null-pointer (make-c-null))

(test-assert "make-c-null-1" (c-bytevector? null-pointer))

(define-c-procedure c-tempnam libc 'tempnam 'pointer '(pointer pointer))

(let* ((c-tempnam-prefix (string->c-utf8 "npcmd"))
       (r1 (c-utf8->string (c-tempnam (make-c-null)
                                      c-tempnam-prefix)))
       (r2 (c-utf8->string (c-tempnam (make-c-null)
                                      c-tempnam-prefix))))
  (test-assert "make-c-null-2" (string? r1))
  (test-assert "make-c-null-3" (string? r2)))
(test-end "make-c-null")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-null?")
(test-assert "c-null?-1" (c-null? null-pointer))
(test-assert "c-null?-2" (not (c-null? "")))
(test-assert "c-null?-3" (not (c-null? #t)))
(test-assert "c-null?-4" (not (c-null? #f)))
(test-assert "c-null?-5" (not (c-null? 1)))
(test-assert "c-null?-6" (not (c-null? 0)))
(test-end "c-null?")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector-set!")

(define char-cbv (make-c-bytevector (c-type-size 'char)))
(test-assert (bytevector? char-cbv))
(c-bytevector-set! char-cbv 'char 0 #\a)

(define uchar-cbv (make-c-bytevector (c-type-size 'uchar)))
(test-assert (bytevector? uchar-cbv))
(c-bytevector-set! uchar-cbv 'uchar 0 #\a)

(define i8-bv (make-c-bytevector (c-type-size 'i8)))
(test-assert (bytevector? i8-bv))
(c-bytevector-set! i8-bv 'i8 0 1)

(define int-cbv (make-c-bytevector (c-type-size 'int)))
(test-assert (bytevector? int-cbv))
(c-bytevector-set! int-cbv 'int 0 32)

(test-end "c-bytevector-set!")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector-ref")
(test-equal (c-bytevector-ref char-cbv 'char 0) #\a)
(test-equal (c-bytevector-ref uchar-cbv 'uchar 0) #\a)
(test-assert (= (c-bytevector-ref i8-bv 'i8 0) 1))
(test-equal (c-bytevector-ref int-cbv 'int 0) 32)
(test-end "c-bytevector-ref")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "bytevector->c-bytevector")
(define bt1 (make-bytevector 64 0))
(define cbt1 (bytevector->c-bytevector bt1))

(test-assert (c-bytevector? cbt1))
(test-end "bytevector->c-bytevector")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector->bytevector")
(define bt2 (c-bytevector->bytevector cbt1 64))

(test-assert (bytevector? bt2))
(test-assert (equal? bt1 bt2))
(test-end "c-bytevector->bytevector")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-bytevector->integer")
(define cbv-cbc-int (c-bytevector->integer (make-c-bytevector 128)))
(test-assert (number? cbv-cbc-int))
(test-assert (integer? cbv-cbc-int))
(test-end "c-bytevector->integer")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "integer->c-bytevector")
(test-end "integer->c-bytevector")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Strings

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "string->c-utf8")
(define c-string (string->c-utf8 "foobar"))
(test-assert "1" (c-bytevector? c-string))
(test-end "string->c-utf8")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "c-utf8->string")
(define scheme-string (c-utf8->string c-string))

(test-assert (string? scheme-string))
(test-assert (string=? scheme-string "foobar"))
(test-end "c-utf8->string")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Pass pointer by address

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "call-with-address-of")
(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))

(define input-pointer (make-c-bytevector (c-type-size 'int)))
(c-bytevector-set! input-pointer 'i32 0 100)
(test-assert (= (c-bytevector-ref input-pointer 'i32 0) 100))
(call-with-address-of
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(test-assert (= (c-bytevector-ref input-pointer 'i32 0) 42))
(test-end "call-with-address-of")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Structs

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "define-c-struct")
(define-c-struct s
                 s-members
                 s-size
                 #f
                 (field1 'int s-field1 s-field1!)
                 (field2 'int s-field2 s-field2!)
                 (field3 'pointer s-field3 s-field3!)
                 (field4 'int s-field4 s-field4!))

(s-field1! s 1)
(s-field2! s 2)
(s-field3! s (make-c-bytevector 32))
(s-field4! s 4)

(test-equal (s-field1 s) 1)
(test-equal (s-field2 s) 2)
(test-assert (c-bytevector? (s-field3 s)))
(test-equal (s-field4 s) 4)

(define s1-pointer
  (make-c-bytevector (+ (* (c-type-size 'int) 3) (c-type-size 'pointer))))
(c-bytevector-set! s1-pointer 'int (* (c-type-size 'int) 0) 1)
(c-bytevector-set! s1-pointer 'int (* (c-type-size 'int) 1) 2)
(c-bytevector-set! s1-pointer 'pointer (* (c-type-size 'int) 2) (make-c-bytevector 32))
(c-bytevector-set! s1-pointer 'int (+ (* (c-type-size 'int) 2) (c-type-size 'pointer))  4)

(define-c-struct s1
                 s1-members
                 s1-size
                 s1-pointer
                 (field1 'int s1-field1 s1-field1!)
                 (field2 'int s1-field2 s1-field2!)
                 (field3 'pointer s1-field3 s1-field3!)
                 (field4 'int s1-field4 s1-field4!))

(test-equal (s1-field1 s1) 1)
(test-equal (s1-field2 s1) 2)
(test-assert (c-bytevector? (s1-field3 s1)))
(test-equal (s1-field4 s1) 4)
(test-end "define-c-struct")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


;; Utilities

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(test-begin "libc-name")
(test-assert (string? libc-name))
(test-end "libc-name")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
|#
