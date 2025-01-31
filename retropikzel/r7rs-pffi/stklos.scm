(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) :int)
          ((equal? type 'uint8) :uint)
          ((equal? type 'int16) :int)
          ((equal? type 'uint16) :uint)
          ((equal? type 'int32) :int)
          ((equal? type 'uint32) :uint)
          ((equal? type 'int64) :int)
          ((equal? type 'uint64) :uint)
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
          ((equal? type 'string) :string)
          ((equal? type 'void) :void)
          ((equal? type 'struct) :void)
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define pffi-pointer?
  (lambda (object)
    (cpointer? object)))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (make-external-function
         (symbol->string c-name)
         (map pffi-type->native-type argument-types)
         (pffi-type->native-type return-type)
         shared-object)))))

(define pffi-define-callback
  (lambda ()
    (error "Not implemented")))

; If youre reading this, this is just a temp hack. Dont judge me :D
(define pffi-size-of
  (lambda (type)
    (cond
      ((equal? type 'int8) 1)
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
      ((equal? type 'pointer) 8)

      )))

(define pffi-pointer-allocate
  (lambda (size)
    (allocate-bytes size)))

(define pffi-pointer-null
  (lambda ()
    (let ((p (allocate-bytes 0)))
      (free-bytes p)
      p)))

(define pffi-string->pointer
  (lambda (string-content)
    string-content))

(define pffi-pointer->string
  (lambda (pointer)
    (if (string? pointer)
      pointer
      (cpointer->string pointer))))

(define pffi-shared-object-load
  (lambda (header path)
    path))

(define pffi-pointer-free
  (lambda (pointer)
    (free-bytes pointer)))

(define pffi-pointer-null?
  (lambda (pointer)
    (and (cpointer? pointer)
         (cpointer-null? pointer))))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (error "Not implemented")))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (error "Not implemented")))

(define pffi-pointer-address
  (lambda (pointer)
    (error "Not implemented")))

