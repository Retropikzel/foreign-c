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

;; call-with-address-of-c-bytevector

(define-c-library c-testlib
                     '("libtest.h")
                     "test"
                     '((additional-paths ("." "./tests"))))


(print-header 'call-with-address-of-c-bytevector)

(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))

(define input-pointer (make-c-bytevector (c-size-of 'int)))
(c-bytevector-s32-native-set! input-pointer 0 100)
(debug (c-bytevector-s32-native-ref input-pointer 0))
(call-with-address-of-c-bytevector
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(debug input-pointer)
(debug (c-bytevector-s32-native-ref input-pointer 0))
(assert equal? (= (c-bytevector-s32-native-ref input-pointer 0) 42) #t)
