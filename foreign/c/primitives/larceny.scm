(require 'std-ffi)
(require 'ffi-load)
(require 'foreign-ctools)
(require 'foreign-cenums)
(require 'foreign-stdlib)
(require 'foreign-sugar)
(require 'system-interface)

;; FIXME
(define size-of-type
  (lambda (type)
    (cond ((eq? type 'int8) 1)
          ((eq? type 'uint8) 1)
          ((eq? type 'int16) 2)
          ((eq? type 'uint16) 2)
          ((eq? type 'int32) 4)
          ((eq? type 'uint32) 4)
          ((eq? type 'int64) 8)
          ((eq? type 'uint64) 8)
          ((eq? type 'char) 1)
          ((eq? type 'unsigned-char) 1)
          ((eq? type 'short) 2)
          ((eq? type 'unsigned-short) 2)
          ((eq? type 'int) 4)
          ((eq? type 'unsigned-int) 4)
          ((eq? type 'long) 4)
          ((eq? type 'unsigned-long) 4)
          ((eq? type 'float) 4)
          ((eq? type 'double) 8)
          ((eq? type 'pointer) sizeof:pointer)
          ((eq? type 'void) 0)
          ((eq? type 'callback) sizeof:pointer)
          (else (error "Can not get size of unknown type" type)))))

(define c-bytevector?
  (lambda (object)
    ;(void*? object)
    (number? object)))

(define shared-object-load
  (lambda (headers path . options)
    (foreign-file path)))

(define c-bytevector-u8-set!
  (lambda (c-bytevector k byte)
    (syscall syscall:poke-bytes c-bytevector k (c-type-size 'uint8) byte)))

(define c-bytevector-u8-ref
  (lambda (c-bytevector k)
    (syscall syscall:peek-bytes c-bytevector k (c-type-size 'uint8))))

(define c-bytevector-pointer-set!
  (lambda (c-bytevector k pointer)
    (syscall syscall:poke-bytes c-bytevector k (c-type-size 'pointer) pointer)))

(define c-bytevector-pointer-ref
  (lambda (c-bytevector k)
    (syscall syscall:peek-bytes c-bytevector k (c-type-size 'pointer))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       0

       #;(make-c-function shared-object
                        (symbol->string c-name)
                        return-type
                        argument-types)))))

(define-syntax define-c-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       0
       #;(make-c-callback return-type argument-types procedure)))))
