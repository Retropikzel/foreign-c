(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let* ((type->native-type
                  (lambda (type argument?)
                    (cond ((equal? type 'i8) :char)
                          ((equal? type 'u8) :char)
                          ((equal? type 'i16) :short)
                          ((equal? type 'u16) :ushort)
                          ((equal? type 'i32) :int)
                          ((equal? type 'u32) :uint)
                          ((equal? type 'i64) :long)
                          ((equal? type 'u64) :ulong)
                          ((equal? type 'char) :char)
                          ((equal? type 'uchar) :char)
                          ((equal? type 'short) :short)
                          ((equal? type 'ushort) :ushort)
                          ((equal? type 'int) :int)
                          ((equal? type 'uint) :uint)
                          ((equal? type 'long) :long)
                          ((equal? type 'ulong) :ulong)
                          ((equal? type 'float) :float)
                          ((equal? type 'double) :double)
                          ((equal? type 'pointer) :pointer)
                          ((equal? type 'array) :pointer)
                          ((equal? type 'struct) :pointer)
                          ((equal? type 'void)
                           (if argument?
                             (error "define-c-procedure: Argument type can not be void" scheme-name type)
                             :void))
                          (else
                            (if argument?
                              (error "define-c-procedure: Invalid argument type" scheme-name type)
                              (error "define-c-procedure: Invalid return type" scheme-name type)))
                          )))
                (internal
                  (make-external-function (symbol->string c-name)
                                          (map (lambda (type)
                                                 (type->native-type type #t))
                                               argument-types)
                                          (type->native-type return-type #f)
                                          shared-object)))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define (shared-object-load path options) path)

(define c-u8-set!
  (lambda (pointer offset value)
    (cpointer-set-abs! pointer :uint8 value offset)))

(define c-u8-ref
  (lambda (pointer offset)
    (cpointer-ref-abs pointer :uint8 offset)))

(define c-pointer-set!
  (lambda (pointer offset value)
    (cpointer-set-abs! pointer :pointer value offset)))

(define c-pointer-ref
  (lambda (pointer offset)
    (cpointer-ref-abs pointer :pointer offset)))

(define-external stklos-address->pointer
                 ((a :uint64) (b :uint8) (c :int))
                 :return-type :pointer
                 :entry-name "memset")

(define (c-null) (stklos-address->pointer 0 0 0))
(define (c-null? pointer) (or (void? pointer) (cpointer-null? pointer)))
