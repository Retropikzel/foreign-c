(import (scheme base)
        (scheme write)
        (scheme load)
        (scheme process-context)
        (retropikzel r7rs-pffi version main))

(define print-header
  (lambda (title)
    (display "=========================================")
    (newline)
    (display title)
    (newline)
    (display "=========================================")
    (newline)))

(define-syntax assert
  (syntax-rules ()
    ((_ check value-a value-b)
     (let ((result (apply check (list value-a value-b))))
       (if (not result) (display "FAIL: ") (display "PASS: "))
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

;; pffi-shared-object-auto-load

(print-header 'pffi-shared-object-auto-load)

(define libc-stdlib
  (if (string=? pffi-os-name "windows")
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "ucrtbase" (list ""))
    (pffi-shared-object-auto-load (list "stdlib.h") (list) "c" (list "" ".6"))))

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
                        (set! result (string-append result (pffi-pointer->string pointer)))))

(define handle (curl-easy-init))
(define url (pffi-string->pointer "https://scheme.org"))
(define curl-code1 (curl-easy-setopt handle CURLOPT-FOLLOWLOCATION url))
(debug curl-code1)
(assert = curl-code1 0)
(define curl-code2 (curl-easy-setopt handle CURLOPT-URL url))
(debug curl-code2)
(assert = curl-code2 0)
(define curl-code3 (curl-easy-setopt-callback handle CURLOPT-WRITEFUNCTION collect-result))
(debug curl-code3)
(assert = curl-code3 0)
(debug (curl-easy-perform handle))
(define http-code (pffi-pointer-allocate (pffi-size-of 'int)))
(curl-easy-getinfo handle CURLINFO-RESPONSE-CODE http-code)
(assert = (pffi-pointer-get http-code 'int 0) 200)

;; pffi-size-of

(print-header 'pffi-size-of)

(define size-int8 (pffi-size-of 'int8))
(debug size-int8)
(assert equal? (number? size-int8) #t)
(assert = size-int8 1)

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

;; pffi-string->pointer

(print-header 'pffi-string->pointer)

(define string-pointer (pffi-string->pointer "Hello world"))
(debug string-pointer)
(assert equal? (pffi-pointer? string-pointer) #t)

;; pffi-pointer->string

(print-header 'pffi-pointer->string)

(define pointer-string (pffi-pointer->string string-pointer))
(debug pointer-string)
(assert string=? pointer-string "Hello world")

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

(define set-pointer (pffi-pointer-allocate 100))
(define offset 50)
(define value 10)
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
(test-type 'float)
(test-type 'double)

(define pointer-to-be-set (pffi-string->pointer "FOOBAR"))
(debug pointer-to-be-set)
(pffi-pointer-set! set-pointer 'pointer offset pointer-to-be-set)
(assert equal?
        (pffi-pointer? (pffi-pointer-get set-pointer 'pointer offset))
        #t)
(assert string=?
        (pffi-pointer->string (pffi-pointer-get set-pointer 'pointer offset))
        "FOOBAR")

(define string-to-be-set "FOOBAR")
(debug string-to-be-set)
(pffi-pointer-set! set-pointer 'string offset string-to-be-set)
(assert string=? (pffi-pointer-get set-pointer 'string offset) "FOOBAR")

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



(exit 0)
