
(define pffi-type->native-type ; Chicken has this procedure in three places
  (lambda (type)
    (cond ((equal? type 'int8) 'byte)
          ((equal? type 'uint8) 'unsigned-byte)
          ((equal? type 'int16) 'int16_t)
          ((equal? type 'uint16) 'uint16_t)
          ((equal? type 'int32) 'int32)
          ((equal? type 'uint32) 'unsigned-int32)
          ((equal? type 'int64) 'integer-64)
          ((equal? type 'uint64) 'unsigned-integer64)
          ((equal? type 'char) 'char)
          ((equal? type 'unsigned-char) 'unsigned-char)
          ((equal? type 'short) 'short)
          ((equal? type 'unsigned-short) 'unsigned-short)
          ((equal? type 'int) 'int)
          ((equal? type 'unsigned-int) 'unsigned-int)
          ((equal? type 'long) 'long)
          ((equal? type 'unsigned-long) 'unsigned-long)
          ((equal? type 'float) 'float)
          ((equal? type 'double) 'double)
          ((equal? type 'pointer) 'c-pointer)
          ((equal? type 'void) 'void)
          ((equal? type 'callback) 'c-pointer)
          ((equal? type 'struct) 'c-pointer)
          (else (error "pffi-type->native-type -- No such pffi type" type)))) )

(define pffi-pointer?
  (lambda (object)
    (pointer? object)))

(define-syntax pffi-define
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((pffi-type->native-type ; Chicken has this procedure in three places
               (lambda (type)
                 (cond ((equal? type 'int8) 'byte)
                       ((equal? type 'uint8) 'unsigned-byte)
                       ((equal? type 'int16) 'int16_t)
                       ((equal? type 'uint16) 'uint16_t)
                       ((equal? type 'int32) 'int32)
                       ((equal? type 'uint32) 'unsigned-int32)
                       ((equal? type 'int64) 'integer-64)
                       ((equal? type 'uint64) 'unsigned-integer64)
                       ((equal? type 'char) 'char)
                       ((equal? type 'unsigned-char) 'unsigned-char)
                       ((equal? type 'short) 'short)
                       ((equal? type 'unsigned-short) 'unsigned-short)
                       ((equal? type 'int) 'int)
                       ((equal? type 'unsigned-int) 'unsigned-int)
                       ((equal? type 'long) 'long)
                       ((equal? type 'unsigned-long) 'unsigned-long)
                       ((equal? type 'float) 'float)
                       ((equal? type 'double) 'double)
                       ((equal? type 'pointer) 'c-pointer)
                       ((equal? type 'void) 'void)
                       ((equal? type 'callback) 'c-pointer)
                       ((equal? type 'struct) 'c-pointer)
                       (else (error "pffi-type->native-type -- No such pffi type" type)))))
             (scheme-name (list-ref expr 1))
             (c-name (symbol->string (cadr (list-ref expr 3))))
             (return-type (pffi-type->native-type (cadr (list-ref expr 4))))
             (argument-types (if (null? (cdr (list-ref expr 5)))
                               (list)
                               (map pffi-type->native-type
                                    (cadr (list-ref expr 5))))))
        (if (null? argument-types)
          `(define ,scheme-name
             (foreign-safe-lambda ,return-type ,c-name))
          `(define ,scheme-name
             (foreign-safe-lambda ,return-type ,c-name ,@ argument-types)))))))

(define-syntax pffi-define-callback
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((pffi-type->native-type ; Chicken has this procedure in three places
               (lambda (type)
                 (cond ((equal? type 'int8) 'byte)
                       ((equal? type 'uint8) 'unsigned-byte)
                       ((equal? type 'int16) 'int16_t)
                       ((equal? type 'uint16) 'uint16_t)
                       ((equal? type 'int32) 'int32)
                       ((equal? type 'uint32) 'unsigned-int32)
                       ((equal? type 'int64) 'integer-64)
                       ((equal? type 'uint64) 'unsigned-integer64)
                       ((equal? type 'char) 'char)
                       ((equal? type 'unsigned-char) 'unsigned-char)
                       ((equal? type 'short) 'short)
                       ((equal? type 'unsigned-short) 'unsigned-short)
                       ((equal? type 'int) 'int)
                       ((equal? type 'unsigned-int) 'unsigned-int)
                       ((equal? type 'long) 'long)
                       ((equal? type 'unsigned-long) 'unsigned-long)
                       ((equal? type 'float) 'float)
                       ((equal? type 'double) 'double)
                       ((equal? type 'pointer) 'c-pointer)
                       ((equal? type 'void) 'void)
                       ((equal? type 'callback) 'c-pointer)
                       ((equal? type 'struct) 'c-pointer)
                       (else (error "pffi-type->native-type -- No such pffi type" type)))))
             (scheme-name (list-ref expr 1))
             (return-type (pffi-type->native-type (cadr (list-ref expr 2))))
             (argument-types (map pffi-type->native-type (cadr (list-ref expr 3))))
             (argument-names (cadr (list-ref expr 4)))
             (arguments (map
                          (lambda (name type)
                            `(,name ,type))
                          argument-types argument-names))
             (procedure-body (cdr (cdr (list-ref expr 4)))))
        `(begin (define-external ,(cons 'external_123456789 arguments)
                                 ,return-type
                                 (begin ,@ procedure-body))
                (define ,scheme-name (location external_123456789)))))))

(define size-of-type
  (lambda (type)
    (cond ((equal? type 'int8) (foreign-value "sizeof(int8_t)" int))
          ((equal? type 'uint8) (foreign-value "sizeof(uint8_t)" int))
          ((equal? type 'int16) (foreign-value "sizeof(int16_t)" int))
          ((equal? type 'uint16) (foreign-value "sizeof(uint16_t)" int))
          ((equal? type 'int32) (foreign-value "sizeof(int32_t)" int))
          ((equal? type 'uint32) (foreign-value "sizeof(uint32_t)" int))
          ((equal? type 'int64) (foreign-value "sizeof(int64_t)" int))
          ((equal? type 'uint64) (foreign-value "sizeof(uint64_t)" int))
          ((equal? type 'char) (foreign-value "sizeof(char)" int))
          ((equal? type 'unsigned-char) (foreign-value "sizeof(unsigned char)" int))
          ((equal? type 'short) (foreign-value "sizeof(short)" int))
          ((equal? type 'unsigned-short) (foreign-value "sizeof(unsigned short)" int))
          ((equal? type 'int) (foreign-value "sizeof(int)" int))
          ((equal? type 'unsigned-int) (foreign-value "sizeof(unsigned int)" int))
          ((equal? type 'long) (foreign-value "sizeof(long)" int))
          ((equal? type 'unsigned-long) (foreign-value "sizeof(unsigned long)" int))
          ((equal? type 'float) (foreign-value "sizeof(float)" int))
          ((equal? type 'double) (foreign-value "sizeof(double)" int))
          ((equal? type 'pointer) (foreign-value "sizeof(void*)" int))
          ((equal? type 'string) (foreign-value "sizeof(void*)" int))
          ((equal? type 'callback) (foreign-value "sizeof(void*)" int)))))

#;(define pffi-pointer-allocate
  (lambda (size)
    (allocate size)))

(define pffi-pointer-address
  (lambda (pointer)
    (pointer->address pointer)))

(define pffi-pointer-null
  (lambda ()
    (address->pointer 0)))

;(pffi-define strncpy-ps #f 'strncpy 'pointer (list 'pointer 'pointer 'int))
;(pffi-define puts #f 'puts 'int (list 'pointer))
;(pffi-define memset #f 'memset 'void (list 'pointer 'int 'int))

#;(define pffi-string->pointer
  (lambda (string-content)
    (let* ((size (string-length string-content))
           (pointer (pffi-pointer-allocate (+ size 1))))
      (memset pointer 0 (+ size 1))
      (strncpy-ps pointer (location string-content) size)
      ;(puts pointer)
      pointer)))

#;(define pffi-string->pointer
  (foreign-lambda* c-pointer
                   ((c-string str))
                   "C_return((void*)str);"))


;(pffi-define strncpy-pp #f 'strncpy 'pointer (list 'pointer 'pointer 'int))
;(pffi-define strlen #f 'strlen 'int (list 'pointer))

#;(define pffi-pointer->string
  (foreign-lambda* c-string
                   ((c-pointer p))
                   "C_return((char*)p);"))

(define-syntax pffi-shared-object-load
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((headers (cadr (car (cdr expr)))))
        `(begin
           ,@ (map
                (lambda (header)
                  `(foreign-declare ,(string-append "#include <" header ">")))
                headers))))))

#;(define pffi-pointer-free
  (lambda (pointer)
    (if (not (pointer? pointer))
      (error "pffi-pointer-free -- Argument is not pointer" pointer))
    (free pointer)))

(define pffi-pointer-null?
  (lambda (pointer)
    (if (and (not (pointer? pointer))
             pointer)
      #f
      (or (not pointer) ; #f counts as null pointer on Chicken
          (= (pointer->address pointer) 0)))))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond
      ((equal? type 'int8) (pointer-s8-set! (pointer+ pointer offset) value))
      ((equal? type 'uint8) (pointer-u8-set! (pointer+ pointer offset) value))
      ((equal? type 'int16) (pointer-s16-set! (pointer+ pointer offset) value))
      ((equal? type 'uint16) (pointer-u16-set! (pointer+ pointer offset) value))
      ((equal? type 'int32) (pointer-s32-set! (pointer+ pointer offset) value))
      ((equal? type 'uint32) (pointer-u32-set! (pointer+ pointer offset) value))
      ((equal? type 'int64) (pointer-s64-set! (pointer+ pointer offset) value))
      ((equal? type 'uint64) (pointer-u64-set! (pointer+ pointer offset) value))
      ((equal? type 'char) (pointer-s8-set! (pointer+ pointer offset) (char->integer value)))
      ((equal? type 'short) (pointer-s8-set! (pointer+ pointer offset) value))
      ((equal? type 'unsigned-short) (pointer-u8-set! (pointer+ pointer offset) value))
      ((equal? type 'int) (pointer-s32-set! (pointer+ pointer offset) value))
      ((equal? type 'unsigned-int) (pointer-u32-set! (pointer+ pointer offset) value))
      ((equal? type 'long) (pointer-s32-set! (pointer+ pointer offset) value))
      ((equal? type 'unsigned-long) (pointer-u32-set! (pointer+ pointer offset) value))
      ((equal? type 'float) (pointer-f32-set! (pointer+ pointer offset) value))
      ((equal? type 'double) (pointer-f64-set! (pointer+ pointer offset) value))
      ((equal? type 'pointer) (pointer-u64-set! (pointer+ pointer offset) (pointer->address value))))))

(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond
      ((equal? type 'int8) (pointer-s8-ref (pointer+ pointer offset)))
      ((equal? type 'uint8) (pointer-u8-ref (pointer+ pointer offset)))
      ((equal? type 'int16) (pointer-s16-ref (pointer+ pointer offset)))
      ((equal? type 'uint16) (pointer-u16-ref (pointer+ pointer offset)))
      ((equal? type 'int32) (pointer-s32-ref (pointer+ pointer offset)))
      ((equal? type 'uint32) (pointer-u32-ref (pointer+ pointer offset)))
      ((equal? type 'int64) (pointer-s64-ref (pointer+ pointer offset)))
      ((equal? type 'uint64) (pointer-u64-ref (pointer+ pointer offset)))
      ((equal? type 'char) (integer->char (pointer-s8-ref (pointer+ pointer offset))))
      ((equal? type 'short) (pointer-s8-ref (pointer+ pointer offset)))
      ((equal? type 'unsigned-short) (pointer-u8-ref (pointer+ pointer offset)))
      ((equal? type 'int) (pointer-s32-ref (pointer+ pointer offset)))
      ((equal? type 'unsigned-int) (pointer-u32-ref (pointer+ pointer offset)))
      ((equal? type 'long) (pointer-s32-ref (pointer+ pointer offset)))
      ((equal? type 'unsigned-long) (pointer-u32-ref (pointer+ pointer offset)))
      ((equal? type 'float) (pointer-f32-ref (pointer+ pointer offset)))
      ((equal? type 'double) (pointer-f64-ref (pointer+ pointer offset)))
      ((equal? type 'pointer) (address->pointer (pointer-u64-ref (pointer+ pointer offset)))))))

(define pffi-struct-dereference
  (lambda (struct)
    (pffi-pointer-address (pffi-struct-pointer struct))))

