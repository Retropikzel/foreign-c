(declare (usual-integrations))
(load-option 'ffi)

;(define lib (dld-load-file "mit-scheme-foreign-c-shim.so"))
(C-include "mit-scheme-foreign-c")

(define (hello)
  (puts "Hello from puts")
  ;(display "Not from puts")
  (newline)
  )
;(C-call "puts" "Hello world")
