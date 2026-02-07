(test-begin "call-with-address-of")

(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))

(define input-pointer (make-c-bytevector (c-type-size 'int)))
(c-bytevector-s32-native-set! input-pointer 0 100)
(test-assert (= (c-bytevector-s32-native-ref input-pointer 0) 100))
(call-with-address-of
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(test-assert (= (c-bytevector-s32-native-ref input-pointer 0) 42))

(test-end "call-with-address-of")
