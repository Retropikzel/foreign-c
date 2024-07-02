(import (scheme base)
        (scheme write)
        (scheme process-context)
        (scheme eval)
        (retropikzel pffi v0-3-0 main))

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
