(require 'std-ffi)
;(require "Standard/foreign-stdlib")
;(require "Lib/Common/system-interface")

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
          ((eq? type 'pointer) 4)
          ((eq? type 'void) 0)
          ((eq? type 'callback) 4)
          (else (error "Can not get size of unknown type" type)))))

(define c-malloc (foreign-procedure "malloc" '(int) 'void*))
;(define c-malloc (stdlib/malloc rtd-void*))
#;(define pffi-pointer-allocate
  (lambda (size)
    (c-malloc size)))

#;(define c-free (foreign-procedure "free" '(void*) 'int))
;(define c-malloc (stdlib/malloc rtd-void*))
#;(define pffi-pointer-free
  (lambda (pointer)
    (c-free pointer)))

(define pffi-pointer-null (lambda () 0))

(define pffi-pointer-null?
  (lambda (object)
    (and (number? object)
         (= object 0))))

(define pffi-pointer?
  (lambda (object)
    ;(void*? object)
    (number? object)
    ))

(define pffi-pointer-address
  (lambda (pointer)
    ;(void*->address pointer)
    pointer
    ))

(define pffi-pointer->string
  (lambda (pointer)
    ;(char*->string pointer)
    pointer
    ))

(define pffi-string->pointer
  (lambda (string-content)
    ;(string->char* string-content)
    string-content
    ))

(define pffi-shared-object-load
  (lambda (headers path . options)
    (foreign-file path)))


(define pffi-pointer-set!
  (lambda (pointer type offset value)
    0
    #;(cond ((equal? type 'int8) (%poke8 (+ pointer offset) value))
          ((equal? type 'uint8) (%poke8u (+ pointer offset) value))
          ((equal? type 'int16) (%poke16 (+ pointer offset) value))
          ((equal? type 'uint16) (%poke16u (+ pointer offset) value))
          ((equal? type 'int32) (%poke32 (+ pointer offset) value))
          ((equal? type 'uint32) (%poke32u (+ pointer offset) value))
          ;((equal? type 'int64) (%poke64 (+ pointer offset) value))
          ;((equal? type 'uint64) (%poke64u (+ pointer offset) value))
          ((equal? type 'char) (%poke8 (+ pointer offset) value))
          ((equal? type 'short) (%poke-short (+ pointer offset) value))
          ((equal? type 'unsigned-short) (%poke-ushort (+ pointer offset) value))
          ((equal? type 'int) (%poke-int (+ pointer offset) value))
          ((equal? type 'unsigned-int) (%poke-uint (+ pointer offset) value))
          ((equal? type 'long) (%poke-long (+ pointer offset) value))
          ((equal? type 'unsigned-long) (%poke-ulong (+ pointer offset) value))
          ;((equal? type 'float) (%poke-ulong (+ pointer offset) value))
          ;((equal? type 'double) (pointer-set-c-double! pointer offset value))
          ((equal? type 'void) (%poke-pointer (+ pointer offset) value))
          ((equal? type 'pointer) (%poke-pointer (+ pointer offset) value)))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    0
    #;(cond ((equal? type 'int8) (%peek8 (+ pointer offset)))
          ((equal? type 'uint8) (%peek8u (+ pointer offset)))
          ((equal? type 'int16) (%peek16 (+ pointer offset)))
          ((equal? type 'uint16) (%peek16u (+ pointer offset)))
          ((equal? type 'int32) (%peek32 (+ pointer offset)))
          ((equal? type 'uint32) (%peek32u (+ pointer offset)))
          ;((equal? type 'int64) (%peek64 (+ pointer offset)))
          ;((equal? type 'uint64) (%peek64u (+ pointer offset)))
          ((equal? type 'char) (%peek8 (+ pointer offset)))
          ((equal? type 'short) (%peek-short (+ pointer offset)))
          ((equal? type 'unsigned-short) (%peek-ushort (+ pointer offset)))
          ((equal? type 'int) (%peek-int (+ pointer offset)))
          ((equal? type 'unsigned-int) (%peek-uint (+ pointer offset)))
          ((equal? type 'long) (%peek-long (+ pointer offset)))
          ((equal? type 'unsigned-long) (%peek-ulong (+ pointer offset)))
          ;((equal? type 'float) (%peek-ulong (+ pointer offset)))
          ;((equal? type 'double) (pointer-set-c-double! pointer offset))
          ((equal? type 'void) (%peek-pointer (+ pointer offset)))
          ((equal? type 'pointer) (%peek-pointer (+ pointer offset))))))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       0

       #;(make-c-function shared-object
                        (symbol->string c-name)
                        return-type
                        argument-types)))))

(define-syntax pffi-define-callback
  (syntax-rules ()
    ((pffi-define scheme-name return-type argument-types procedure)
     (define scheme-name
       0
       #;(make-c-callback return-type argument-types procedure)))))
