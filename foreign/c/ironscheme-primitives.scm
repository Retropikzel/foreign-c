(define RTLD-NOW 2)

(clr-using System.Runtime.InteropServices)

(define (type->native-type scheme-name type argument?)
  (cond ((equal? type 'i8) 'int8)
        ((equal? type 'u8) 'uint8)
        ((equal? type 'i16) 'int16)
        ((equal? type 'u16) 'uint16)
        ((equal? type 'i32) 'int32)
        ((equal? type 'u32) 'uint32)
        ((equal? type 'i64) 'in64)
        ((equal? type 'u64) 'uint64)
        ((equal? type 'char) 'char)
        ((equal? type 'uchar) 'uchar)
        ((equal? type 'short) 'int16)
        ((equal? type 'ushort) 'uint16)
        ((equal? type 'int) 'int32)
        ((equal? type 'uint) 'uint32)
        ((equal? type 'long) 'int64)
        ((equal? type 'ulong) 'uint64)
        ((equal? type 'float) 'float)
        ((equal? type 'double) 'double)
        ((equal? type 'void) 'void)
        ((equal? type 'pointer) 'intptr)
        ((equal? type 'array) 'intptr)
        ((equal? type 'struct) 'intptr)
        ((equal? type 'void)
         (if argument?
           (error "define-c-procedure: Argument type can not be void" scheme-name type)
           'void))
        (else
          (if argument?
            (error "define-c-procedure: Invalid argument type" scheme-name type)
            (error "define-c-procedure: Invalid return type" scheme-name type)))
        ))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda args
         (let ((internal
                 ((make-ffi-callout (type->native-type scheme-name return-type #f)
                                    (map (lambda (type)
                                           (type->native-type scheme-name type #t))
                                         argument-types))
                  (cond-expand
                    (windows (dlsym shared-object (symbol->string c-name)))
                    (else (apply (pinvoke-call libc dlsym intptr (intptr string))
                                 (list shared-object (symbol->string c-name))))))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector (apply internal (map argument->native-value args)))
             (apply internal (map argument->native-value args)))))))))

(define shared-object-load
  (lambda (path options)
    (let ((shared-object
            (cond-expand
              (windows (dlopen path))
              (else (apply (pinvoke-call libc dlopen intptr (string int))
                           (list path RTLD-NOW))))))
      (when (null-pointer? shared-object)
        (apply (pinvoke-call libc perror void (string))
               '("Failed to load shared-object: "))
        (error "Failed to load shared-object" path))
      shared-object)))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    (clr-static-call Marshal
                     (WriteByte IntPtr Int32 Byte)
                     c-bytevector
                     k
                     (clr-static-call Convert (ToByte Int32) byte))))

(define c-u8-ref
  (lambda (c-bytevector k)
    (clr-static-call Convert
                     (ToInt32 Byte)
                     (clr-static-call Marshal (ReadByte IntPtr Int32) c-bytevector k))))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (write-intptr! c-bytevector k pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (read-intptr c-bytevector k)))

(define (c-null) (c-memset-address->pointer 0 0 0))
(define (c-null? pointer)
  (and (pointer? pointer)
       (null-pointer? pointer)))
