(import (scheme base)
        (scheme write)
        (scheme process-context)
        (retropikzel pffi v0-2-2 main)
        (sagittarius ffi))

(define libcurl (pffi-shared-object-auto-load (list "curl/curl.h") ; Headers
                                              (list ".") ; Additional search paths
                                              "curl" ; The named of shared object without the lib prefix
                                              (list ".4"))) ;Additional versions to search

(pffi-define curl-easy-init libcurl 'curl_easy_init 'pointer (list))

; Define the curl-easy-setopt twice since some implementations (Sagittarius) complain if you pass
; callback type instead of pointer type
(pffi-define curl-easy-setopt libcurl 'curl_easy_setopt 'int (list 'pointer 'int 'pointer))
(pffi-define curl-easy-setopt-callback libcurl 'curl_easy_setopt 'int (list 'pointer 'int 'callback))

(pffi-define curl-easy-perform libcurl 'curl_easy_perform 'int (list 'pointer))

;These values need to be get from c file like this:
; #include <curl/curl.h>
; int main() {
;   printf("Value: %d", CURLOPT_WRITEFUNCTION);
; }
; many times you can get them from .h files directly
(define CURLOPT-WRITEFUNCTION 20011)
(define CURLOPT-FOLLOWLOCATION 52)
(define CURLOPT-URL 10002)

(define result "")
(pffi-define-callback collect-result
                      'int
                      (list 'pointer 'int 'int 'pointer)
                      (lambda (pointer size nmemb client-pointer)
                        (set! result
                          (string-append result (pffi-pointer->string pointer)))))

(define handle (curl-easy-init))
(define url (pffi-string->pointer "https://scheme.org"))
(define curl-code1 (curl-easy-setopt handle CURLOPT-FOLLOWLOCATION url))
(define curl-code2 (curl-easy-setopt handle CURLOPT-URL url))
(define curl-code3 (curl-easy-setopt-callback handle CURLOPT-WRITEFUNCTION collect-result))
(display curl-code1)
(newline)
(display curl-code2)
(newline)
(display curl-code3)
(newline)
(curl-easy-perform handle)

(display (string-length result))
(newline)
