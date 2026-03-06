(define-syntax type->native-type
  (syntax-rules ()
    ((_ type)
     (cond ((equal? type 'i8) 'integer-8)
           ((equal? type 'u8) 'unsigned-8)
           ((equal? type 'i16) 'integer-16)
           ((equal? type 'u16) 'unsigned-16)
           ((equal? type 'i32) 'integer-32)
           ((equal? type 'u32) 'unsigned-32)
           ((equal? type 'i64) 'integer-64)
           ((equal? type 'u64) 'unsigned-64)
           ((equal? type 'char) 'char)
           ((equal? type 'uchar) 'unsigned-8)
           ((equal? type 'short) 'short)
           ((equal? type 'ushort) 'unsigned-short)
           ((equal? type 'int) 'int)
           ((equal? type 'uint) 'unsigned-int)
           ((equal? type 'long) 'long)
           ((equal? type 'ulong) 'unsigned-long)
           ((equal? type 'float) 'float)
           ((equal? type 'double) 'double)
           ((equal? type 'pointer) 'void*)
           ((equal? type 'void) 'void)))))

(define size-of-type
  (lambda (type)
    (chezscheme-foreign-sizeof (type->native-type type))))

(define align-of-type
  (lambda (type)
    (chezscheme-foreign-alignof (type->native-type type))))

(define shared-object-load
  (lambda (path options)
    (chezscheme-load-shared-object path)))

(define c-u8-set!
  (lambda (c-bytevector k byte)
    (chezscheme-foreign-set! 'unsigned-8 c-bytevector k byte)))

(define c-u8-ref
  (lambda (c-bytevector k)
    (chezscheme-foreign-ref 'unsigned-8 c-bytevector k)))

(define c-pointer-set!
  (lambda (c-bytevector k pointer)
    (chezscheme-foreign-set! 'void* c-bytevector k pointer)))

(define c-pointer-ref
  (lambda (c-bytevector k)
    (chezscheme-foreign-ref 'void* c-bytevector k)))

(define (c-null) (c-memset-address->pointer 0 0 0))
(define (c-null? pointer)
  (or (and (number? pointer)
           (= pointer 0))
      (and (chezscheme-ftype-pointer? pointer)
           (chezscheme-ftype-pointer-null? pointer))))

(define-syntax define-macro!
  (lambda (x)
    (chezscheme-syntax-case x ()
                 [(k (name arg1 ... . args)
                     form1
                     form2
                     ...)
                  #'(k name (arg1 ... . args)
                       form1
                       form2
                       ...)]
                 [(k (name arg1 arg2 ...)
                     form1
                     form2
                     ...)
                  #'(k name (arg1 arg2 ...)
                       form1
                       form2
                       ...)]
                 [(k name args . forms)
                  (chezscheme-identifier? #'name)
                  (letrec ((add-car
                             (lambda (access)
                               (case (car access)
                                 ((cdr) `(cadr ,@(cdr access)))
                                 ((cadr) `(caadr ,@(cdr access)))
                                 ((cddr) `(caddr ,@(cdr access)))
                                 ((cdddr) `(cadddr ,@(cdr access)))
                                 (else `(car ,access)))))
                           (add-cdr
                             (lambda (access)
                               (case (car access)
                                 ((cdr) `(cddr ,@(cdr access)))
                                 ((cadr) `(cdadr ,@(cdr access)))
                                 ((cddr) `(cdddr ,@(cdr access)))
                                 ((cdddr) `(cddddr ,@(cdr access)))
                                 (else `(cdr ,access)))))
                           (parse
                             (lambda (l access)
                               (cond
                                 ((null? l) '())
                                 ((symbol? l) `((,l ,access)))
                                 ((pair? l)
                                  (chezscheme-append!
                                    (parse (car l) (add-car access))
                                    (parse (cdr l) (add-cdr access))))
                                 (else
                                   (chezscheme-syntax-error #'args
                                                 (chezscheme-format "invalid ~s parameter syntax" (chezscheme-datum k))))))))
                    (chezscheme-with-syntax ((proc (chezscheme-datum->syntax-object #'k
                                                              (let ((g (chezscheme-gensym)))
                                                                `(lambda (,g)
                                                                   (let ,(parse (chezscheme-datum args) `(cdr ,g))
                                                                     ,@(chezscheme-datum forms)))))))
                                 #'(define-syntax name
                                     (lambda (x)
                                       (chezscheme-syntax-case x ()
                                                    ((k1 . r)
                                                     (chezscheme-datum->syntax-object #'k1
                                                                           (proc (chezscheme-syntax-object->datum x)))))))))])))

(define-macro!
  define-c-procedure
  (scheme-name shared-object c-name return-type argument-types)
  (let ((native-argument-types
          (map (lambda (type)
                 ;; This is defined in 3 places
                 (cond ((equal? (c-type-name type) 'i8) 'integer-8)
                       ((equal? (c-type-name type) 'u8) 'unsigned-8)
                       ((equal? (c-type-name type) 'i16) 'integer-16)
                       ((equal? (c-type-name type) 'u16) 'unsigned-16)
                       ((equal? (c-type-name type) 'i32) 'integer-32)
                       ((equal? (c-type-name type) 'u32) 'unsigned-32)
                       ((equal? (c-type-name type) 'i64) 'integer-64)
                       ((equal? (c-type-name type) 'u64) 'unsigned-64)
                       ((equal? (c-type-name type) 'char) 'char)
                       ((equal? (c-type-name type) 'uhar) 'unsigned-8)
                       ((equal? (c-type-name type) 'short) 'short)
                       ((equal? (c-type-name type) 'ushort) 'unsigned-short)
                       ((equal? (c-type-name type) 'int) 'int)
                       ((equal? (c-type-name type) 'uint) 'unsigned-int)
                       ((equal? (c-type-name type) 'long) 'long)
                       ((equal? (c-type-name type) 'ulong) 'unsigned-long)
                       ((equal? (c-type-name type) 'float) 'float)
                       ((equal? (c-type-name type) 'double) 'double)
                       ((equal? (c-type-name type) 'pointer) 'void*)
                       ((equal? (c-type-name type) 'void) 'void)))
               (if (null? argument-types)
                 '()
                 (cadr argument-types))))
        (native-return-type
          ;; This is defined in 3 places
          (cond ((equal? (c-type-name return-type) ''i8) 'integer-8)
                ((equal? (c-type-name return-type) ''u8) 'unsigned-8)
                ((equal? (c-type-name return-type) ''i16) 'integer-16)
                ((equal? (c-type-name return-type) ''u16) 'unsigned-16)
                ((equal? (c-type-name return-type) ''i32) 'integer-32)
                ((equal? (c-type-name return-type) ''u32) 'unsigned-32)
                ((equal? (c-type-name return-type) ''i64) 'integer-64)
                ((equal? (c-type-name return-type) ''u64) 'unsigned-64)
                ((equal? (c-type-name return-type) ''char) 'char)
                ((equal? (c-type-name return-type) ''uhar) 'unsigned-8)
                ((equal? (c-type-name return-type) ''short) 'short)
                ((equal? (c-type-name return-type) ''ushort) 'unsigned-short)
                ((equal? (c-type-name return-type) ''int) 'int)
                ((equal? (c-type-name return-type) ''uint) 'unsigned-int)
                ((equal? (c-type-name return-type) ''long) 'long)
                ((equal? (c-type-name return-type) ''ulong) 'unsigned-long)
                ((equal? (c-type-name return-type) ''float) 'float)
                ((equal? (c-type-name return-type) ''double) 'double)
                ((equal? (c-type-name return-type) ''pointer) 'void*)
                ((equal? (c-type-name return-type) ''void) 'void))))
    (if (null? argument-types)
      `(define ,scheme-name
         (lambda args
           (let ((internal (chezscheme-foreign-procedure #f
                                              ,(symbol->string (cadr c-name))
                                              ()
                                              ,native-return-type)))
             (if (c-pointer-type? ,return-type)
               (internal-make-c-bytevector (apply internal (map value->native-value args)))
               (apply internal (map value->native-value args))))))
      `(define ,scheme-name
         (lambda args
           (let ((internal (chezscheme-foreign-procedure #f
                                              ,(symbol->string (cadr c-name))
                                              ,native-argument-types
                                              ,native-return-type)))
             (if (c-pointer-type? ,return-type)
               (internal-make-c-bytevector (apply internal (map value->native-value args)))
               (apply internal (map value->native-value args)))))))))
