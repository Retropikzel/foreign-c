(define-c-library c-testlib
                      '("libtest.h")
                      "test"
                      '((additional-paths ("." "./tests"))))

;; Pass pointer by address
(test-begin "call-with-address-of")
(define-c-procedure test-passing-pointer-address
                      c-testlib
                      'test_passing_pointer_address
                      'int
                      '(pointer pointer))
(define input-pointer (make-c-bytevector (c-type-size 'int)))
(c-bytevector-set! input-pointer 'i32 0 100)
(test-equal 100 (c-bytevector-ref input-pointer 'i32 0))
(call-with-address-of
  input-pointer
  (lambda (address)
    (test-passing-pointer-address input-pointer address)))
(test-equal 42 (c-bytevector-ref input-pointer 'i32 0))
(test-end "call-with-address-of")
