(cond-expand
  ;(kawa #t) ; JVM
  (windows (pffi-define-library pffi-libc-stdlib
                                '("stdlib.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library pffi-libc-stdlib
                             '("stdlib.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(pffi-define pffi-pointer-allocate pffi-libc-stdlib 'malloc 'pointer '(int))
;(pffi-define pffi-pointer-allocate-aligned pffi-libc-stdlib 'aligned_alloc 'pointer '(int int))
(pffi-define pffi-pointer-free pffi-libc-stdlib 'free 'void '(pointer))

#;(define pffi-pointer-null
  (lambda ()
    ; Make aligned_alloc fail and return us a null pointer
    (pffi-pointer-allocate-aligned -1 -1)))
