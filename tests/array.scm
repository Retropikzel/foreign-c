(import (scheme base)
        (scheme write)
        (scheme read)
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

;; make-c-array

(print-header 'make-c-array)

(define arr (make-c-array 'uint64 10 0))
(debug arr)

(c-array-set! arr 'uint64 5 100)
(debug (c-array-ref arr 'uint64 5))
(assert = (c-array-ref arr 'uint64 5) 100)

(c-array-set! arr 'uint64 9 101)
(assert = (c-array-ref arr 'uint64 9) 101)

(define l (c-array->list arr 'uint64 10))
(debug l)
(assert equal? l '(0 0 0 0 0 100 0 0 0 101))

(define arr1 (list->c-array '(0 1 2 3 4 5 6 7 8 9) 'uint32))

(assert = (c-array-ref arr1 'uint32 0) 0)
(assert = (c-array-ref arr1 'uint32 3) 3)
(assert = (c-array-ref arr1 'uint32 8) 8)

