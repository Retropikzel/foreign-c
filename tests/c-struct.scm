(define-c-struct s
                 s-members
                 #f
                 (field1 'int s-field1 s-field1!)
                 (field2 'int s-field2 s-field2!)
                 (field3 'pointer s-field3 s-field3!)
                 (field4 'int s-field4 s-field4!))

(s-field1! s 1)
(s-field2! s 2)
(s-field3! s (make-c-bytevector 32))
(s-field4! s 4)

(test-equal (s-field1 s) 1)
(test-equal (s-field2 s) 2)
(test-assert (c-bytevector? (s-field3 s)))
(test-equal (s-field4 s) 4)

(define s1-pointer
  (make-c-bytevector (+ (* (c-type-size 'int) 3) (c-type-size 'pointer))))
(c-bytevector-sint-set! s1-pointer (* (c-type-size 'int) 0) 1 (native-endianness) (c-type-size 'int))
(c-bytevector-sint-set! s1-pointer (* (c-type-size 'int) 1) 2 (native-endianness) (c-type-size 'int))
(c-bytevector-pointer-set! s1-pointer (* (c-type-size 'int) 2) (make-c-bytevector 32))
(c-bytevector-sint-set! s1-pointer (+ (* (c-type-size 'int) 2) (c-type-size 'pointer))  4 (native-endianness) (c-type-size 'int))

(define-c-struct s1
                 s1-members
                 s1-pointer
                 (field1 'int s1-field1 s1-field1!)
                 (field2 'int s1-field2 s1-field2!)
                 (field3 'pointer s1-field3 s1-field3!)
                 (field4 'int s1-field4 s1-field4!))

(test-equal (s1-field1 s1) 1)
(test-equal (s1-field2 s1) 2)
(test-assert (c-bytevector? (s1-field3 s1)))
(test-equal (s1-field4 s1) 4)
