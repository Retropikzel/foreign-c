(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme eval)
        (scheme process-context)
        (cyclone foreign))


(define-syntax while
  (syntax-rules ()
    ((while condition . body)
     (let loop ()
       (cond (condition
               (begin . body)
               (loop)))))))
