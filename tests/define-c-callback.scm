(test-begin "define-c-callback")

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
(test-equal unsorted (list 3 2 1))

(qsort array 3 (c-type-size 'int) compare)

(define sorted (list (c-bytevector-s32-native-ref array (* (c-type-size 'int) 0))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 1))
                       (c-bytevector-s32-native-ref array (* (c-type-size 'int) 2))))
(test-equal sorted (list 1 2 3))

(test-end "define-c-callback")
