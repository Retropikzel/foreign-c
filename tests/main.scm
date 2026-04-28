(test-begin "foreign-c")


;; Types
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
    (test-equal (c-type-size 'ulong) 4))
  (else
    (test-equal (c-type-size 'ulong) 8)))
(test-equal "c-type-size float" (c-type-size 'float) 4)
(test-equal "c-type-size double" (c-type-size 'double) 8)
#;(cond-expand
  (i386
    (test-equal (c-type-size 'pointer) 4))
  (else
    (test-equal (c-type-size 'pointer) 8)))
(test-end "c-type-size")


(test-begin "c-type-align")
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
(test-end "c-type-align")


;; Libraries and procedures
(test-begin "define-c-library")
(define-c-library libc '("stdlib.h" "stdio.h" "string.h" "stdio.h") #f ())

(test-assert "test-assert libc" (if libc #t #f))

(define-c-procedure c-abs libc 'abs 'int '(int))
(test-equal "c-abs" (c-abs -2) 2)

(define-c-library c-testlib
                      '("libtest.h")
                      "test"
                      '((additional-paths ("." "./tests"))))
(define-c-procedure c-takes-no-args c-testlib 'takes_no_args 'void '())
(c-takes-no-args)

(define intpointer (make-c-bytevector (c-type-size 'int)))
(define-c-procedure c-passing-int-pointer c-testlib 'test_passing_int_pointer 'int '(pointer))
(c-passing-int-pointer intpointer)
(write (c-bytevector-ref intpointer 'int))
(newline)

(define-c-procedure c-takes-no-args-returns-int c-testlib 'takes_no_args_returns_int 'int '())
(define takes-no-args-returns-int-result (c-takes-no-args-returns-int))
(test-equal takes-no-args-returns-int-result 0)
(test-end "define-c-library")

(test-begin "define-c-procedure")
(define-c-procedure c-atoi libc 'atoi 'int '(pointer))
(test-equal "1" (c-atoi (string->c-bytevector "100")) 100)

(define-c-procedure c-puts libc 'puts 'int '(pointer))
(define chars-written (c-puts (string->c-bytevector "puts: Hello from testing, I am C function puts")))
(test-equal "2" chars-written 47)

(define-c-procedure c-strcat libc 'strcat 'pointer '(pointer pointer))
(define c-string1 (string->c-bytevector "test123"))
(test-assert "3" (string=? (c-bytevector->string (c-strcat (string->c-bytevector "con2")
                                                           (string->c-bytevector "cat2")))
                           "con2cat2"))

(when (file-exists? "testfile.test") (delete-file "testfile.test"))
(define-c-procedure c-fopen libc 'fopen 'pointer '(pointer pointer))
(define output-file (c-fopen (string->c-bytevector "testfile.test")
                             (string->c-bytevector "w")))
(define-c-procedure c-fprintf libc 'fprintf 'int '(pointer pointer int))
(define characters-written (c-fprintf output-file (string->c-bytevector "Hello world %i") 1))
(test-equal "4" characters-written 13)
(define-c-procedure c-fclose libc 'fclose 'int '(pointer))
(define closed-status (c-fclose output-file))
(test-equal "5" closed-status 0)
(test-assert "6" (file-exists? "testfile.test"))

(define (rl result)
  ;; Own readline so tests work on R6RS
  (let ((c (read-char)))
    (if (eof-object? c)
      result
      (rl (string-append result (string c))))))
(define file-content (with-input-from-file "testfile.test"
                                           (lambda () (rl ""))))
(test-assert "7" (string=? file-content "Hello world 1"))
(test-end "define-c-procedure")


;; c-bytevectors
(test-begin "make-c-bytevector")
(define bytes (make-c-bytevector 100))
(test-assert (c-bytevector? bytes))
(test-assert (not (c-bytevector-null? bytes)))
(test-end "make-c-bytevector")


(test-begin "c-bytevector")
(define is-pointer (make-c-bytevector 100))
(test-assert (c-bytevector? is-pointer))
(test-end "c-bytevector")


(test-begin "c-bytevector?")
(define is-pointer1 (make-c-bytevector 100))
(test-assert (c-bytevector? is-pointer1))
(test-equal #f (c-bytevector? 100))
(test-equal #f (c-bytevector? #t))
(test-equal #f (c-bytevector? "Hello"))
(test-equal #f (c-bytevector? 'bar))
(test-end "c-bytevector?")


(test-begin "c-bytevector-free")
(define to-be-freed-pointer (make-c-bytevector 64))
(c-bytevector-free to-be-freed-pointer)
(test-end "c-bytevector-free")


(test-begin "c-bytevector-null")
(define null-cbv (c-bytevector-null))
(test-assert (c-bytevector? null-cbv))
(define-c-procedure c-tempnam libc 'tempnam 'pointer '(pointer pointer))
(let* ((c-tempnam-prefix (string->c-bytevector "npcmd"))
       (r1 (c-bytevector->string (c-tempnam (c-bytevector-null) c-tempnam-prefix)))
       (r2 (c-bytevector->string (c-tempnam (c-bytevector-null) c-tempnam-prefix))))
  (test-assert (string? r1))
  (test-assert (string? r2)))
(test-end "c-bytevector-null")


(test-begin "c-bytevector-null?")
(test-assert (c-bytevector-null? null-cbv))
(test-assert (not (c-bytevector-null? "")))
(test-assert (not (c-bytevector-null? #t)))
(test-assert (not (c-bytevector-null? 1)))
(test-assert (not (c-bytevector-null? 0)))
(test-end "c-bytevector-null?")


(test-begin "c-bytevector-set!")
(define i8-cbv (make-c-bytevector (c-type-size 'i8)))
(test-assert (c-bytevector? i8-cbv))
(c-bytevector-set! i8-cbv 'i8 0 1)

(define u8-cbv (make-c-bytevector (c-type-size 'u8)))
(test-assert (c-bytevector? u8-cbv))
(c-bytevector-set! u8-cbv 'u8 0 2)

(define i16-cbv (make-c-bytevector (c-type-size 'i16)))
(test-assert (c-bytevector? i16-cbv))
(c-bytevector-set! i16-cbv 'i16 0 3)

(define u16-cbv (make-c-bytevector (c-type-size 'u16)))
(test-assert (c-bytevector? u16-cbv))
(c-bytevector-set! u16-cbv 'u16 0 4)

(define i32-cbv (make-c-bytevector (c-type-size 'i32)))
(test-assert (c-bytevector? i32-cbv))
(c-bytevector-set! i32-cbv 'i32 0 5)

(define u32-cbv (make-c-bytevector (c-type-size 'u32)))
(test-assert (c-bytevector? u32-cbv))
(c-bytevector-set! u32-cbv 'u32 0 6)

(define i64-cbv (make-c-bytevector (c-type-size 'i64)))
(test-assert (c-bytevector? i64-cbv))
(c-bytevector-set! i64-cbv 'i64 0 7)

(define u64-cbv (make-c-bytevector (c-type-size 'u64)))
(test-assert (c-bytevector? u64-cbv))
(c-bytevector-set! u64-cbv 'u64 0 8)

(define char-cbv (make-c-bytevector (c-type-size 'char)))
(test-assert (c-bytevector? char-cbv))
(c-bytevector-set! char-cbv 'char 0 #\a)

(define uchar-cbv (make-c-bytevector (c-type-size 'uchar)))
(test-assert (c-bytevector? uchar-cbv))
(c-bytevector-set! uchar-cbv 'uchar 0 #\b)

(define short-cbv (make-c-bytevector (c-type-size 'short)))
(test-assert (c-bytevector? short-cbv))
(c-bytevector-set! short-cbv 'short 0 9)

(define ushort-cbv (make-c-bytevector (c-type-size 'ushort)))
(test-assert (c-bytevector? ushort-cbv))
(c-bytevector-set! ushort-cbv 'ushort 0 10)

(define int-cbv (make-c-bytevector (c-type-size 'int)))
(test-assert (c-bytevector? int-cbv))
(c-bytevector-set! int-cbv 'int 0 11)

(define uint-cbv (make-c-bytevector (c-type-size 'uint)))
(test-assert (c-bytevector? uint-cbv))
(c-bytevector-set! uint-cbv 'uint 0 12)

(define long-cbv (make-c-bytevector (c-type-size 'long)))
(test-assert (c-bytevector? long-cbv))
(c-bytevector-set! long-cbv 'long 0 13)

(define ulong-cbv (make-c-bytevector (c-type-size 'ulong)))
(test-assert (c-bytevector? ulong-cbv))
(c-bytevector-set! ulong-cbv 'ulong 0 14)

(define float-cbv (make-c-bytevector (c-type-size 'float)))
(test-assert (c-bytevector? float-cbv))
(c-bytevector-set! float-cbv 'float 0 15.5)

(define double-cbv (make-c-bytevector (c-type-size 'double)))
(test-assert (c-bytevector? double-cbv))
(c-bytevector-set! double-cbv 'double 0 16.5)

(define pointer-cbv (make-c-bytevector (c-type-size 'pointer)))
(test-assert (c-bytevector? pointer-cbv))
(c-bytevector-set! pointer-cbv 'pointer 0 (c-bytevector-null))
(test-end "c-bytevector-set!")


(test-begin "c-bytevector-ref")
(test-equal "i8" 1 (c-bytevector-ref i8-cbv 'i8 0))
(test-equal "u8" 2 (c-bytevector-ref u8-cbv 'u8 0))
(test-equal "i16" 3 (c-bytevector-ref i16-cbv 'i16 0))
(test-equal "u16" 4 (c-bytevector-ref u16-cbv 'u16 0))
(test-equal "i32" 5 (c-bytevector-ref i32-cbv 'i32 0))
(test-equal "u32" 6 (c-bytevector-ref u32-cbv 'u32 0))
(test-equal "i64" 7 (c-bytevector-ref i64-cbv 'i64 0))
(test-equal "u64" 8 (c-bytevector-ref u64-cbv 'u64 0))
(test-equal "char" #\a (c-bytevector-ref char-cbv 'char 0))
(test-equal "uchar" #\b (c-bytevector-ref uchar-cbv 'uchar 0))
(test-equal "short" 9 (c-bytevector-ref short-cbv 'short 0))
(test-equal "ushort" 10 (c-bytevector-ref ushort-cbv 'ushort 0))
(test-equal "int" 11 (c-bytevector-ref int-cbv 'int 0))
(test-equal "uint" 12 (c-bytevector-ref uint-cbv 'uint 0))
(test-equal "long" 13 (c-bytevector-ref long-cbv 'long 0))
(test-equal "ulong" 14 (c-bytevector-ref ulong-cbv 'ulong 0))
(test-equal "float" 15.5 (c-bytevector-ref float-cbv 'float 0))
(test-equal "double" 16.5 (c-bytevector-ref double-cbv 'double 0))
(test-assert "pointer" (c-bytevector-null? (c-bytevector-ref pointer-cbv 'pointer 0)))
(test-end "c-bytevector-ref")


(test-begin "bytevector->c-bytevector")
(define bt1 (make-bytevector 64 0))
(define cbt1 (bytevector->c-bytevector bt1))
(test-assert (c-bytevector? cbt1))
(test-end "bytevector->c-bytevector")


(test-begin "c-bytevector->bytevector")
(define bt2 (c-bytevector->bytevector cbt1 64))
(test-assert (bytevector? bt2))
(test-assert (equal? bt1 bt2))
(test-end "c-bytevector->bytevector")


(test-begin "c-bytevector->integer")
(define cbv-cbc-int (c-bytevector->integer (make-c-bytevector 128)))
(test-assert (number? cbv-cbc-int))
(test-assert (integer? cbv-cbc-int))
(test-end "c-bytevector->integer")


(test-begin "integer->c-bytevector")
(test-end "integer->c-bytevector")

;; Strings
(test-begin "string->c-bytevector")
(define c-string (string->c-bytevector "foobar"))
(test-assert (c-bytevector? c-string))
(test-end "string->c-bytevector")


(test-begin "c-bytevector->string")
(define scheme-string (c-bytevector->string c-string))
(test-assert (string? scheme-string))
(test-assert (string=? scheme-string "foobar"))
(test-end "c-bytevector->string")


;; Pass pointer by address
#|
(test-begin "call-with-address-of")
(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))
(define input-pointer (make-c-bytevector (c-type-size 'int)))
(c-bytevector-set! input-pointer 'i32 0 100)
(test-equal 100 (c-bytevector-ref input-pointer 'i32 0))
(call-with-address-of
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(test-equal 42 (c-bytevector-ref input-pointer 'i32 0))
(test-end "call-with-address-of")
|#

;; C Array
(test-begin "define-c-array-type")
(define-c-array-type i8-array 'i8)
(define ar1 (make-c-bytevector (* (c-type-size i8-array) 10)))
(write ar1)
(newline)
(c-bytevector-set! ar1 i8-array 5 25)
(write (c-bytevector-ref ar1 i8-array 5))
(newline)
(test-end"define-c-array-type")


;; C Struct
(test-begin "define-c-struct-type")
(define-c-struct-type color '((r i8) (g i8) (b i8) (a i8)))
(test-assert (c-struct-type? color))

(define green (make-c-bytevector (c-type-size color)))
(c-bytevector-set! green color 'r 1)
(c-bytevector-set! green color 'g 2)
(c-bytevector-set! green color 'b 3)
(c-bytevector-set! green color 'a 4)

(test-equal 1 (c-bytevector-ref green color 'r))
(test-equal 2 (c-bytevector-ref green color 'g))
(test-equal 3 (c-bytevector-ref green color 'b))
(test-equal 4 (c-bytevector-ref green color 'a))

(test-equal (c-bytevector->list green color) '((r . 1) (g . 2) (b . 3) (a . 4)))
(test-end "define-c-struct-type")


(test-end "foreign-c")

