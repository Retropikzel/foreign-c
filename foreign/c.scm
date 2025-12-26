(define c-type-size
  (lambda (type)
    (cond ((not (symbol? type)) (error "c-type-size: Type must be symbol" type))
          ((symbol=? type 'void) 0)
          ((or (symbol=? type 'i8)
               (symbol=? type 'u8)
               (symbol=? type 'i16)
               (symbol=? type 'u16)
               (symbol=? type 'i32)
               (symbol=? type 'u32)
               (symbol=? type 'i64)
               (symbol=? type 'u64)
               (symbol=? type 'char)
               (symbol=? type 'uchar)
               (symbol=? type 'short)
               (symbol=? type 'ushort)
               (symbol=? type 'int)
               (symbol=? type 'uint)
               (symbol=? type 'long)
               (symbol=? type 'ulong)
               (symbol=? type 'float)
               (symbol=? type 'double)
               (symbol=? type 'pointer))
           (size-of-type type))
          (else (error "Unknown type" type)))))

(define c-type-align
  (lambda (type)
    (cond ((not (symbol? type)) (error "c-type-align: Type must be symbol" type))
          ((symbol=? type 'void) 0)
          ((or (symbol=? type 'i8)
               (symbol=? type 'u8)
               (symbol=? type 'i16)
               (symbol=? type 'u16)
               (symbol=? type 'i32)
               (symbol=? type 'u32)
               (symbol=? type 'i64)
               (symbol=? type 'u64)
               (symbol=? type 'char)
               (symbol=? type 'uchar)
               (symbol=? type 'short)
               (symbol=? type 'ushort)
               (symbol=? type 'int)
               (symbol=? type 'uint)
               (symbol=? type 'long)
               (symbol=? type 'ulong)
               (symbol=? type 'float)
               (symbol=? type 'double)
               (symbol=? type 'pointer))
           (align-of-type type))
          (else (error "Unknown type" type)))))

(define make-c-bytevector
  (lambda (k . byte)
    (if (null? byte)
      (c-malloc k)
      (bytevector->c-bytevector (make-bytevector k (car byte))))))

#;(define c-bytevector
  (lambda bytes
    (bytevector->c-bytevector
      (apply (lambda (b) (make-bytevector 1 b)) bytes))))

(define (c-bytevector-set! bv type offset value)
  (cond ((not (symbol? type)) (error "c-bytevector-set!: type must be symbol" type))
        ((symbol=? type 'i8) (c-bytevector-s8-set! bv offset value))
        ((symbol=? type 'u8) (c-bytevector-u8-set! bv offset value))
        ((symbol=? type 'i16) (c-bytevector-s16-set! bv offset value))
        ((symbol=? type 'u16) (c-bytevector-u16-set! bv offset value))
        ((symbol=? type 'i32) (c-bytevector-s32-set! bv offset value))
        ((symbol=? type 'u32) (c-bytevector-u32-set! bv offset value))
        ((symbol=? type 'i64) (c-bytevector-s64-set! bv offset value))
        ((symbol=? type 'u64) (c-bytevector-u64-set! bv offset value))
        ((symbol=? type 'char) (c-bytevector-s8-set! bv offset (char->integer value)))
        ((symbol=? type 'uchar) (c-bytevector-u8-ref bv offset (char->integer value)))
        ((symbol=? type 'short) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'short)))
        ((symbol=? type 'ushort) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'unsigned-short)))
        ((symbol=? type 'int) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'int)))
        ((symbol=? type 'uint) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'unsigned-int)))
        ((symbol=? type 'long) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'long)))
        ((symbol=? type 'ulong) (c-bytevector-sint-set! bv offset value (native-endianness) (c-type-size 'unsigned-long)))
        ((symbol=? type 'float) (c-bytevector-ieee-single-native-set! bv offset value))
        ((symbol=? type 'double) (c-bytevector-ieee-double-native-set! bv offset value))
        ((symbol=? type 'pointer) (c-bytevector-pointer-set! bv offset value))
        (else (error "c-bytevector-set!: Unknown type" type))))

(define (c-bytevector-get bv type offset)
  (cond ((not (symbol? type)) (error "c-bytevector-ref: type must be symbol" type))
        ((symbol=? type 'i8) (c-bytevector-s8-ref bv offset))
        ((symbol=? type 'u8) (c-bytevector-u8-ref bv offset))
        ((symbol=? type 'i16) (c-bytevector-s16-ref bv offset))
        ((symbol=? type 'u16) (c-bytevector-u16-ref bv offset))
        ((symbol=? type 'i32) (c-bytevector-s32-ref bv offset))
        ((symbol=? type 'u32) (c-bytevector-u32-ref bv offset))
        ((symbol=? type 'i64) (c-bytevector-s64-ref bv offset))
        ((symbol=? type 'u64) (c-bytevector-u64-ref bv offset))
        ((symbol=? type 'char) (integer->char (c-bytevector-s8-ref bv offset)))
        ((symbol=? type 'uchar) (integer->char (c-bytevector-u8-ref bv offset)))
        ((symbol=? type 'short) (c-bytevector-sint-ref bv offset (native-endianness) (c-type-size 'short)))
        ((symbol=? type 'ushort) (c-bytevector-uint-ref bv offset (native-endianness) (c-type-size 'ushort)))
        ((symbol=? type 'int) (c-bytevector-sint-ref bv offset (native-endianness) (c-type-size 'int)))
        ((symbol=? type 'uint) (c-bytevector-uint-ref bv offset (native-endianness) (c-type-size 'uint)))
        ((symbol=? type 'long) (c-bytevector-sint-ref bv offset (native-endianness) (c-type-size 'long)))
        ((symbol=? type 'ulong) (c-bytevector-uint-ref bv offset (native-endianness) (c-type-size 'ulong)))
        ((symbol=? type 'float) (c-bytevector-ieee-single-native-ref bv offset))
        ((symbol=? type 'double) (c-bytevector-ieee-double-native-ref bv offset))
        ((equal? type 'pointer) (c-bytevector-pointer-ref bv offset))
        (else (error "c-bytevector-ref!: Unknown type" type))))

(define bytevector->c-bytevector
  (lambda (bytes)
    (letrec* ((bytes-length (bytevector-length bytes))
              (pointer (make-c-bytevector bytes-length))
              (looper (lambda (index)
                        (when (< index bytes-length)
                          (c-bytevector-u8-set! pointer
                                                index
                                                (bytevector-u8-ref bytes index))
                          (looper (+ index 1))))))
      (looper 0)
      pointer)))

(define c-bytevector->bytevector
  (lambda (pointer size)
    (letrec* ((bytes (make-bytevector size))
              (looper (lambda (index)
                        (let ((byte (c-bytevector-u8-ref pointer index)))
                          (if (= index size)
                            bytes
                            (begin
                              (bytevector-u8-set! bytes index byte)
                              (looper (+ index 1))))))))
      (looper 0))))

(define c-string-length
  (lambda (bytevector-var)
    (c-strlen bytevector-var)))

(define c-utf8->string
  (lambda (c-bytevector)
    (let ((size (c-strlen c-bytevector)))
      (utf8->string (c-bytevector->bytevector c-bytevector size)))))

(define string->c-utf8
  (lambda (string-var)
    (bytevector->c-bytevector
      (string->utf8
        (string-append string-var (string (integer->char 0)))))))

(define c-bytevector->address
  (lambda (c-bytevector)
    (c-memset-pointer->address c-bytevector 0 0)))

(define address->c-bytevector
  (lambda (address)
    (c-memset-address->pointer address 0 0)))

(define-syntax call-with-address-of
  (syntax-rules ()
    ((_ input-pointer thunk)
     (let ((address-pointer (make-c-bytevector (c-type-size 'pointer))))
       (c-bytevector-pointer-set! address-pointer 0 input-pointer)
       (let ((result (apply thunk (list address-pointer))))
         (set! input-pointer (c-bytevector-pointer-ref address-pointer 0))
         (c-free address-pointer)
         result)))))

(define round-to-next-modulo-of
  (lambda (to-round roundee)
    (if (= (modulo to-round roundee) 0)
      to-round
      (round-to-next-modulo-of (+ to-round 1) roundee))))

(define calculate-struct-members
  (lambda (members . return-just-size)
    (let*
      ((size 0)
       (largest-member-size 0)
       (data (map (lambda (member)
                    (let* ((name (list-ref member 0))
                           (type (list-ref member 1))
                           (accessor (list-ref member 2))
                           (type-alignment (c-type-align type)))
                      (when (> (size-of-type type) largest-member-size)
                        (set! largest-member-size (size-of-type type)))
                      (if (or (= size 0)
                              (= (modulo size type-alignment) 0))
                        (begin
                          (set! size (+ size type-alignment))
                          (list name type (- size type-alignment) accessor))
                        (let ((next-alignment
                                (round-to-next-modulo-of size type-alignment)))
                          (set! size (+ next-alignment type-alignment))
                          (list name type next-alignment accessor)))))
                  members)))
      (if (null? return-just-size)
        data
        size))))

(define calculate-struct-size
  (lambda (members)
    (calculate-struct-members members #t)))

(define-syntax define-c-struct
  (syntax-rules ()
    ((_ name members struct-size-variable struct-pointer (field-name field-type accessor modifier) ...)
     (begin
       (define accessor
         (lambda (c-bytevector)
           (let ((offset (let ((offset 0)
                               (before? #t))
                           (for-each
                             (lambda (member)
                               (when (equal? (list-ref member 0) 'field-name)
                                 (set! before? #f))
                               (when before?
                                 (set! offset
                                   (+ offset
                                      (c-type-align (list-ref member 1))))))
                             members)
                           offset)))
             ;; TODO
             )))
       ...
       (define modifier
         (lambda (c-bytevector value)
           (let ((offset (let ((offset 0)
                               (before? #t))
                           (for-each
                             (lambda (member)
                               (when (equal? (list-ref member 0) 'field-name)
                                 (set! before? #f))
                               (when before?
                                 (set! offset
                                   (+ offset
                                      (c-type-align (list-ref member 1))))))
                             members)
                           offset)))
             (cond
               ((equal? 'pointer field-type)
                (c-bytevector-pointer-set! c-bytevector offset value))
               ((c-type-signed? field-type)
                (c-bytevector-sint-set! c-bytevector
                                        offset
                                        value
                                        (native-endianness)
                                        (c-type-size field-type)))
               (else
                 (c-bytevector-uint-set! c-bytevector
                                         offset
                                         value
                                         (native-endianness)
                                         (c-type-size field-type)))))))
       ...
       (define members (calculate-struct-members
                         (list (list 'field-name field-type accessor) ...)))
       (define struct-size-variable (calculate-struct-size
                                      (list (list 'field-name field-type accessor) ...)))
       (define name
         (if (not struct-pointer)
           (make-c-bytevector (+ (c-type-size field-type) ...) 0)
           struct-pointer))))))

(c-bytevectors-init make-c-bytevector c-bytevector-u8-set! c-bytevector-u8-ref c-type-size)
