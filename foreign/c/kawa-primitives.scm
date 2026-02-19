(define arena (invoke-static java.lang.foreign.Arena 'global))
(define method-handle-lookup (invoke-static java.lang.invoke.MethodHandles 'lookup))
(define native-linker (invoke-static java.lang.foreign.Linker 'nativeLinker))
(define INTEGER-MAX-VALUE (static-field java.lang.Integer 'MAX_VALUE))

(define value->object
  (lambda (value type)
    (cond ((equal? type 'byte)
           (java.lang.Byte value))
          ((equal? type 'i8)
           (java.lang.Integer value))
          ((equal? type 'u8)
           (java.lang.Integer value))
          ((equal? type 'short)
           (java.lang.Short value))
          ((equal? type 'unsigned-short)
           (java.lang.Short value))
          ((equal? type 'int)
           (java.lang.Integer value))
          ((equal? type 'unsigned-int)
           (java.lang.Integer value))
          ((equal? type 'long)
           (java.lang.Long value))
          ((equal? type 'unsigned-long)
           (java.lang.Long value))
          ((equal? type 'float)
           (java.lang.Float value))
          ((equal? type 'double)
           (java.lang.Double value))
          ((equal? type 'char)
           (java.lang.Char value))
          (else value))))

(define type->native-type
  (lambda (type)
    (cond
      ((equal? type 'i8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 1))
      ((equal? type 'u8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE) 'withByteAlignment 1))
      ((equal? type 'i16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'u16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'i32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'u32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'i64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'u64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'char) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR) 'withByteAlignment 1))
      ((equal? type 'uchar) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR) 'withByteAlignment 1))
      ((equal? type 'short) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'ushort) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'int) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'uint) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'long) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'ulong) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'float) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_FLOAT) 'withByteAlignment 4))
      ((equal? type 'double) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_DOUBLE) 'withByteAlignment 8))
      ((equal? type 'pointer) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      ((equal? type 'void) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 1))
      ((equal? type 'struct) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      (else #f))))

(define-syntax define-c-procedure
  (syntax-rules ()
    ((_ scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda vals
         (let ((result (invoke (invoke (cdr (assoc 'linker shared-object))
                                       'downcallHandle
                                       (invoke (invoke (cdr (assoc 'lookup shared-object))
                                                       'find
                                                       (symbol->string c-name))
                                               'orElseThrow)
                                       (if (equal? return-type 'void)
                                         (apply (class-methods java.lang.foreign.FunctionDescriptor 'ofVoid)
                                                (map type->native-type argument-types))
                                         (apply (class-methods java.lang.foreign.FunctionDescriptor 'of)
                                                (type->native-type return-type)
                                                (map type->native-type argument-types))))
                               'invokeWithArguments
                               (map value->object (map value->native-value vals) argument-types))))
           (if (equal? return-type 'pointer)
             (internal-make-c-bytevector result)
             result)))))))

(define size-of-type
  (lambda (type)
    (let ((native-type (type->native-type type)))
      (if native-type
        (invoke native-type 'byteAlignment)
        #f))))

(define align-of-type
  (lambda (type)
    (let ((native-type (type->native-type type)))
      (if native-type
        (invoke native-type 'byteAlignment)
        #f))))

(define shared-object-load
  (lambda (path options)
    (let* ((library-file (make java.io.File path))
           (file-name (invoke library-file 'getName))
           (library-parent-folder (make java.io.File (invoke library-file 'getParent)))
           (absolute-path (string-append (invoke library-parent-folder 'getCanonicalPath)
                                         "/"
                                         file-name))
           (linker (invoke-static java.lang.foreign.Linker 'nativeLinker))
           (lookup (invoke-static java.lang.foreign.SymbolLookup
                                  'libraryLookup
                                  absolute-path
                                  arena)))
      (list (cons 'linker linker)
            (cons 'lookup lookup)))))

(define u8-value-layout
  (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE)
          'withByteAlignment
          1))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    (invoke (invoke c-bytevector 'reinterpret INTEGER-MAX-VALUE)
            'set
            u8-value-layout
            k
            byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (invoke (java.lang.Byte 1)
            'toUnsignedInt
            (invoke
              (invoke c-bytevector 'reinterpret INTEGER-MAX-VALUE)
              'get
              u8-value-layout
              k))))

(define pointer-value-layout
  (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS)
          'withByteAlignment
          8))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (invoke (invoke c-bytevector 'reinterpret INTEGER-MAX-VALUE)
            'set
            pointer-value-layout
            k
            pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (invoke (invoke c-bytevector 'reinterpret INTEGER-MAX-VALUE)
            'get
            pointer-value-layout
            k)))

(define (c-null)
  (invoke-static java.lang.foreign.MemorySegment 'ofAddress 0))

(define (c-null? pointer)
  (equal? (invoke-static java.lang.foreign.MemorySegment 'ofAddress 0) pointer))
