(cond-expand
  (windows (pffi-define-library pffi-libc-stdlib
                                '("stdlib.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (pffi-define-library pffi-libc-stdlib
                             '("stdlib.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(cond-expand
  (chibi #t) ; FIXME
  (else (pffi-define pffi-pointer-allocate pffi-libc-stdlib 'malloc 'pointer '(int))))

(pffi-define pffi-pointer-allocate-aligned pffi-libc-stdlib 'aligned_alloc 'pointer '(int int))
(pffi-define pffi-pointer-allocate-calloc pffi-libc-stdlib 'calloc 'pointer '(int int))

(cond-expand
  (chibi #t) ; FIXME
  (else (pffi-define pffi-pointer-free pffi-libc-stdlib 'free 'void '(pointer))))
