(import (scheme base)
        (scheme write)
        (scheme process-context)
        (scheme eval)
        (retropikzel r7rs-pffi v0-4-0 main))

(define libcurl (pffi-shared-object-auto-load (list "curl/curl.h")
                                              (list)
                                              "curl"
                                              (list ".4")))

(pffi-define curl-version libcurl 'curl_version 'string (list))

(display "=================")
(newline)

(display (pffi-pointer->string (curl-version)))

(newline)
(display "=================")
(newline)
