
(define arena (invoke-static java.lang.foreign.Arena 'global))

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
      ;((equal? type 'int8) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'uint8) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 1))
      ;((equal? type 'uint8) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'int16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ;((equal? type 'int16) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'uint16) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 2))
      ;((equal? type 'uint16) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'int32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ;((equal? type 'int32) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'uint32) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 4))
      ;((equal? type 'uint32) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'int64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ;((equal? type 'int64) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'uint64) (invoke (static-field java.lang.foreign.ValueLayout 'JAVA_INT) 'withByteAlignment 8))
      ;((equal? type 'uint64) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'char) (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR))
      ((equal? type 'unsigned-char) (static-field java.lang.foreign.ValueLayout 'JAVA_CHAR))
      ((equal? type 'short) (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT))
      ((equal? type 'unsigned-short) (static-field java.lang.foreign.ValueLayout 'JAVA_SHORT))
      ((equal? type 'int) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'unsigned-int) (static-field java.lang.foreign.ValueLayout 'JAVA_INT))
      ((equal? type 'long) (static-field java.lang.foreign.ValueLayout 'JAVA_LONG))
      ((equal? type 'unsigned-long) (static-field java.lang.foreign.ValueLayout 'JAVA_LONG))
      ((equal? type 'float) (static-field java.lang.foreign.ValueLayout 'JAVA_FLOAT))
      ((equal? type 'double) (static-field java.lang.foreign.ValueLayout 'JAVA_DOUBLE))
      ((equal? type 'pointer) (static-field java.lang.foreign.ValueLayout 'ADDRESS))
      ((equal? type 'string) (static-field java.lang.foreign.ValueLayout 'ADDRESS))
      ((equal? type 'void) (static-field java.lang.foreign.ValueLayout 'ADDRESS))
      (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define pffi-pointer?
  (lambda (object)
    (string=? (invoke (invoke object 'getClass) 'getName)
              "jdk.internal.foreign.NativeMemorySegmentImpl")))

(define-syntax pffi-define
  (syntax-rules ()
    ((pffi-define scheme-name shared-object c-name return-type argument-types)
     (define scheme-name
       (let* ((of-void (class-methods java.lang.foreign.FunctionDescriptor 'ofVoid))
              (of (class-methods java.lang.foreign.FunctionDescriptor 'of))
              (function-descriptor (if (equal? return-type 'void)
                                     (apply of-void (map pffi-type->native-type argument-types))
                                     (apply of (append (list (pffi-type->native-type return-type)) (map pffi-type->native-type argument-types)))))
              (method-handle (invoke (cdr (assoc 'linker shared-object))
                                     'downcallHandle
                                     (invoke (invoke (cdr (assoc 'lookup shared-object))
                                                     'find
                                                     (symbol->string c-name))
                                             'orElseThrow)
                                     function-descriptor)))
         (lambda vals
           (invoke method-handle 'invokeWithArguments (map value->object vals argument-types))))))))



(define pffi-size-of
  (lambda (type)
    (invoke (pffi-type->native-type type) 'byteAlignment)))

(define pffi-pointer-allocate
  (lambda (size)
    (invoke arena 'allocate size 1)))

(define pffi-pointer-null
  (lambda ()
    (static-field java.lang.foreign.MemorySegment 'NULL)))

(define pffi-string->pointer
  (lambda (string-content)
    (invoke arena 'allocateUtf8String string-content)))

(define pffi-pointer->string
  (lambda (pointer)
    (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE)) 'getUtf8String 0)))

(define pffi-shared-object-load
  (lambda (header path)
    (let* ((library-file (make java.io.File path))
           (file-name (invoke library-file 'getName))
           (library-parent-folder (make java.io.File (invoke library-file 'getParent)))
           (absolute-path (string-append (invoke library-parent-folder 'getCanonicalPath)
                                         "/"
                                         file-name))
           ;(set! arena (invoke-static java.lang.foreign.Arena 'ofConfined))

           (linker (invoke-static java.lang.foreign.Linker 'nativeLinker))
           (lookup (invoke-static java.lang.foreign.SymbolLookup
                                  'libraryLookup
                                  absolute-path
                                  arena)))
      (list (cons 'linker linker)
            (cons 'lookup lookup)))))

(define pffi-pointer-free
  (lambda (pointer)
    (invoke pointer 'unload)))

(define pffi-pointer-null?
  (lambda (pointer)
    (invoke pointer 'equals (pffi-pointer-null))))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (invoke pointer 'set (pffi-type->native-type type) offset value)))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (invoke pointer 'get (pffi-type->native-type type) offset)))

(define pffi-pointer-deref
  (lambda (pointer)
    (invoke pointer 'get (static-field java.lang.foreign.ValueLayout 'ADDRESS) 0)))
