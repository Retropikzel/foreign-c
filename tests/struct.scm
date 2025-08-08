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

;; define-c-struct

(define-c-struct s
                 s-members
                 (make-c-null)
                 (field1 'int t-struct:field1 t-struct:field1!)
                 (field2 'int t-struct:field2 t-struct:field2!)
                 (field3 'pointer t-struct:field3 t-struct:field3!)
                 (field4 'int t-struct:field4 t-struct:field4!))

(t-struct:field1! s 1)
(t-struct:field2! s 2)
(t-struct:field3! s (make-c-bytevector 32))
(t-struct:field4! s 4)

(write s)
(newline)
(write s-members)
(newline)
(write (t-struct:field1 s))
(newline)
(write (t-struct:field2 s))
(newline)
(write (t-struct:field3 s))
(newline)
(write (t-struct:field4 s))
(newline)

(write (c-struct->alist s s-members))
(newline)
