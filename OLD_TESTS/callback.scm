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


;; define-c-library

(print-header 'define-c-library)

(cond-expand
  (windows (define-c-library libc
                                '("stdio.h" "string.h")
                                "ucrtbase"
                                '((additional-versions ("0" "6")))))
  (else (define-c-library libc
                             '("stdio.h" "string.h")
                             "c"
                             '((additional-versions ("0" "6"))))))

(debug libc)

;; define-c-callback

(print-header 'define-c-callback)

(define array (make-c-bytevector (* (c-type-size 'int) 3)))
(c-bytevector-s32-native-set! array (* (c-type-size 'int) 0) 3)
(c-bytevector-s32-native-set! array (* (c-type-size 'int) 1) 2)
(c-bytevector-s32-native-set! array (* (c-type-size 'int) 2) 1)

(define-c-procedure qsort libc 'qsort 'void '(pointer int int callback))

(define-c-callback compare
                   'int
                   '(pointer pointer)
                   (lambda (pointer-a pointer-b)
                     (let ((a (c-bytevector-s32-native-ref pointer-a 0))
                           (b (c-bytevector-s32-native-ref pointer-b 0)))
                       (cond ((> a b) 1)
                             ((= a b) 0)
                             ((< a b) -1)))))
(write compare)
(newline)

(define unsorted (list (c-bytevector-s32-native-ref array (* (c-type-size 'int) 0))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 1))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 2))))
(debug unsorted)
(assert equal? unsorted (list 3 2 1))

(qsort array 3 (c-type-size 'int) compare)

(define sorted (list (c-bytevector-s32-native-ref array (* (c-type-size 'int) 0))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 1))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 2))))
(debug sorted)
(assert equal? sorted (list 1 2 3))

(exit 0)
