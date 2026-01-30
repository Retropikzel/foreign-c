(test-begin "c-bytevector-uchar-set!")

(define uchar-cbv (make-c-bytevector (c-type-size 'int8)))
(test-assert (bytevector? uchar-cbv))
(c-bytevector-uchar-set! uchar-cbv 0 #\a)

(test-end "c-bytevector-uchar-set!")
