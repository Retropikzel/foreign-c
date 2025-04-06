(c-declare "#include <stdlib.h>")
(c-declare "#include <stdint.h>")

(define-macro
  (pffi-init)
  `(begin (c-define-type pointer (pointer void))
          (c-define-type callback (pointer void))))

(define size-of-int8_t (c-lambda () int "___return(sizeof(int8_t));"))
(define size-of-uint8_t (c-lambda () int "___return(sizeof(uint8_t));"))
(define size-of-int16_t (c-lambda () int "___return(sizeof(int16_t));"))
(define size-of-uint16_t (c-lambda () int "___return(sizeof(uint16_t));"))
(define size-of-int32_t (c-lambda () int "___return(sizeof(int32_t));"))
(define size-of-uint32_t (c-lambda () int "___return(sizeof(uint32_t));"))
(define size-of-int64_t (c-lambda () int "___return(sizeof(int64_t));"))
(define size-of-uint64_t (c-lambda () int "___return(sizeof(uint64_t));"))
(define size-of-char (c-lambda () int "___return(sizeof(char));"))
(define size-of-unsigned-char (c-lambda () int "___return(sizeof(unsigned char));"))
(define size-of-short (c-lambda () int "___return(sizeof(short));"))
(define size-of-unsigned-short (c-lambda () int "___return(sizeof(unsigned short));"))
(define size-of-int (c-lambda () int "___return(sizeof(int));"))
(define size-of-unsigned-int (c-lambda () int "___return(sizeof(unsigned int));"))
(define size-of-long (c-lambda () int "___return(sizeof(long));"))
(define size-of-unsigned-long (c-lambda () int "___return(sizeof(unsigned long));"))
(define size-of-float (c-lambda () int "___return(sizeof(float));"))
(define size-of-double (c-lambda () int "___return(sizeof(double));"))
(define size-of-void* (c-lambda () int "___return(sizeof(void*));"))

(define size-of-type
  (lambda (type)
    (cond ((eq? type 'int8) (size-of-int8_t))
          ((eq? type 'uint8) (size-of-uint8_t))
          ((eq? type 'int16) (size-of-int16_t))
          ((eq? type 'uint16) (size-of-uint16_t))
          ((eq? type 'int32) (size-of-int32_t))
          ((eq? type 'uint32) (size-of-uint32_t))
          ((eq? type 'int64) (size-of-int64_t))
          ((eq? type 'uint64) (size-of-uint64_t))
          ((eq? type 'char) (size-of-char))
          ((eq? type 'unsigned-char) (size-of-char))
          ((eq? type 'short) (size-of-short))
          ((eq? type 'unsigned-short) (size-of-unsigned-short))
          ((eq? type 'int) (size-of-int))
          ((eq? type 'unsigned-int) (size-of-unsigned-int))
          ((eq? type 'long) (size-of-long))
          ((eq? type 'unsigned-long) (size-of-unsigned-long))
          ((eq? type 'float) (size-of-float))
          ((eq? type 'double) (size-of-double))
          ((eq? type 'pointer) (size-of-void*))
          ((eq? type 'callback) (size-of-void*))
          ((eq? type 'void) (size-of-void*))
          (else (error "Can not get size of unknown type" type)))))

(define-macro
  (pffi-define-library name headers object-name . options)
  `(begin (define ,name #t)
          (c-declare ,(apply string-append
                             (map
                               (lambda (header)
                                 (string-append "#include <" header ">" (string #\newline)))
                               (cdr headers))))))

(define pointer? (c-lambda ((pointer void)) bool  "___return(1);"))
(define pffi-pointer?
  (lambda (object)
    (call-with-current-continuation
      (lambda (k)
        (with-exception-handler
          (lambda (x) #f)
          (lambda () (pointer? object)))))))

(define pffi-pointer-null (c-lambda () (pointer void) "void* p = NULL; ___return(p);"))

(define pointer-null? (c-lambda ((pointer void)) bool  "if(___arg1 == NULL) {  ___return(1); } else { ___return(0); }"))
(define pffi-pointer-null?
  (lambda (pointer)
    (and (pffi-pointer? pointer)
         (pointer-null? pointer))))

;(define pffi-pointer-allocate (c-lambda (int) (pointer void) "void* p = malloc(___arg1); ___return(p);"))

(define pffi-pointer-address (c-lambda ((pointer void)) ptrdiff_t "void* p = ___arg1; ___return((intptr_t)&p);"))

;(define pffi-pointer-free (c-lambda ((pointer void)) void "free(___arg1);"))

(define pointer-set-c-int8_t! (c-lambda ((pointer void) int int8) void "*(int8_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-uint8_t! (c-lambda ((pointer void) int unsigned-int8) void "*(uint8_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-int16_t! (c-lambda ((pointer void) int int16) void "*(int16_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-uint16_t! (c-lambda ((pointer void) int unsigned-int16) void "*(uint16_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-int32_t! (c-lambda ((pointer void) int int32) void "*(int32_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-uint32_t! (c-lambda ((pointer void) int unsigned-int32) void "*(uint32_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-int64_t! (c-lambda ((pointer void) int int64) void "*(int64_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-uint64_t! (c-lambda ((pointer void) int unsigned-int64) void "*(uint64_t*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-char! (c-lambda ((pointer void) int char) void "*((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-short! (c-lambda ((pointer void) int short) void "*(short*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-unsigned-short! (c-lambda ((pointer void) int unsigned-int64) void "*(unsigned short*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-int! (c-lambda ((pointer void) int int) void "*(int*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-unsigned-int! (c-lambda ((pointer void) int unsigned-int64) void "*(unsigned int*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-long! (c-lambda ((pointer void) int long) void "*(long*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-unsigned-long! (c-lambda ((pointer void) int unsigned-int64) void "*(unsigned long*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-float! (c-lambda ((pointer void) int float) void "*(float*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-double! (c-lambda ((pointer void) int double) void "*(double*)((char*)___arg1 + ___arg2) = ___arg3;"))
(define pointer-set-c-pointer! (c-lambda ((pointer void) int (pointer void)) void "{ char* p = (char*)___arg1 + ___arg2; *(char**)p = ___arg3; }"))

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond ((equal? type 'int8) (pointer-set-c-int8_t! pointer offset value))
          ((equal? type 'uint8) (pointer-set-c-uint8_t! pointer offset value))
          ((equal? type 'int16) (pointer-set-c-int16_t! pointer offset value))
          ((equal? type 'uint16) (pointer-set-c-uint16_t! pointer offset value))
          ((equal? type 'int32) (pointer-set-c-int32_t! pointer offset value))
          ((equal? type 'uint32) (pointer-set-c-uint32_t! pointer offset value))
          ((equal? type 'int64) (pointer-set-c-int64_t! pointer offset value))
          ((equal? type 'uint64) (pointer-set-c-uint64_t! pointer offset value))
          ((equal? type 'char) (pointer-set-c-char! pointer offset value))
          ((equal? type 'short) (pointer-set-c-short! pointer offset value))
          ((equal? type 'unsigned-short) (pointer-set-c-unsigned-short! pointer offset value))
          ((equal? type 'int) (pointer-set-c-int! pointer offset value))
          ((equal? type 'unsigned-int) (pointer-set-c-unsigned-int! pointer offset value))
          ((equal? type 'long) (pointer-set-c-long! pointer offset value))
          ((equal? type 'unsigned-long) (pointer-set-c-unsigned-long! pointer offset value))
          ((equal? type 'float) (pointer-set-c-float! pointer offset value))
          ((equal? type 'double) (pointer-set-c-double! pointer offset value))
          ((equal? type 'void) (pointer-set-c-pointer! pointer offset value))
          ((equal? type 'pointer) (pointer-set-c-pointer! pointer offset value)))))

(define pointer-ref-c-int8_t (c-lambda ((pointer void) int) int8 "___return(*(int8_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-uint8_t (c-lambda ((pointer void) int) unsigned-int8 "___return(*(uint8_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-int16_t (c-lambda ((pointer void) int) int16 "___return(*(int16_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-uint16_t (c-lambda ((pointer void) int) unsigned-int16 "___return(*(uint16_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-int32_t (c-lambda ((pointer void) int) int32 "___return(*(int32_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-uint32_t (c-lambda ((pointer void) int) unsigned-int32 "___return(*(uint32_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-int64_t (c-lambda ((pointer void) int) int64 "___return(*(int64_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-uint64_t (c-lambda ((pointer void) int) unsigned-int64 "___return(*(uint64_t*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-char (c-lambda ((pointer void) int) char "___return(*((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-short (c-lambda ((pointer void) int) short "___return(*(short*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-unsigned-short (c-lambda ((pointer void) int) unsigned-short "___return(*(unsigned short*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-int (c-lambda ((pointer void) int) int "___return(*(int*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-unsigned-int (c-lambda ((pointer void) int) unsigned-int "___return(*(unsigned int*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-long (c-lambda ((pointer void) int) long "___return(*(long*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-unsigned-long (c-lambda ((pointer void) int) unsigned-long "___return(*(unsigned long*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-float (c-lambda ((pointer void) int) float "___return(*(float*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-double (c-lambda ((pointer void) int) double "___return(*(double*)((char*)___arg1 + ___arg2));"))
(define pointer-ref-c-pointer (c-lambda ((pointer void) int) (pointer void) " char* p = (char*)___arg1 + ___arg2; ___return(*(char**)p);"))


(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond ((equal? type 'int8) (pointer-ref-c-int8_t pointer offset))
          ((equal? type 'uint8) (pointer-ref-c-uint8_t pointer offset))
          ((equal? type 'int16) (pointer-ref-c-int16_t pointer offset))
          ((equal? type 'uint16) (pointer-ref-c-uint16_t pointer offset))
          ((equal? type 'int32) (pointer-ref-c-int32_t pointer offset))
          ((equal? type 'uint32) (pointer-ref-c-uint32_t pointer offset))
          ((equal? type 'int64) (pointer-ref-c-int64_t pointer offset))
          ((equal? type 'uint64) (pointer-ref-c-uint64_t pointer offset))
          ((equal? type 'char) (pointer-ref-c-char pointer offset))
          ((equal? type 'short) (pointer-ref-c-short pointer offset))
          ((equal? type 'unsigned-short) (pointer-ref-c-unsigned-short pointer offset))
          ((equal? type 'int) (pointer-ref-c-int pointer offset))
          ((equal? type 'unsigned-int) (pointer-ref-c-unsigned-int pointer offset))
          ((equal? type 'long) (pointer-ref-c-long pointer offset))
          ((equal? type 'unsigned-long) (pointer-ref-c-unsigned-long pointer offset))
          ((equal? type 'float) (pointer-ref-c-float pointer offset))
          ((equal? type 'double) (pointer-ref-c-double pointer offset))
          ((equal? type 'void) (pointer-ref-c-pointer pointer offset))
          ((equal? type 'pointer) (pointer-ref-c-pointer pointer offset)))))

(define-macro
  (pffi-define scheme-name shared-object c-name return-type argument-types)
  (letrec* ((native-argument-types
              (if (equal? '(list) argument-types)
                (list)
                (let ((types (map cdr (cdr argument-types))))
                  (if (null? types) types (map car types)))))
            (native-return-type (car (cdr return-type)))
            (c-arguments (lambda (index argument-count result)
                           (if (> index argument-count)
                             result
                             (c-arguments (+ index 1)
                                          argument-count
                                          (string-append result
                                                         "___arg"
                                                         (number->string index)
                                                         (if (< index argument-count)
                                                           ", "
                                                           ""))))))
            (c-code (string-append
                      (if (equal? 'void (cadr return-type)) "" "___return(")
                      (symbol->string (cadr c-name))
                      "(" (c-arguments 1 (- (length argument-types) 1) "") ")"
                      (if (equal? 'void (cadr return-type)) "" ")")
                      ";")))
    `(define ,scheme-name
       (c-lambda ,native-argument-types
                 ,native-return-type
                 ,c-code))))
