(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme eval)
        (scheme process-context)
        (cyclone foreign))


(define-syntax pffi-shared-object-load
      (er-macro-transformer
        (lambda (expr rename compare)
          (let* ((headers (cdr (car (cdr expr)))))
            `(begin
               ,@ (map
                    (lambda (header)
                      `(include-c-header ,(string-append "<" header ">")))
                    headers))))))
