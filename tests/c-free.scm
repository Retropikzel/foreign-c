(test-begin "c-free")

(define to-be-freed-pointer (make-c-bytevector 64))

(c-free to-be-freed-pointer)

(test-end "c-free")
