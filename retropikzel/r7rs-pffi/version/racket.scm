(define-library
 (retropikzel r7rs-pffi version racket)
 (import (scheme base)
         (scheme write)
         (scheme file)
         (scheme process-context)
         (compatibility mlist)
         (only (racket base) system-type)
         (ffi unsafe)
         (ffi vector))
 (export pffi-shared-object-load
         pffi-define
         pffi-define-callback
         pffi-size-of
         pffi-pointer-allocate
         pffi-pointer-null
         pffi-string->pointer
         pffi-pointer->string
         pffi-pointer-free
         pffi-pointer?
         pffi-pointer-null?
         pffi-pointer-set!
         pffi-pointer-get
         pffi-pointer-deref)
 (begin

   (define pffi-type->native-type
     (lambda (type)
       (cond ((equal? type 'int8) _int8)
         ((equal? type 'uint8) _uint8)
         ((equal? type 'int16) _int16)
         ((equal? type 'uint16) _uint16)
         ((equal? type 'int32) _int32)
         ((equal? type 'uint32) _uint32)
         ((equal? type 'int64) _int64)
         ((equal? type 'uint64) _uint64)
         ((equal? type 'char) _int8)
         ((equal? type 'unsigned-char) _uint8)
         ((equal? type 'short) _short)
         ((equal? type 'unsigned-short) _ushort)
         ((equal? type 'int) _int)
         ((equal? type 'unsigned-int) _uint)
         ((equal? type 'long) _long)
         ((equal? type 'unsigned-long) _ulong)
         ((equal? type 'float) _float)
         ((equal? type 'double) _double)
         ((equal? type 'pointer) _pointer)
         ((equal? type 'string) _string)
         ((equal? type 'void) _void)
         ((equal? type 'callback) _pointer)
         (else (error "pffi-type->native-type -- No such pffi type" type)))))

   (define pffi-pointer?
     (lambda (object)
       (cpointer? object)))

   (define-syntax pffi-define
     (syntax-rules ()
       ((pffi-define scheme-name shared-object c-name return-type argument-types)
        (define scheme-name
          (get-ffi-obj c-name
                       shared-object
                       (_cprocedure (mlist->list (map pffi-type->native-type argument-types))
                                    (pffi-type->native-type return-type)))))))

   (define-syntax pffi-define-callback
     (syntax-rules ()
       ((pffi-define-callback scheme-name return-type argument-types procedure)
        (define scheme-name (function-ptr procedure
                                          (_cprocedure
                                           (mlist->list (map pffi-type->native-type argument-types))
                                           (pffi-type->native-type return-type)))))))

   (define pffi-size-of
     (lambda (type)
       (ctype-sizeof (pffi-type->native-type type))))

   (define pffi-pointer-allocate
     (lambda (size)
       (malloc 'raw size)))

   (define pffi-pointer-null
     (lambda ()
       #f )) ; #f is the null pointer on racket

   (define pffi-string->pointer
     (lambda (string-content)
       (write string-content)
       (newline)
       (let* ((size (string-length string-content))
              (pointer (pffi-pointer-allocate (+ size 1))))
         (memmove pointer (cast string-content _string _pointer) size)
         (display "STRING SIZE: ")
         (display size)
         (display " : ")
         (write (cast pointer _pointer _string))
         (newline)
         pointer)))

   (define pffi-pointer->string
     (lambda (pointer)
     (let* ((size (string-length (cast pointer _pointer _string)))
            (string-content (string-copy (cast pointer _pointer _string))))
       (memmove (cast string-content _string _pointer) pointer size)
       (display "SIZE: ")
       (display size)
       (display " : ")
       (write string-content)
       (newline)
        string-content)))

   (define pffi-shared-object-load
     (lambda (header path)
       (ffi-lib path)))

   (define pffi-pointer-free
     (lambda (pointer)
       (free pointer)))

   (define pffi-pointer-null?
     (lambda (pointer)
       (not pointer))) ; #f is the null pointer on racket

   (define pffi-pointer-set!
     (lambda (pointer type offset value)
       (ptr-set! pointer (pffi-type->native-type type) 'abs offset value)))

   (define pffi-pointer-get
     (lambda (pointer type offset)
       (ptr-ref pointer (pffi-type->native-type type) 'abs offset)))

   (define pffi-pointer-deref
     (lambda (pointer)
       pointer))))
