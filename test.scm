(import (scheme base)
        (scheme write)
        (scheme load)
        (scheme process-context)
        (retropikzel r7rs-pffi version main))

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

(assert equal? (number? (pffi-size-of 'unsigned-int)) #t)
(define size-long (pffi-size-of 'long))
(debug size-long)
(assert equal? (number? size-long) #t)
(assert = size-long 8)

(assert equal? (number? (pffi-size-of 'long)) #t)
(define size-unsigned-long (pffi-size-of 'unsigned-long))
(debug size-unsigned-long)
(assert equal? (number? size-unsigned-long) #t)
(assert = size-unsigned-long 8)

(assert equal? (number? (pffi-size-of 'unsigned-long)) #t)
(define size-float (pffi-size-of 'float))
(debug size-float)
(assert equal? (number? size-float) #t)
(assert = size-float 4)

(assert equal? (number? (pffi-size-of 'float)) #t)
(define size-double (pffi-size-of 'double))
(debug size-double)
(assert equal? (number? size-double) #t)
(assert = size-double 8)

(define size-pointer (pffi-size-of 'pointer))
(debug size-pointer)
(assert equal? (number? size-pointer) #t)
(assert = size-pointer 8)

;; pffi-init

(print-header 'pffi-init)

(pffi-init)

;; pffi-shared-object-auto-load

(print-header 'pffi-shared-object-auto-load)

(define libc-stdlib
  (if (string=? pffi-os-name "windows")
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "ucrtbase" (list ""))
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "c" (list "" ".6"))))

;; pffi-string->pointer

(print-header 'pffi-string->pointer)

(define string-pointer (pffi-string->pointer "Hello world"))
(debug string-pointer)
(assert equal? (pffi-pointer? string-pointer) #t)
(assert equal? (pffi-pointer-null? string-pointer) #f)

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



;; pffi-pointer-allocate

(print-header 'pffi-pointer-allocate)

(define test-pointer (pffi-pointer-allocate 100))
(debug test-pointer)
(assert equal? (pffi-pointer? test-pointer) #t)

;; pffi-pointer-null

(print-header 'pffi-pointer-null)

(define null-pointer (pffi-pointer-null))
(debug null-pointer)
(assert equal? (pffi-pointer-null? null-pointer) #t)

;; pffi-pointer-free

(print-header 'pffi-pointer-free)

(define pointer-to-be-freed (pffi-pointer-allocate 100))
(debug pointer-to-be-freed)
(pffi-pointer-free pointer-to-be-freed)
(debug pointer-to-be-freed)

;; pffi-pointer?

(print-header 'pffi-pointer?)

(define is-pointer (pffi-pointer-allocate 100))
(debug is-pointer)
(assert equal? (pffi-pointer? is-pointer) #t)
(assert equal? (pffi-pointer? 100) #f)
(assert equal? (pffi-pointer? 'bar) #f)

;; pffi-pointer-null?

(print-header 'pffi-pointer-null?)

(define is-null-pointer (pffi-pointer-null))
(debug is-null-pointer)
(define is-not-null-pointer (pffi-pointer-allocate 100))
(debug is-not-null-pointer)
(assert equal? (pffi-pointer-null? is-null-pointer) #t)
(assert equal? (pffi-pointer-null? is-not-null-pointer) #f)
(assert equal? (pffi-pointer-null? 100) #f)
(assert equal? (pffi-pointer-null? 'bar) #f)

;; pffi-pointer-set! and pffi-pointer-get

(print-header "pffi-pointer-set! and pffi-pointer-get")

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

(pffi-pointer-set! set-pointer 'float offset 1.5)
(debug (pffi-pointer-get set-pointer 'float offset))
(assert = (pffi-pointer-get set-pointer 'float offset) 1.5)
(pffi-pointer-set! set-pointer 'double offset 1.5)
(debug (pffi-pointer-get set-pointer 'double offset))
(assert = (pffi-pointer-get set-pointer 'double offset) 1.5)

(define pointer-to-be-set (pffi-string->pointer "FOOBAR"))
(debug pointer-to-be-set)
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

;; pffi-pointer-deref

(print-header 'pffi-pointer-deref)

(define pointer-to-deref (pffi-pointer-allocate (pffi-size-of 'int)))
(debug pointer-to-deref)
(pffi-pointer-set! pointer-to-deref 'int 0 42)
(assert equal? (pffi-pointer? (pffi-pointer-deref pointer-to-deref)) #t)

;; pffi-os-name

(print-header 'pffi-os-name)

(assert equal?
        (or (string=? pffi-os-name "windows")
            (string=? pffi-os-name "unix"))
        #t)

;; pffi-define

(print-header 'pffi-define)


(pffi-define atoi libc-stdlib 'atoi 'int (list 'pointer))
(assert = (atoi (pffi-string->pointer "100")) 100)

;; pffi-define-callback

(print-header 'pffi-define-callback)

(define libcurl (pffi-shared-object-auto-load (list "curl/curl.h") ; Headers
                                              (list ".") ; Additional search paths
                                              "curl" ; The named of shared object without the lib prefix
                                              (list ".4")))
(pffi-define curl-easy-init libcurl 'curl_easy_init 'pointer (list))
(pffi-define curl-easy-setopt libcurl 'curl_easy_setopt 'int (list 'pointer 'int 'pointer))
(pffi-define curl-easy-setopt-callback libcurl 'curl_easy_setopt 'int (list 'pointer 'int 'callback))
(pffi-define curl-easy-getinfo libcurl 'curl_easy_getinfo 'int (list 'pointer 'int 'pointer))
(pffi-define curl-easy-perform libcurl 'curl_easy_perform 'int (list 'pointer))
(define CURLOPT-WRITEFUNCTION 20011)
(define CURLOPT-FOLLOWLOCATION 52)
(define CURLOPT-URL 10002)
(define CURLINFO-RESPONSE-CODE 2097154)

(define result "")
(pffi-define-callback collect-result
                      'void
                      (list 'pointer 'int 'int 'pointer)
                      (lambda (pointer size nmemb client-pointer)
                        (set! result (string-append result (string-copy (pffi-pointer->string pointer))))))

(define handle (curl-easy-init))
(define url "https://scheme.org")
(debug url)
(define curl-code1 (curl-easy-setopt handle CURLOPT-FOLLOWLOCATION (pffi-string->pointer url)))
(debug curl-code1)
(assert = curl-code1 0)

(define curl-code2 (curl-easy-setopt handle CURLOPT-URL (pffi-string->pointer url)))
(debug curl-code2)
(assert = curl-code2 0)

(define curl-code3 (curl-easy-setopt-callback handle CURLOPT-WRITEFUNCTION collect-result))
(debug curl-code3)
(assert = curl-code3 0)

(define curl-code4 (curl-easy-perform handle))
(debug curl-code4)
(assert = curl-code4 0)

(define http-code (pffi-pointer-allocate (pffi-size-of 'int)))
(curl-easy-getinfo handle CURLINFO-RESPONSE-CODE http-code)
(assert = (pffi-pointer-get http-code 'int 0) 200)

(exit 0)
