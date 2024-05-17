(import (scheme base)
        (scheme write)
        (scheme process-context)
        (scheme eval)
        (retropikzel pffi v0-1-0 main))

(define libcurl (pffi-shared-object-auto-load (list "curl/curl.h") "curl" (list)))

(display libcurl)
(newline)

(pffi-define 'curl-version libcurl 'curl_version 'string (list))

(display "=================")
(newline)

(display (pffi-pointer->string (curl-version)))

(newline)
(display "=================")
(newline)
