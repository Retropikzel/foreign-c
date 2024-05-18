(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme process-context))

(define t "hello")


(define-syntax pffi-shared-object-load
  (syntax-rules ()
    ((pffi-shared-object-load headers path)
     (begin (display "hello")

            ))
    )

  )
