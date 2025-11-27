(import (scheme base)
        (scheme write)
        (scheme char)
        (scheme file)
        (scheme process-context)
        (foreign c))

;; util
(define header-count 1)

(define print-header
  (lambda (title)
    (set-tag title)
    (display "=========================================")
    (newline)
    (display header-count)
    (display " ")
    (display title)
    (newline)
    (display "=========================================")
    (newline)
    (set! header-count (+ header-count 1))))

(define count 0)
(define assert-tag 'none)

(define set-tag
  (lambda (tag)
    (set! assert-tag tag)
    (set! count 0)))

(cond-expand
  (gambit
    (define assert
      (lambda (check value-a value-b)
        (let ((result (apply check (list value-a value-b))))
          (set! count (+ count 1))
          (if (not result) (display "FAIL ") (display "PASS "))
          (display "[")
          (display assert-tag)
          (display " - ")
          (display count)
          (display "]")
          (display ": ")
          (write (list 'check 'value-a 'value-b))
          (newline)
          (when (not result) (exit 1))))))
  (else
    (define-syntax assert
      (syntax-rules ()
        ((_ check value-a value-b)
         (let ((result (apply check (list value-a value-b))))
           (set! count (+ count 1))
           (if (not result) (display "FAIL ") (display "PASS "))
           (display "[")
           (display assert-tag)
           (display " - ")
           (display count)
           (display "]")
           (display ": ")
           (write (list 'check 'value-a 'value-b))
           (newline)
           (when (not result) (exit 1))))))))

(define-syntax debug
  (syntax-rules ()
    ((_ value)
     (begin
       (display 'value)
       (display ": ")
       (write value)
       (newline)))))

(define-c-library libc '("stdlib.h" "stdio.h" "time.h") libc-name '((additional-versions ("6"))))

(print-header "pointers 1")

(define p (make-c-bytevector 100))
(debug p)
(assert equal? (c-bytevector? p) #t)

(define n (make-c-null))
(debug n)
(assert equal? (c-bytevector? n) #t)

(define-c-procedure c-time libc 'time 'int '(pointer))
(define-c-procedure c-srand libc 'srand 'void '(int))
(c-srand (c-time (make-c-null)))

(define-c-procedure c-rand libc 'rand 'int '())
(define random-integer (c-rand))
(assert equal? (number? random-integer) #t)
