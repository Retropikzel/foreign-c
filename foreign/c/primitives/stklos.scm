(define type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) :char)
          ((equal? type 'uint8) :char)
          ((equal? type 'int16) :short)
          ((equal? type 'uint16) :ushort)
          ((equal? type 'int32) :int)
          ((equal? type 'uint32) :uint)
          ((equal? type 'int64) :long)
          ((equal? type 'uint64) :ulong)
          ((equal? type 'char) :char)
          ((equal? type 'unsigned-char) :uchar)
          ((equal? type 'short) :short)
          ((equal? type 'unsigned-short) :ushort)
          ((equal? type 'int) :int)
          ((equal? type 'unsigned-int) :uint)
          ((equal? type 'long) :long)
          ((equal? type 'unsigned-long) :ulong)
          ((equal? type 'float) :float)
          ((equal? type 'double) :double)
          ((equal? type 'pointer) :pointer)
          ((equal? type 'void) :void)
          ((equal? type 'callback) :pointer)
          (else (error "type->native-type -- No such pffi type" type)))))

(define c-bytevector?
  (lambda (object)
    (cpointer? object)))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (begin
       (define type->native-type
         (lambda (type)
           (cond ((equal? type 'int8) :char)
                 ((equal? type 'uint8) :char)
                 ((equal? type 'int16) :short)
                 ((equal? type 'uint16) :ushort)
                 ((equal? type 'int32) :int)
                 ((equal? type 'uint32) :uint)
                 ((equal? type 'int64) :long)
                 ((equal? type 'uint64) :ulong)
                 ((equal? type 'char) :char)
                 ((equal? type 'unsigned-char) :char)
                 ((equal? type 'short) :short)
                 ((equal? type 'unsigned-short) :ushort)
                 ((equal? type 'int) :int)
                 ((equal? type 'unsigned-int) :uint)
                 ((equal? type 'long) :long)
                 ((equal? type 'unsigned-long) :ulong)
                 ((equal? type 'float) :float)
                 ((equal? type 'double) :double)
                 ((equal? type 'pointer) :pointer)
                 ((equal? type 'void) :void)
                 ((equal? type 'callback) :pointer)
                 (else (error "type->native-type -- No such pffi type" type)))))
       (define scheme-name
         (make-external-function
           (symbol->string c-name)
           (map type->native-type argument-types)
           (type->native-type return-type)
           shared-object))))))

(define-syntax define-c-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (%make-callback procedure
                       (map type->native-type argument-types)
                       (type->native-type return-type))))))

; FIXME
(define size-of-type
  (lambda (type)
    (cond ((equal? type 'int8) 1)
          ((equal? type 'uint8) 1)
          ((equal? type 'int16) 2)
          ((equal? type 'uint16) 2)
          ((equal? type 'int32) 4)
          ((equal? type 'uint32) 4)
          ((equal? type 'int64) 8)
          ((equal? type 'uint64) 8)
          ((equal? type 'char) 1)
          ((equal? type 'unsigned-char) 1)
          ((equal? type 'short) 2)
          ((equal? type 'unsigned-short) 2)
          ((equal? type 'int) 4)
          ((equal? type 'unsigned-int) 4)
          ((equal? type 'long) 8)
          ((equal? type 'unsigned-long) 8)
          ((equal? type 'float) 4)
          ((equal? type 'double) 8)
          ((equal? type 'pointer) 8))))

(define c-bytevector-u8-set!
  (lambda (pointer offset value)
  (cpointer-set! pointer :uint8 value offset)))

(define c-bytevector-u8-ref
  (lambda (pointer offset)
    (cpointer-ref pointer :uint8 offset)))

(define c-bytevector-pointer-set!
  (lambda (pointer offset value)
    (cpointer-set! pointer :pointer value offset)))

(define c-bytevector-pointer-ref
  (lambda (pointer offset)
    (cpointer-ref pointer :pointer offset)))
