(cond-expand
  (windows (define-c-library libc
                             '("stdio.h" "string.h")
                             "ucrtbase"
                             '((additional-versions ("0" "6")))))
  (else
    (define c-library "c")
    (when (get-environment-variable "BE_HOST_CPU")
      (set! c-library "root"))
    (define-c-library libc
                      '("stdio.h" "string.h")
                      c-library
                      '((additional-versions ("" "0" "6" "7"))))))
