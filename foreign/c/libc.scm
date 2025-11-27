(define-c-library libc
                  '("stdlib.h" "stdio.h" "string.h")
                  libc-name
                  '((additional-versions ("0" "6"))))

(define-c-procedure c-malloc libc 'malloc 'pointer '(int))
(define-c-procedure c-free libc 'free 'void '(pointer))
(define-c-procedure c-strlen libc 'strlen 'int '(pointer))
(define-c-procedure c-memset-address->pointer libc 'memset 'pointer '(uint64 uint8 int))
(define-c-procedure c-memset-pointer->address libc 'memset 'uint64 '(pointer uint8 int))
(define (make-c-null) (c-memset-address->pointer 0 0 0))
(define (c-null? pointer)
  ;(if (c-bytevector? pointer)
    (= (c-memset-pointer->address pointer 0 0) 0)
    ;#f)
)
