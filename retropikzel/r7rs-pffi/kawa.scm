
(define arena (invoke-static java.lang.foreign.Arena 'global))
(define method-handle-lookup (invoke-static java.lang.invoke.MethodHandles 'lookup))
(define native-linker (invoke-static java.lang.foreign.Linker 'nativeLinker))

(define value->object
  (lambda (value type)
    (cond ((equal? type 'byte)
           (java.lang.Byte value))
          ((equal? type 'short)
           (java.lang.Short value))
          ((equal? type 'int)
           (java.lang.Integer value))
          ((equal? type 'long)
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
      ((equal? type 'int8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 1))
      ((equal? type 'uint8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 1))
      ((equal? type 'int16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'uint16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ((equal? type 'int32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'uint32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'int64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'uint64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ((equal? type 'char) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR) 'withByteAlignment 1))
      ((equal? type 'unsigned-char) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR) 'withByteAlignment 1))
      ((equal? type 'short) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'unsigned-short) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT) 'withByteAlignment 2))
      ((equal? type 'int) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'unsigned-int) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ((equal? type 'long) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'unsigned-long) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_LONG) 'withByteAlignment 8))
      ((equal? type 'float) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_FLOAT) 'withByteAlignment 4))
      ((equal? type 'double) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_DOUBLE) 'withByteAlignment 8))
      ((equal? type 'pointer) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 8))
      ((equal? type 'void) (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 1))
      ((equal? type 'callback) (static-field java.lang.foreign.ValueLayout 'ADDRESS))
      (else (error "pffi-type->native-type -- No such pffi type" type)))))

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
       (let* ((helper-object (object () (callback procedure)))
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
                  function-descriptor))
              (method-type
                (let ((method-type (invoke-static java.lang.invoke.MethodType
                                                  'methodType
                                                  (invoke int 'getClass)
                                                  (invoke java.lang.foreign.MemorySegment 'getClass)
                                                  (invoke java.lang.foreign.MemorySegment 'getClass)
                                                  )))
                  (write method-type)
                  (newline)
                  method-type))
              (method-handle
                (let ((method-handle
                        (invoke method-handle-lookup
                                'unreflect
                                ((invoke (invoke helper-object 'getClass) 'getMethods) 0))))
                  (invoke method-handle-lookup 'revealDirect method-handle)
                  (set! method-handle (invoke method-handle 'asType method-type))
                  (write method-handle)
                  (newline)
                  method-handle)))
         (invoke native-linker
                 'upcallStub
                 method-handle
                 function-descriptor
                 arena))))))

(define-syntax pffi-define-callback-old
  (syntax-rules ()
    ((_ scheme-name return-type argument-types procedure)
     (define scheme-name
       (invoke-static java.lang.invoke.MethodType 'genericMethodType (length argument-types))
       ))))

(define pffi-size-of
  (lambda (type)
    (invoke (pffi-type->native-type type) 'byteAlignment)))

(define pffi-pointer-allocate
  (lambda (size)
    (invoke (invoke arena 'allocate size 1) 'reinterpret (static-field java.lang.Integer 'MAX_VALUE))))

(define pffi-pointer-null
  (lambda ()
    (static-field java.lang.foreign.MemorySegment 'NULL)))

(define pffi-string->pointer
  (lambda (string-content)
    (invoke (invoke arena 'allocateFrom string-content) 'reinterpret (static-field java.lang.Integer 'MAX_VALUE))))

(define pffi-pointer->string
  (lambda (pointer)
    (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE)) 'getString 0)))

(define pffi-shared-object-load
  (lambda (header path)
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

(define pffi-pointer-free
  (lambda (pointer)
    #t))

(define pffi-pointer-null?
  (lambda (pointer)
    (invoke pointer 'equals (pffi-pointer-null))))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (invoke (invoke pointer
                    'reinterpret
                    (static-field java.lang.Integer 'MAX_VALUE))
            'set
            (invoke (pffi-type->native-type type) 'withByteAlignment 1)
            offset
            value)))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (invoke (invoke pointer
                    'reinterpret
                    (static-field java.lang.Integer 'MAX_VALUE))
            'get
            (invoke (pffi-type->native-type type) 'withByteAlignment 1)
            offset)))

(define pffi-pointer-deref
  (lambda (pointer)
    (invoke pointer 'get (invoke (static-field java.lang.foreign.ValueLayout 'ADDRESS) 'withByteAlignment 1) 0)))

