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
    (else (error "Implementation not supported by r7rs-pffi")))
  (export pffi-call
          pffi-types
          pffi-type-sizes
          pffi-size-of
          pffi-pointer-allocate
          pffi-string->pointer
          pffi-pointer->string
          pffi-pointer-free
          pffi-pointer?
          pffi-pointer-null?
          pffi-pointer-address-get
          pffi-shared-object-load
          pffi-shared-object-auto-load
          pffi-pointer-set!
          pffi-pointer-get
          pffi-struct-make
          pffi-struct-get
          pffi-struct-set!
          pffi-struct-pointer-get
          pffi-struct-member-types-get
          pffi-struct-pretty-print)
  (begin

    (define library-version "v0.1.0")

    (define-record-type pffi-struct
      (make-pffi-struct member-types member-names struct-alignment struct-pointer size)
      pffi-struct?
      (member-types pffi-struct-member-types-get)
      (member-names pffi-struct-member-names-get)
      (struct-alignment pffi-struct-alignment-get)
      (struct-pointer pffi-struct-pointer-get)
      (size pffi-struct-size-get))

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

    (define string-split
      (lambda (str mark)
        (let* ((str-l (string->list str))
               (res (list))
               (last-index 0)
               (index 0)
               (splitter (lambda (c)
                           (cond ((char=? c mark)
                                  (begin
                                    (set! res (append res (list (string-copy str last-index index))))
                                    (set! last-index (+ index 1))))
                                 ((equal? (length str-l) (+ index 1))
                                  (set! res (append res (list (string-copy str last-index (+ index 1)))))))
                           (set! index (+ index 1)))))
          (for-each splitter str-l)
          res)))

    (define pffi-pointer-adress-get
      (lambda (pointer)
        (cond-expand (sagittarius (address pointer)))))

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



    (define platform-file-extension (cond-expand (windows ".dll") (else ".so")))

    (define memorysession #f)
    (define linker #f)
    (define symbol-lookup #f)
    (define kebab-case->snake-case
      (lambda (str) (string-map (lambda (c) (if (char=? c #\-) #\_ c)) str)))

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
                  ((equal? type 'void) 'void)
                  (else (error "pffi-type->native-type -- No such pffi type" type)))))))

    (define pffi-pointer?
      (lambda (object)
        (cond-expand (sagittarius (pointer? object)))))

    (define pffi->native
      (lambda (value)
        (cond ((pffi-pointer? value) value)
              ((pffi-struct? value) (pffi-struct-pointer-get value))
              (else value))))

    (define pffi-call
      (lambda (shared-object name type arguments)
        (let ((types (map pffi-type->native-type (map car arguments)))
              (vals (map pffi->native (map cdr arguments))))
          (cond-expand
            (sagittarius
              (apply (make-c-function shared-object
                                      (pffi-type->native-type type)
                                      name
                                      types) vals))))))

    (define pffi-type-sizes
      (map
        (lambda (type)
          (cond
            ((eq? type 'int8) (cond-expand (sagittarius size-of-int8_t)))
            ((eq? type 'uint8)  (cond-expand (sagittarius size-of-uint8_t)))
            ((eq? type 'int16)  (cond-expand (sagittarius size-of-int16_t)))
            ((eq? type 'uint16)  (cond-expand (sagittarius size-of-uint16_t)))
            ((eq? type 'int32)  (cond-expand (sagittarius size-of-int32_t)))
            ((eq? type 'uint32)  (cond-expand (sagittarius size-of-uint32_t)))
            ((eq? type 'int64)  (cond-expand (sagittarius size-of-int64_t)))
            ((eq? type 'uint64)  (cond-expand (sagittarius size-of-uint64_t)))
            ((eq? type 'intptr)  (cond-expand (sagittarius size-of-intptr_t)))
            ((eq? type 'uintptr)  (cond-expand (sagittarius size-of-uintptr_t)))
            ((eq? type 'char)  (cond-expand (sagittarius size-of-char)))
            ((eq? type 'unsigned-char)  (cond-expand (sagittarius size-of-char)))
            ((eq? type 'short)  (cond-expand (sagittarius size-of-short)))
            ((eq? type 'unsigned-short)  (cond-expand (sagittarius size-of-unsigned-short)))
            ((eq? type 'int)  (cond-expand (sagittarius size-of-int)))
            ((eq? type 'unsigned-int)  (cond-expand (sagittarius size-of-unsigned-int)))
            ((eq? type 'long)  (cond-expand (sagittarius size-of-long)))
            ((eq? type 'unsigned-long)  (cond-expand (sagittarius size-of-unsigned-long)))
            ((eq? type 'float)  (cond-expand (sagittarius size-of-float)))
            ((eq? type 'double)  (cond-expand (sagittarius size-of-double)))
            ((eq? type 'pointer)  (cond-expand (sagittarius size-of-void*)))))
        pffi-types))

    (define pffi-size-of
      (lambda (type)
        (let ((size (cdr (assoc type pffi-type-sizes))))
          size)))

    (define pffi-pointer-allocate
      (lambda (size)
        (cond-expand
          (sagittarius (allocate-pointer size)))))

    (define pffi-string->pointer
      (lambda (string-content)
        (cond-expand (sagittarius (bytevector->pointer (string->utf8 string-content))))))

    (define pffi-pointer->string
      (lambda (pointer)
        (cond-expand (sagittarius (utf8->string (pointer->bytevector pointer))))))

    (define pffi-shared-object-load
      (lambda (path)
        (cond-expand (sagittarius (open-shared-library path)))))

    (define pffi-shared-object-auto-load
      (lambda (object-name . additional-paths)
        (let* ((paths (append auto-load-paths additional-paths))
               (shared-object #f))
          (for-each
            (lambda (path)
              (if (not shared-object)
                (let ((object-path (string-append path
                                                  "/"
                                                  object-name
                                                  (cond-expand (windows ".dll") (else ".so"))))
                      (object-version-path (string-append path
                                                          "/"
                                                          object-name
                                                          (cond-expand (windows ".dll") (else ".so.0"))))
                      (object-lib-path (string-append path
                                                      "/"
                                                      (cond-expand (windows "") (else "lib"))
                                                      object-name
                                                      (cond-expand (windows ".dll") (else ".so"))))
                      (object-version-lib-path (string-append path
                                                              "/"
                                                              (cond-expand (windows "") (else "lib"))
                                                              object-name
                                                              (cond-expand (windows ".dll") (else ".so.0")))))
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
            (error (string-append "Could not load shared object: " object-name))
            shared-object))))

    (define pffi-pointer-free
      (lambda (pffi)
        (cond-expand (sagittarius (c-free pointer)))))

    (define pffi-pointer-null?
      (lambda (pointer)
        (cond-expand (sagittarius (null-pointer? pointer)))))

    (define pffi-pointer-set!
      (lambda (pointer type value offset)
        (cond-expand
          (sagittarius
            (let ((p (integer->pointer (pffi-pointer-address-get pointer))))
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
                    ((equal? type 'void) (pointer-set-c-void*! p offset value))))))))

    (define pffi-pointer-get
      (lambda (pointer type offset)
        (cond-expand
          (sagittarius
            (let ((p (integer->pointer (pffi-pointer-address-get pointer)))
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
                    ((equal? native-type 'void*) (pointer-ref-c-void* p offset))))))))

    (define largest-type-size
      (lambda (types)
        (let ((largest 0))
          (for-each
            (lambda (type)
              (if (> (pffi-size-of type) largest)
                (set! largest (pffi-size-of type))))
            types)
          largest)))

    (define figure-out-alignment
      (lambda (member-types)
        (largest-type-size member-types)))

    (define struct-members-size
      (lambda (members)
        (apply + (map pffi-size-of members))))

    (define pffi-struct-make
      (lambda (member-types member-names member-values)
        (let* ((offset 0)
               (alignment (figure-out-alignment member-types))
               (size (* alignment (length member-types)))
               (struct-pointer (pffi-pointer-allocate size)))
          (for-each
            (lambda (type name value)
              (pffi-pointer-set! struct-pointer type value offset)
              (set! offset (+ offset alignment)))
            member-types
            member-names
            member-values)
          (make-pffi-struct member-types member-names alignment struct-pointer size))))

    (define get-item-index
      (lambda (item items)
        (- (length (member item (reverse items))) 1)))

    (define get-member-type
      (lambda (member-name member-names member-types)
        (list-ref member-types (get-item-index member-name member-names))))

    (define pffi-struct-get
      (lambda (pffi-struct member-name)
        (letrec* ((member-names (pffi-struct-member-names-get pffi-struct))
                  (member-types (pffi-struct-member-types-get pffi-struct))
                  (alignment (pffi-struct-alignment-get pffi-struct))
                  (member-type (get-member-type member-name member-names member-types))
                  (member-offset (* alignment (get-item-index member-name member-names))))
          (pffi-pointer-get (pffi-struct-pointer-get pffi-struct)
                            member-type
                            member-offset))))

    (define pffi-struct-set!
      (lambda (pffi-struct member-name value)
        (letrec*
          ((member-names (pffi-struct-member-names-get pffi-struct))
           (member-types (pffi-struct-member-types-get pffi-struct))
           (member-type (get-member-type member-name member-names member-types))
           (alignment (pffi-struct-alignment-get pffi-struct))
           (member-offset (* alignment (get-item-index member-name member-names))))
          (pffi-pointer-set! (pffi-struct-pointer-get pffi-struct)
                             member-type
                             value
                             member-offset))))

    (define pffi-struct-pretty-print
      (lambda (pffi-struct)
        (display "Member types: ")
        (display (pffi-struct-member-types-get pffi-struct))
        (newline)
        (display "Member names: ")
        (display (pffi-struct-member-names-get pffi-struct))
        (newline)
        (display "Alignment: ")
        (display (pffi-struct-alignment-get pffi-struct))
        (newline)
        (display "Pointer: ")
        (display (pffi-struct-pointer-get pffi-struct))
        (newline)
        (display "Size: ")
        (display (pffi-struct-size-get pffi-struct))
        (newline)
        (display "Values: ")
        (newline)
        (for-each
          (lambda (member-name)
            (display "  ")
            (display member-name)
            (display ": ")
            (display (pffi-struct-get pffi-struct member-name))
            (newline))
          (pffi-struct-member-names-get pffi-struct))))

    ))
