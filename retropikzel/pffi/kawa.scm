(define arena (invoke-static java.lang.foreign.Arena 'global))
(define method-handle-lookup (invoke-static java.lang.invoke.MethodHandles 'lookup))
(define native-linker (invoke-static java.lang.foreign.Linker 'nativeLinker))

(define value->object
  (lambda (value type)
    (cond ((equal? type 'byte)
           (java.lang.Byte value))
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

(define pffi-type->native-type
  (lambda (type)
    (cond
      ((equal? type 'int8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE) 'withByteAlignment 1))
      ((equal? type 'uint8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE) 'withByteAlignment 1))
      ((equal? type 'int16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'uint16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'int32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'uint32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'int64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'uint64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'char) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE) 'withByteAlignment 1))
      ((equal? type 'unsigned-char) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_BYTE) 'withByteAlignment 1))
      ((equal? type 'short) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'unsigned-short) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'int) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'unsigned-int) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'long) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'unsigned-long) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'float) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_FLOAT) 'withByteAlignment 4))
      ((equal? type 'double) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_DOUBLE) 'withByteAlignment 8))
      ((equal? type 'pointer) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      ((equal? type 'string) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      ((equal? type 'void) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 1))
      ((equal? type 'callback) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      ((equal? type 'struct) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      (else #f))))

(define pffi-pointer?
  (lambda (object)
    (string=? (invoke (invoke object 'getClass) 'getName)
              "jdk.internal.foreign.NativeMemorySegmentImpl")))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (lambda vals
         (invoke (invoke (cdr (assoc 'linker shared-object))
                         'downcallHandle
                         (invoke (invoke (cdr (assoc 'lookup shared-object))
                                         'find
                                         (symbol->string c-name))
                                 'orElseThrow)
                         (if (equal? return-type 'void)
                           (apply (class-methods java.lang.foreign.FunctionDescriptor 'ofVoid)
                                  (map pffi-type->native-type argument-types))
                           (apply (class-methods java.lang.foreign.FunctionDescriptor 'of)
                                  (pffi-type->native-type return-type)
                                  (map pffi-type->native-type argument-types))))
                 'invokeWithArguments
                 (map value->object vals argument-types)))))))

(define range
  (lambda (from to)
    (letrec*
      ((looper
         (lambda (count result)
           (if (= count to)
             (append result (list count))
             (looper (+ count 1) (append result (list count)))))))
      (looper from (list)))))

(define-syntax pffi-define-callback
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (let* ((callback-procedure
                (lambda (arg1 . args)
                  (try-catch
                    (begin
                      (apply procedure (append (list arg1) args)))
                    (ex <java.lang.Throwable>
                        #f))))
              (function-descriptor
                (let ((function-descriptor
                        (if (equal? return-type 'void)
                          (apply (class-methods java.lang.foreign.FunctionDescriptor 'ofVoid)
                                 (map pffi-type->native-type argument-types))
                          (apply (class-methods java.lang.foreign.FunctionDescriptor 'of)
                                 (pffi-type->native-type return-type)
                                 (map pffi-type->native-type argument-types)))))
                  (write function-descriptor)
                  (newline)
                  (write (invoke function-descriptor 'getClass))
                  (newline)
                  (write function-descriptor)
                  (newline)
                  function-descriptor))
              ;(method-type (invoke function-descriptor 'toMethodType))
              (method-type (field callback-procedure 'applyMethodType))
              (method-handle
                (let* ((method-handle (field callback-procedure 'applyToConsumerDefault)))
                  (write method-handle)
                  (newline)
                  method-handle)))
         (invoke native-linker 'upcallStub method-handle function-descriptor arena))))))

(define size-of-type
  (lambda (type)
    (let ((native-type (pffi-type->native-type type)))
      (if native-type
        (invoke native-type 'byteAlignment)
        #f))))

#;(define pffi-pointer-allocate
  (lambda (size)
    (invoke (invoke arena 'allocate size 1) 'reinterpret size)))

(define pffi-pointer-address
  (lambda (pointer)
    (invoke pointer 'address)))

(define pffi-pointer-null
  (lambda ()
    (static-field java.lang.foreign.MemorySegment 'NULL)))

#;(define pffi-string->pointer
  (lambda (string-content)
    (let ((size (+ (invoke string-content 'length) 1)))
      (invoke (invoke arena 'allocateFrom (invoke string-content 'toString))
              'reinterpret size))))

#;(define pffi-pointer->string
  (lambda (pointer)
    (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE)) 'getString 0)))

(define pffi-shared-object-load
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

#;(define pffi-pointer-free
  (lambda (pointer)
    #t))

(define pffi-pointer-null?
  (lambda (pointer)
    (invoke pointer 'equals (pffi-pointer-null))))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE))
            'set
            (pffi-type->native-type type)
            offset
            (if (equal? type 'char)
              (char->integer value)
              value))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (let ((r (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE))
                     'get
                     (pffi-type->native-type type)
                     offset)))
      (if (equal? type 'char)
        (integer->char r)
        r))))

#;(define pffi-struct-dereference
  (lambda (struct)
    ;; WIP
    (pffi-struct-pointer struct)
    #;(invoke (pffi-struct-pointer struct) 'reinterpret (static-field java.lang.Integer 'MAX_VALUE))
    #;(invoke (pffi-struct-pointer struct)
            'get
            (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 1)
            0)))
