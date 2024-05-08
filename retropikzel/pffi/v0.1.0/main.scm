(define-library
  (retropikzel pffi v0.1.0 main)
  (cond-expand
    (sagittarius
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (sagittarius ffi)
              (sagittarius)))
    (guile
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (rnrs bytevectors)
              (system foreign)
              (system foreign-library)))
    (racket
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (only (racket base) system-type)
              (compatibility mlist)
              (ffi unsafe)))
    (stklos
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)
              (stklos)))
    (kawa
      (import (scheme base)
              (scheme write)
              (scheme file)
              (scheme process-context)))
    (else (error "Implementation not supported by r7rs-pffi")))
  (export pffi-call
          pffi-types
          pffi-size-of
          pffi-pointer-allocate
          pffi-pointer-null
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer->bytevector
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-shared-object-load
          pffi-shared-object-auto-load
          pffi-pointer-set!
          pffi-pointer-get
          pffi-pointer-deref)
  (begin

    (define library-version "v0.1.0")

    (cond-expand
      (sagittarius #t)
      (guile #t)
      (racket #t)
      (stklos #t)
      (kawa
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
                  (else value))))))

    (define platform-file-extension
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so"))
        (windows ".dll")
        (else ".so")))

    (define platform-version-file-extension
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) ".dll" ".so.0"))
        (windows ".dll")
        (else ".so.0")))

    (define platform-lib-prefix
      (cond-expand
        (racket (if (equal? (system-type 'os) 'windows) "" "lib"))
        (windows "")
        (else "lib")))

    (define pffi-types
      '(int8
         uint8
         int16
         uint16
         int32
         uint32
         int64
         uint64
         intptr
         uintptr
         char
         unsigned-char
         short
         unsigned-short
         int
         unsigned-int
         long
         unsigned-long
         float
         double
         pointer))

    (define auto-load-paths
      (append
        (cond-expand
          (windows
            (append
              (if (get-environment-variable "SYSTEM")
                (list (get-environment-variable "SYSTEM"))
                (list))
              (if (get-environment-variable "WINDIR")
                (list (get-environment-variable "WINDIR"))
                (list))
              (list ".")
              (string-split (get-environment-variable "PATH") #\;)))
          (else
            (append
              (list (if (get-environment-variable "GUIX_ENVIRONMENT")
                      (string-append (get-environment-variable "GUIX_ENVIRONMENT") "/lib")
                      ""))
              (if (get-environment-variable "LD_LOAD_PATH")
                (list) ;(string-split (get-environment-variable "LD_LOAD_PATH") #\:)
                (list))
              (list "/lib/x86_64-linux-gnu"
                    "/usr/lib/x86_64-linux-gnu"
                    "/usr/local/lib"))))))

    (define pffi-type->native-type
      (lambda (type)
        (cond-expand
          (sagittarius
            (cond ((equal? type 'int8) 'int8_t)
                  ((equal? type 'uint8) 'uint8_t)
                  ((equal? type 'int16) 'int16_t)
                  ((equal? type 'uint16) 'uint16_t)
                  ((equal? type 'int32) 'int32_t)
                  ((equal? type 'uint32) 'uint32_t)
                  ((equal? type 'int64) 'int64_t)
                  ((equal? type 'uint64) 'uint64_t)
                  ((equal? type 'intptr) 'intptr_t)
                  ((equal? type 'uintptr) 'uintptr_t)
                  ((equal? type 'char) 'char)
                  ((equal? type 'unsigned-char) 'char)
                  ((equal? type 'short) 'short)
                  ((equal? type 'unsigned-short) 'unsigned-short)
                  ((equal? type 'int) 'int)
                  ((equal? type 'unsigned-int) 'unsigned-int)
                  ((equal? type 'long) 'long)
                  ((equal? type 'unsigned-long) 'unsigned-long)
                  ((equal? type 'float) 'float)
                  ((equal? type 'double) 'double)
                  ((equal? type 'pointer) 'void*)
                  ((equal? type 'string) 'void*)
                  ((equal? type 'void) 'void)
                  (else (error "pffi-type->native-type -- No such pffi type" type))))
          (guile
            (cond ((equal? type 'int8) int8)
                  ((equal? type 'uint8) uint8)
                  ((equal? type 'int16) int16)
                  ((equal? type 'uint16) uint16)
                  ((equal? type 'int32) int32)
                  ((equal? type 'uint32) uint32)
                  ((equal? type 'int64) int64)
                  ((equal? type 'uint64) uint64)
                  ;((equal? type 'char) char)
                  ((equal? type 'char) int)
                  ((equal? type 'unsigned-char) int)
                  ((equal? type 'short) short)
                  ((equal? type 'unsigned-short) unsigned-short)
                  ((equal? type 'int) int)
                  ((equal? type 'unsigned-int) unsigned-int)
                  ((equal? type 'long) long)
                  ((equal? type 'unsigned-long) unsigned-long)
                  ((equal? type 'float) float)
                  ((equal? type 'double) double)
                  ((equal? type 'pointer) '*)
                  ((equal? type 'string) '*)
                  ((equal? type 'void) void)
                  (else (error "pffi-type->native-type -- No such pffi type" type))))
          (racket
            (cond ((equal? type 'int8) _int8)
                  ((equal? type 'uint8) _uint8)
                  ((equal? type 'int16) _int16)
                  ((equal? type 'uint16) _uint16)
                  ((equal? type 'int32) _int32)
                  ((equal? type 'uint32) _uint32)
                  ((equal? type 'int64) _int64)
                  ((equal? type 'uint64) _uint64)
                  ;((equal? type 'char) _int32)
                  ((equal? type 'char) _int)
                  ((equal? type 'unsigned-char) _int)
                  ((equal? type 'short) _short)
                  ((equal? type 'unsigned-short) _ushort)
                  ((equal? type 'int) _int)
                  ((equal? type 'unsigned-int) _uint)
                  ((equal? type 'long) _long)
                  ((equal? type 'unsigned-long) _ulong)
                  ((equal? type 'float) _float)
                  ((equal? type 'double) _double)
                  ((equal? type 'pointer) _pointer)
                  ((equal? type 'string) _pointer)
                  ((equal? type 'void) _void)
                  (else (error "pffi-type->native-type -- No such pffi type" type))))
          (sktlos
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
                  (else (error "pffi-type->native-type -- No such pffi type" type))))
          (kawa
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
              (else (error "pffi-type->native-type -- No such pffi type" type)))))))

    (define pffi-pointer?
      (lambda (object)
        (cond-expand
          (sagittarius (pointer? object))
          (guile (pointer? object))
          (racket (cpointer? object))
          (stklos (cpointer? object))
          (kawa  (string=? (invoke (invoke object 'getClass) 'getName)
                           "jdk.internal.foreign.NativeMemorySegmentImpl")))))

    ;> ### pffi-call
    ;>
    ;> Arguments:
    ;>
    ;> - shared-object (object)
    ;>   - Shared object returned by pffi-shared-object-load or pffi-shared-object-auto-load
    ;> - name (symbol)
    ;>   - Name of the C function you want to call
    ;> - type (symbol)
    ;>   - Return type of the C function you want to call
    ;> - arguments (list (cons type value)...)
    ;>   - Arguments you want to pass to the C function as pairs of type and value
    ;>
    ;> Example:
    ;>
    ;> (define sdl2* (pffi-shared-object-auto-load "SDL2" (list))
    ;>
    ;> (pffi-call sdl2* 'SDL_Init 'int '((int . 32)))
    ;>
    ;> (define window* (pffi-call sdl2*
    ;>                           'SDL_CreateWindow
    ;>                           'pointer
    ;>                           (list (cons 'pointer (pffi-string->pointer "Hello"))
    ;>                                 (cons 'int 1)
    ;>                                 (cons 'int 1)
    ;>                                 (cons 'int 400)
    ;>                                 (cons 'int 400)
    ;>                                 (cons 'int 4))
    (define pffi-call
      (lambda (shared-object name type arguments)
        (let ((types (map pffi-type->native-type (map car arguments)))
              (vals (map cdr arguments))
              (native-type (pffi-type->native-type type)))
          (cond-expand
            (sagittarius
              (apply (make-c-function shared-object
                                      (pffi-type->native-type type)
                                      name
                                      types)
                     vals))
            (guile
              (apply
                (foreign-library-function shared-object
                                          (symbol->string name)
                                          #:return-type (pffi-type->native-type type)
                                          #:arg-types types)
                vals))
            (racket
              (apply (get-ffi-obj name
                                  shared-object
                                  (_cprocedure (mlist->list types)
                                               (pffi-type->native-type type)))
                     vals))
            (stklos
              (stklos (apply (make-external-function
                               (symbol->string name)
                               types
                               native-type
                               shared-object)
                             vals)))
            (kawa
              (let* ((of-void (class-methods java.lang.foreign.FunctionDescriptor 'ofVoid))
                     (of (class-methods java.lang.foreign.FunctionDescriptor 'of))
                     (function-descriptor (if (equal? type 'void)
                                            (apply of-void types)
                                            (apply of (append (list native-type) types))))
                     (method-handle (invoke (cdr (assoc 'linker shared-object))
                                            'downcallHandle
                                            (invoke (invoke (cdr (assoc 'lookup shared-object))
                                                            'find
                                                            (symbol->string name))
                                                    'orElseThrow)
                                            function-descriptor))
                     (values-objects (map value->object vals (map car arguments))))
                (invoke method-handle 'invokeWithArguments values-objects)))))))

    (define pffi-size-of
      (lambda (type)
        (cond-expand
          (sagittarius
            (cond ((eq? type 'int8) size-of-int8_t)
                  ((eq? type 'uint8) size-of-uint8_t)
                  ((eq? type 'int16) size-of-int16_t)
                  ((eq? type 'uint16) size-of-uint16_t)
                  ((eq? type 'int32) size-of-int32_t)
                  ((eq? type 'uint32) size-of-uint32_t)
                  ((eq? type 'int64) size-of-int64_t)
                  ((eq? type 'uint64) size-of-uint64_t)
                  ((eq? type 'char) size-of-char)
                  ((eq? type 'unsigned-char) size-of-char)
                  ((eq? type 'short) size-of-short)
                  ((eq? type 'unsigned-short) size-of-unsigned-short)
                  ((eq? type 'int) size-of-int)
                  ((eq? type 'unsigned-int) size-of-unsigned-int)
                  ((eq? type 'long) size-of-long)
                  ((eq? type 'unsigned-long) size-of-unsigned-long)
                  ((eq? type 'float) size-of-float)
                  ((eq? type 'double) size-of-double)
                  ((eq? type 'string) size-of-void*)
                  ((eq? type 'pointer) size-of-void*)
                  (else (error "Can not get size of unknown type" type))))
          (guile (sizeof (pffi-type->native-type type)))
          (racket (ctype-sizeof (pffi-type->native-type type)))
          (stklos 4) ; TODO FIX
          (kawa (invoke (pffi-type->native-type type) 'byteAlignment)))))

    (define pffi-pointer-allocate
      (lambda (size)
        (cond-expand
          (sagittarius (allocate-pointer size))
          (guile (bytevector->pointer (make-bytevector size 0)))
          (racket (malloc size))
          (stklos (allocate-bytes size))
          (kawa (invoke arena 'allocate size 1)))))

    (define pffi-pointer-null
      (lambda ()
        (cond-expand
          (sagittarius (integer->pointer 0))
          (guile (make-pointer 0))
          (racket #f) ; In racket #f is null pointer
          (stklos (let ((p (allocate-bytes 0))) (cpointer-data-set! p 0) p))
          (kawa (static-field java.lang.foreign.MemorySegment 'NULL)))))

    (define pffi-string->pointer
      (lambda (string-content)
        (cond-expand (sagittarius (bytevector->pointer (string->utf8 (string-copy string-content))))
                     (guile (string->pointer string-content))
                     (racket (cast string-content _string _pointer))
                     (stklos string-content)
                     (kawa (invoke arena 'allocateUtf8String string-content)))))

    (define pffi-pointer->string
      (lambda (pointer)
        (cond-expand (sagittarius (pointer->string pointer))
                     (guile (pointer->string pointer))
                     (racket (cast pointer _pointer _string))
                     (stklos (cpointer->string pointer))
                     (kawa (invoke (invoke pointer 'reinterpret (static-field java.lang.Integer 'MAX_VALUE)) 'getUtf8String 0)))))

    (define pffi-pointer->bytevector
      (lambda (pointer size)
        (cond-expand (sagittarius (pointer->bytevector pointer size))
                     (guile (pointer->bytevector pointer size))
                     (racket (cast pointer _pointer _bytes))
                     (stklos (error "Not yet implemented: pffi-pointer->bytevector")) ; TODO FIX
                     (kawa (invoke (invoke pointer 'reinterpret size)
                                   'toArray
                                   (static-field java.lang.foreign.ValueLayout
                                                 'JAVA_BYTE))))))

    (define pffi-shared-object-load
      (lambda (path)
        (cond-expand (sagittarius (open-shared-library path))
                     (guile (load-foreign-library path #:lazy? #f))
                     (racket (ffi-lib path))
                     (stklos path)
                     (kawa
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
                               (cons 'lookup lookup)))))))

    (define pffi-shared-object-auto-load
      (lambda (object-name additional-paths)
        (let* ((paths (append auto-load-paths additional-paths))
               (shared-object #f))
          (for-each
            (lambda (path)
              (if (not shared-object)
                (let ((object-path
                        (string-append path
                                       "/"
                                       object-name
                                       platform-file-extension))
                      (object-version-path
                        (string-append path
                                       "/"
                                       object-name
                                       platform-version-file-extension))
                      (object-lib-path
                        (string-append path
                                       "/"
                                       platform-lib-prefix
                                       object-name
                                       platform-file-extension))
                      (object-version-lib-path
                        (string-append path
                                       "/"
                                       platform-lib-prefix
                                       object-name
                                       platform-version-file-extension)))
                  (cond
                    ((file-exists? object-path)
                     (set! shared-object (pffi-shared-object-load object-path)))
                    ((file-exists? object-version-path)
                     (set! shared-object (pffi-shared-object-load object-version-path)))
                    ((file-exists? object-lib-path)
                     (set! shared-object (pffi-shared-object-load object-lib-path)))
                    ((file-exists? object-version-lib-path)
                     (set! shared-object (pffi-shared-object-load object-version-lib-path)))))))
            paths)
          (if (not shared-object)
            (error "Could not load shared object" object-name)
            shared-object))))

    (define pffi-pointer-free
      (lambda (pointer)
        (cond-expand (sagittarius (c-free pointer))
                     (guile #t)
                     (racket (free pointer))
                     (stklos (free-bytes pointer))
                     (kawa (invoke pointer 'unload)))))

    (define pffi-pointer-null?
      (lambda (pointer)
        (cond-expand (sagittarius (null-pointer? pointer))
                     (guile (null-pointer? pointer))
                     (racket (not pointer)) ; #f is the null pointer on racket
                     (stklos (cpointer-null? pointer))
                     (kawa (invoke pointer 'equals (pffi-pointer-null))))))

    (define pffi-pointer-set!
      (lambda (pointer type offset value)
        (cond-expand
          (sagittarius
            (let ((p pointer))
              (cond ((equal? type 'int8) (pointer-set-c-int8_t! p offset value))
                    ((equal? type 'uint8) (pointer-set-c-uint8_t! p offset value))
                    ((equal? type 'int16) (pointer-set-c-int16_t! p offset value))
                    ((equal? type 'uint16) (pointer-set-c-uint16_t! p offset value))
                    ((equal? type 'int32) (pointer-set-c-int32_t! p offset value))
                    ((equal? type 'uint32) (pointer-set-c-uint32_t! p offset value))
                    ((equal? type 'int64) (pointer-set-c-int64_t! p offset value))
                    ((equal? type 'uint64) (pointer-set-c-uint64_t! p offset value))
                    ((equal? type 'intptr) (pointer-set-c-intptr_t! p offset value))
                    ((equal? type 'uintptr) (pointer-set-c-uintptr_t! p offset value))
                    ((equal? type 'char) (pointer-set-c-char! p offset value))
                    ((equal? type 'short) (pointer-set-c-short! p offset value))
                    ((equal? type 'unsigned-short) (pointer-set-c-unsigned-short! p offset value))
                    ((equal? type 'int) (pointer-set-c-int! p offset value))
                    ((equal? type 'unsigned-int) (pointer-set-c-unsigned-int! p offset value))
                    ((equal? type 'long) (pointer-set-c-long! p offset value))
                    ((equal? type 'unsigned-long) (pointer-set-c-unsigned-long! p offset value))
                    ((equal? type 'float) (pointer-set-c-float! p offset value))
                    ((equal? type 'double) (pointer-set-c-double! p offset value))
                    ((equal? type 'void) (pointer-set-c-void*! p offset value)))))
          (guile (let ((p (pointer->bytevector pointer (+ offset 100)))
                       (native-type (pffi-type->native-type type)))
                   (cond ((equal? native-type int8) (bytevector-s8-set! p offset value))
                         ((equal? native-type uint8) (bytevector-u8-set! p offset value))
                         ((equal? native-type int16) (bytevector-s16-set! p offset value (native-endianness)))
                         ((equal? native-type uint16) (bytevector-u16-set! p offset value (native-endianness)))
                         ((equal? native-type int32) (bytevector-s32-set! p offset value (native-endianness)))
                         ((equal? native-type uint32) (bytevector-u32-set! p offset value (native-endianness)))
                         ((equal? native-type int64) (bytevector-s64-set! p offset value (native-endianness)))
                         ((equal? native-type uint64) (bytevector-u64-set! p offset value (native-endianness)))
                         ;((equal? native-type 'intptr_t) (pointer-ref-c-intptr_t p offset))
                         ;((equal? native-type 'uintptr_t) (pointer-ref-c-uintptr_t p offset))
                         ;((equal? native-type char) (string-set! (pointer->string pointer) offset value))
                         ;((equal? native-type 'short) (pointer-set-c-short p offset value))
                         ;((equal? native-type 'unsigned-short) (pointer-ref-c-unsigned-short p offset))
                         ((equal? native-type int) (bytevector-sint-set! p offset value (native-endianness) (pffi-size-of type)))
                         ((equal? native-type unsigned-int) (bytevector-uint-set! p offset value (native-endianness) (pffi-size-of type)))
                         ;((equal? native-type 'long) (pointer-ref-c-long p offset))
                         ;((equal? native-type 'unsigned-long) (pointer-ref-c-unsigned-long p offset))
                         ;((equal? native-type 'float) (pointer-ref-c-float p offset))
                         ;((equal? native-type 'double) (pointer-ref-c-double p offset))
                         ;((equal? native-type '*) (pointer-ref-c-void* p offset))
                         )))
          (racket (ptr-set! pointer type offset 'abs value))
          (stklos (error "Not yet impelemented: pffi-pointer-set!")) ; TODO FIX
          (kawa (invoke pointer 'set (pffi-type->native-type type) offset value)))))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (cond-expand
          (sagittarius
            (let ((p pointer)
                  (native-type (pffi-type->native-type type)))
              (cond ((equal? native-type 'int8_t) (pointer-ref-c-int8_t p offset))
                    ((equal? native-type 'uint8_t) (pointer-ref-c-uint8_t p offset))
                    ((equal? native-type 'int16_t) (pointer-ref-c-int16_t p offset))
                    ((equal? native-type 'uint16_t) (pointer-ref-c-uint16_t p offset))
                    ((equal? native-type 'int32_t) (pointer-ref-c-int32_t p offset))
                    ((equal? native-type 'uint32_t) (pointer-ref-c-uint32_t p offset))
                    ((equal? native-type 'int64_t) (pointer-ref-c-int64_t p offset))
                    ((equal? native-type 'uint64_t) (pointer-ref-c-uint64_t p offset))
                    ((equal? native-type 'intptr_t) (pointer-ref-c-intptr_t p offset))
                    ((equal? native-type 'uintptr_t) (pointer-ref-c-uintptr_t p offset))
                    ((equal? native-type 'char) (pointer-ref-c-char p offset))
                    ((equal? native-type 'short) (pointer-set-c-short p offset value))
                    ((equal? native-type 'unsigned-short) (pointer-ref-c-unsigned-short p offset))
                    ((equal? native-type 'int) (pointer-ref-c-int p offset))
                    ((equal? native-type 'unsigned-int) (pointer-ref-c-unsigned-int p offset))
                    ((equal? native-type 'long) (pointer-ref-c-long p offset))
                    ((equal? native-type 'unsigned-long) (pointer-ref-c-unsigned-long p offset))
                    ((equal? native-type 'float) (pointer-ref-c-float p offset))
                    ((equal? native-type 'double) (pointer-ref-c-double p offset))
                    ((equal? native-type 'void*) (pointer-ref-c-void* p offset)))))
          (guile
            (let ((p (pointer->bytevector pointer (+ offset 100)))
                  (native-type (pffi-type->native-type type)))
              (cond ((equal? native-type int8) (bytevector-s8-ref p offset))
                    ((equal? native-type uint8) (bytevector-u8-ref p offset))
                    ((equal? native-type int16) (bytevector-s16-ref p offset (native-endianness)))
                    ((equal? native-type uint16) (bytevector-u16-ref p offset (native-endianness)))
                    ((equal? native-type int32) (bytevector-s32-ref p offset (native-endianness)))
                    ((equal? native-type uint32) (bytevector-u32-ref p offset (native-endianness)))
                    ((equal? native-type int64) (bytevector-s64-ref p offset (native-endianness)))
                    ((equal? native-type uint64) (bytevector-u64-ref p offset (native-endianness)))
                    ;((equal? native-type 'intptr_t) (pointer-ref-c-intptr_t p offset))
                    ;((equal? native-type 'uintptr_t) (pointer-ref-c-uintptr_t p offset))
                    ;((equal? native-type char) (string-ref (pointer->string pointer) offset))
                    ;((equal? native-type 'short) (pointer-set-c-short p offset value))
                    ;((equal? native-type 'unsigned-short) (pointer-ref-c-unsigned-short p offset))
                    ((equal? native-type int) (bytevector-sint-ref p offset (native-endianness) (pffi-size-of type)))
                    ((equal? native-type unsigned-int) (bytevector-uint-ref p offset (native-endianness) (pffi-size-of type)))
                    ;((equal? native-type 'long) (pointer-ref-c-long p offset))
                    ;((equal? native-type 'unsigned-long) (pointer-ref-c-unsigned-long p offset))
                    ;((equal? native-type 'float) (pointer-ref-c-float p offset))
                    ;((equal? native-type 'double) (pointer-ref-c-double p offset))
                    ;((equal? native-type '*) (pointer-ref-c-void* p offset))
                    )))
          (racket (ptr-ref pointer type 'abs offset))
          (stklos (error "Not yet implemented: pffi-pointer-get")) ; TODO FIX
          (kawa (invoke pointer 'get (pffi-type->native-type type) offset)))))

    (define pffi-pointer-deref
      (lambda (pointer)
        (cond-expand (sagittarius (deref pointer 0))
                     (guile (dereference-pointer pointer))
                     (racket (error "Not yet implemented: pffi-pointer-deref")) ; TODO FIX
                     (stklos (error "Not yet implemented: pffi-pointer-deref")) ; TODO FIX
                     (kawa (invoke pointer 'get (static-field java.lang.foreign.ValueLayout 'ADDRESS) 0)))))))
