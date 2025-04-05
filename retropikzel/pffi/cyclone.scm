(define pffi-type->native-type
  (lambda (type)
    (cond ((equal? type 'int8) int)
          ((equal? type 'uint8) int)
          ((equal? type 'int16) int)
          ((equal? type 'uint16) int)
          ((equal? type 'int32) int)
          ((equal? type 'uint32) int)
          ((equal? type 'int64) int)
          ((equal? type 'uint64) int)
          ((equal? type 'char) char)
          ((equal? type 'unsigned-char) char)
          ((equal? type 'short) int)
          ((equal? type 'unsigned-short) int)
          ((equal? type 'int) int)
          ((equal? type 'unsigned-int) int)
          ((equal? type 'long) int)
          ((equal? type 'unsigned-long) int)
          ((equal? type 'float) float)
          ((equal? type 'double) double)
          ((equal? type 'pointer) opaque)
          ((equal? type 'void) c-void)
          ((equal? type 'struct) 'c-pointer)
          (else (error "pffi-type->native-type -- No such pffi type" type)))))

(define pffi-pointer?
  (lambda (object)
    (opaque? object)))

(define-syntax pffi-define
  (er-macro-transformer
    (lambda (expr rename compare)
      (let* ((pffi-type->native-type
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
                       ((equal? type 'struct) 'c-pointer)
                       (else (error "pffi-type->native-type -- No such pffi type" type)))))
             (scheme-name (car (cdr expr)))
             (c-name (symbol->string (car (cdr (car (cdr (cdr (cdr expr))))))))
             (return-type (pffi-type->native-type (car (cdr (car (cdr (cdr (cdr (cdr expr)))))))))
             (argument-types
               (let ((types (cdr (car (cdr (cdr (cdr (cdr (cdr expr)))))))))
                 (if (null? types)
                   '()
                   (map pffi-type->native-type (map car (map cdr types)))))))
        (if (null? argument-types)
          `(c-define ,scheme-name ,return-type ,c-name)
          `(c-define ,scheme-name
                     ,return-type ,c-name ,@ argument-types))))))

(define pffi-define-callback
  (lambda (scheme-name return-type argument-types procedure)
    (error "pffi-define-callback not yet implemented on Cyclone")))

(define size-of-type
  (lambda (type)
    (cond ((equal? type 'int8) (c-value "sizeof(int8_t)" int))
          ((equal? type 'uint8) (c-value "sizeof(uint8_t)" int))
          ((equal? type 'int16) (c-value "sizeof(int16_t)" int))
          ((equal? type 'uint16) (c-value "sizeof(uint16_t)" int))
          ((equal? type 'int32) (c-value "sizeof(int32_t)" int))
          ((equal? type 'uint32) (c-value "sizeof(uint32_t)" int))
          ((equal? type 'int64) (c-value "sizeof(int64_t)" int))
          ((equal? type 'uint64) (c-value "sizeof(uint64_t)" int))
          ((equal? type 'char) (c-value "sizeof(char)" int))
          ((equal? type 'unsigned-char) (c-value "sizeof(unsigned char)" int))
          ((equal? type 'short) (c-value "sizeof(short)" int))
          ((equal? type 'unsigned-short) (c-value "sizeof(unsigned short)" int))
          ((equal? type 'int) (c-value "sizeof(int)" int))
          ((equal? type 'unsigned-int) (c-value "sizeof(unsigned int)" int))
          ((equal? type 'long) (c-value "sizeof(long)" int))
          ((equal? type 'unsigned-long) (c-value "sizeof(unsigned long)" int))
          ((equal? type 'float) (c-value "sizeof(float)" int))
          ((equal? type 'double) (c-value "sizeof(double)" int))
          ((equal? type 'pointer) (c-value "sizeof(void*)" int)))))

#;(define-c pffi-pointer-allocate
          "(void *data, int argc, closure _, object k, object size)"
          "make_c_opaque(opq, malloc(obj_obj2int(size)));
          return_closcall1(data, k, &opq);")

(define pffi-pointer-null
  (lambda ()
    (make-opaque)))

#;(define-c pffi-string->pointer
          "(void *data, int argc, closure _, object k, object s)"
          "make_c_opaque(opq, string_str(s));
          return_closcall1(data, k, &opq);")

#;(define-c pffi-pointer->string
          "(void *data, int argc, closure _, object k, object p)"
          "make_string(s, opaque_ptr(p));
          return_closcall1(data, k, &s);")

(define-syntax pffi-shared-object-load
  (er-macro-transformer
    (lambda (expr rename compare)
      `(begin
         ,@ (map
              (lambda (header)
                `(include-c-header ,(string-append "<" header ">")))
              (cdr (car (cdr expr))))))))

#;(define-c pffi-pointer-free
          "(void *data, int argc, closure _, object k, object pointer)"
          "free(opaque_ptr(pointer));
          return_closcall1(data, k, make_boolean(boolean_t));")

(define pffi-pointer-null?
  (lambda (pointer)
    (and (opaque? pointer)
         (opaque-null? pointer))))

(define-c pffi-pointer-int8-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "int8_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-uint8-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "uint8_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-int16-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "int16_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-uint16-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "uint16_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-int32-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "int32_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-uint32-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "uint32_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-int64-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "int64_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-uint64-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "uint64_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-char-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "char* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2char(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-short-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "short* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-unsigned-short-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "unsigned short* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-int-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "int* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-unsigned-int-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "unsigned int* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-long-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "long* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-unsigned-long-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "unsigned long* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = obj_obj2int(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-float-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "float* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = double_value(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-double-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "double* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = double_value(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define-c pffi-pointer-pointer-set!
          "(void *data, int argc, closure _, object k, object pointer, object offset, object value)"
          "uintptr_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          *p = (uintptr_t)&opaque_ptr(value);
          return_closcall1(data, k, make_boolean(boolean_t));")

(define pffi-pointer-set!
  (lambda (pointer type offset value)
    (cond
      ((equal? type 'int8) (pffi-pointer-int8-set! pointer offset value))
      ((equal? type 'uint8) (pffi-pointer-uint8-set! pointer offset value))
      ((equal? type 'int16) (pffi-pointer-int16-set! pointer offset value))
      ((equal? type 'uint16) (pffi-pointer-uint16-set! pointer offset value))
      ((equal? type 'int32) (pffi-pointer-int32-set! pointer offset value))
      ((equal? type 'uint32) (pffi-pointer-uint32-set! pointer offset value))
      ((equal? type 'int64) (pffi-pointer-int64-set! pointer offset value))
      ((equal? type 'uint64) (pffi-pointer-uint64-set! pointer offset value))
      ((equal? type 'char) (pffi-pointer-char-set! pointer offset value))
      ((equal? type 'short) (pffi-pointer-short-set! pointer offset value))
      ((equal? type 'unsigned-short) (pffi-pointer-unsigned-short-set! pointer offset value))
      ((equal? type 'int) (pffi-pointer-int-set! pointer offset value))
      ((equal? type 'unsigned-int) (pffi-pointer-unsigned-int-set! pointer offset value))
      ((equal? type 'long) (pffi-pointer-long-set! pointer offset value))
      ((equal? type 'unsigned-long) (pffi-pointer-unsigned-long-set! pointer offset value))
      ((equal? type 'float) (pffi-pointer-float-set! pointer offset value))
      ((equal? type 'double) (pffi-pointer-double-set! pointer offset value))
      ((equal? type 'pointer) (pffi-pointer-pointer-set! pointer offset value)))))

(define-c pffi-pointer-int8-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "int8_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-uint8-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "uint8_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-int16-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "int16_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-uint16-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "uint16_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-int32-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "int32_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-uint32-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "uint32_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-int64-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "int64_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-uint64-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "uint64_t* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-char-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "char* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_char2obj(*p));")

(define-c pffi-pointer-short-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "short* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-unsigned-short-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "unsigned short* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-int-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "int* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-unsigned-int-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "unsigned int* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-long-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "long* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-unsigned-long-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "unsigned long* p = opaque_ptr(pointer) + obj_obj2int(offset);
          return_closcall1(data, k, obj_int2obj(*p));")

(define-c pffi-pointer-float-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "float* p = opaque_ptr(pointer) + obj_obj2int(offset);
          alloca_double(d, *p);
          return_closcall1(data, k, d);")

(define-c pffi-pointer-double-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "double* p = opaque_ptr(pointer) + obj_obj2int(offset);
          alloca_double(d, *p);
          return_closcall1(data, k, d);")

(define-c pffi-pointer-pointer-get
          "(void *data, int argc, closure _, object k, object pointer, object offset)"
          "make_c_opaque(opq, (void*)opaque_ptr(pointer) + obj_obj2int(offset));
          return_closcall1(data, k, &opq);")

(define pffi-pointer-get
  (lambda (pointer type offset)
    (cond
      ((equal? type 'int8) (pffi-pointer-int8-get pointer offset))
      ((equal? type 'uint8) (pffi-pointer-uint8-get pointer offset))
      ((equal? type 'int16) (pffi-pointer-int16-get pointer offset))
      ((equal? type 'uint16) (pffi-pointer-uint16-get pointer offset))
      ((equal? type 'int32) (pffi-pointer-int32-get pointer offset))
      ((equal? type 'uint32) (pffi-pointer-uint32-get pointer offset))
      ((equal? type 'int64) (pffi-pointer-int64-get pointer offset))
      ((equal? type 'uint64) (pffi-pointer-uint64-get pointer offset))
      ((equal? type 'char) (pffi-pointer-char-get pointer offset))
      ((equal? type 'short) (pffi-pointer-short-get pointer offset))
      ((equal? type 'unsigned-short) (pffi-pointer-unsigned-short-get pointer offset))
      ((equal? type 'int) (pffi-pointer-int-get pointer offset))
      ((equal? type 'unsigned-int) (pffi-pointer-unsigned-int-get pointer offset))
      ((equal? type 'long) (pffi-pointer-long-get pointer offset))
      ((equal? type 'unsigned-long) (pffi-pointer-unsigned-long-get pointer offset))
      ((equal? type 'float) (pffi-pointer-float-get pointer offset))
      ((equal? type 'double) (pffi-pointer-double-get pointer offset))
      ((equal? type 'pointer) (pffi-pointer-pointer-get pointer offset)))))
