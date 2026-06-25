(test-begin "foreign-c callbacks")

(define-c-library libc '("stdlib.h") #f ())

(define array (make-c-bytevector (* (c-type-size 'int) 3)))
(c-bytevector-set! array 'int (* (c-type-size 'int) 0) 3)
(c-bytevector-set! array 'int (* (c-type-size 'int) 1) 2)
(c-bytevector-set! array 'int (* (c-type-size 'int) 2) 1)

(define-c-procedure qsort libc 'qsort 'void '(pointer int int callback))

(define-c-callback compare
                   'int
                   '(pointer pointer)
                   (lambda (pointer-a pointer-b)
                     (let ((a (c-bytevector-ref
                                ;; Raw C pointers are passed to callbacks so
                                ;; wrap them
                                (pointer->c-bytevector pointer-a)
                                'int
                                0))
                           (b (c-bytevector-ref
                                ;; Raw C pointers are passed to callbacks so
                                ;; wrap them
                                (pointer->c-bytevector pointer-b)
                                'int
                                0)))
                       (cond ((> a b) 1)
                             ((= a b) 0)
                             ((< a b) -1)))))

(define unsorted
  (list (c-bytevector-ref array 'int (* (c-type-size 'int) 0))
        (c-bytevector-ref array 'int (* (c-type-size 'int) 1))
        (c-bytevector-ref array 'int (* (c-type-size 'int) 2))))

(test-equal unsorted '(3 2 1))

(qsort array 3 (c-type-size 'int) compare)


(define sorted
  (list (c-bytevector-ref array 'int (* (c-type-size 'int) 0))
        (c-bytevector-ref array 'int (* (c-type-size 'int) 1))
        (c-bytevector-ref array 'int (* (c-type-size 'int) 2))))

(test-equal sorted (list 1 2 3))

(test-end "foreign-c callbacks")
