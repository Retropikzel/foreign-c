(import (scheme base)
        (scheme write)
        (retropikzel pffi v0.1.0 main))

(define libcurl (pffi-shared-object-auto-load "curl" (list)))

(define curl-version (pffi-lambda libcurl 'curl_version 'string (list)))


(write (pffi-pointer->string (curl-version)))
(newline)
