(define (c-type-size type)
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
        (else (error "Unknown type" type))))

(define (c-type-align type)
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
        (else (error "Unknown type" type))))

(define (make-c-bytevector size . byte)
  (when (not (integer? size)) (error "make-c-bytevector: Size must be integer"))
  (if (null? byte)
    (c-malloc size)
    (bytevector->c-bytevector (make-bytevector size (car byte)))))

(define c-bytevector
  (lambda bytes
    (bytevector->c-bytevector
      (apply (lambda (b) (make-bytevector 1 b)) bytes))))

(define (c-bytevector-set! cbv type offset value)
  (when (not (c-bytevector? cbv))
    (error "c-bytevector-set!: cbv argument must be c-bytevector" cbv))
  (when (not (symbol? type))
    (error "c-bytevector-set!: type must be symbol" type))
  (when (not (integer? offet))
    (error "c-bytevector-set!: offset argument must be integer" offset))
  (cond ((not (symbol? type)) (error "c-bytevector-set!: type must be symbol" type))
        ((symbol=? type 'i8) (c-bytevector-s8-set! cbv offset value))
        ((symbol=? type 'u8) (c-bytevector-u8-set! cbv offset value))
        ((symbol=? type 'i16) (c-bytevector-s16-set! cbv offset value))
        ((symbol=? type 'u16) (c-bytevector-u16-set! cbv offset value))
        ((symbol=? type 'i32) (c-bytevector-s32-set! cbv offset value))
        ((symbol=? type 'u32) (c-bytevector-u32-set! cbv offset value))
        ((symbol=? type 'i64) (c-bytevector-s64-set! cbv offset value))
        ((symbol=? type 'u64) (c-bytevector-u64-set! cbv offset value))
        ((symbol=? type 'char) (c-bytevector-s8-set! cbv offset (char->integer value)))
        ((symbol=? type 'uchar) (c-bytevector-u8-ref cbv offset (char->integer value)))
        ((symbol=? type 'short) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'short)))
        ((symbol=? type 'ushort) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'ushort)))
        ((symbol=? type 'int) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'int)))
        ((symbol=? type 'uint) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'uint)))
        ((symbol=? type 'long) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'long)))
        ((symbol=? type 'ulong) (c-bytevector-sint-set! cbv offset value (native-endianness) (c-type-size 'ulong)))
        ((symbol=? type 'float) (c-bytevector-ieee-single-native-set! cbv offset value))
        ((symbol=? type 'double) (c-bytevector-ieee-double-native-set! cbv offset value))
        ((symbol=? type 'pointer) (c-bytevector-pointer-set! cbv offset value))
        (else (error "c-bytevector-set!: Unknown type" type))))

(define (c-bytevector-ref cbv type offset)
  (when (not (c-bytevector? cbv))
    (error "c-bytevector-ref: cbv argument must be c-bytevector" cbv))
  (when (not (symbol? type))
    (error "c-bytevector-ref: type must be symbol" type))
  (when (not (integer? offet))
    (error "c-bytevector-ref: offset argument must be integer" offset))
  (cond ((symbol=? type 'i8) (c-bytevector-s8-ref cbv offset))
        ((symbol=? type 'u8) (c-bytevector-u8-ref cbv offset))
        ((symbol=? type 'i16) (c-bytevector-s16-ref cbv offset))
        ((symbol=? type 'u16) (c-bytevector-u16-ref cbv offset))
        ((symbol=? type 'i32) (c-bytevector-s32-ref cbv offset))
        ((symbol=? type 'u32) (c-bytevector-u32-ref cbv offset))
        ((symbol=? type 'i64) (c-bytevector-s64-ref cbv offset))
        ((symbol=? type 'u64) (c-bytevector-u64-ref cbv offset))
        ((symbol=? type 'char) (integer->char (c-bytevector-s8-ref cbv offset)))
        ((symbol=? type 'uchar) (integer->char (c-bytevector-u8-ref cbv offset)))
        ((symbol=? type 'short) (c-bytevector-sint-ref cbv offset (native-endianness) (c-type-size 'short)))
        ((symbol=? type 'ushort) (c-bytevector-uint-ref cbv offset (native-endianness) (c-type-size 'ushort)))
        ((symbol=? type 'int) (c-bytevector-sint-ref cbv offset (native-endianness) (c-type-size 'int)))
        ((symbol=? type 'uint) (c-bytevector-uint-ref cbv offset (native-endianness) (c-type-size 'uint)))
        ((symbol=? type 'long) (c-bytevector-sint-ref cbv offset (native-endianness) (c-type-size 'long)))
        ((symbol=? type 'ulong) (c-bytevector-uint-ref cbv offset (native-endianness) (c-type-size 'ulong)))
        ((symbol=? type 'float) (c-bytevector-ieee-single-native-ref cbv offset))
        ((symbol=? type 'double) (c-bytevector-ieee-double-native-ref cbv offset))
        ((equal? type 'pointer) (c-bytevector-pointer-ref cbv offset))
        (else (error "c-bytevector-ref: Unknown type" type))))

(define bytevector->c-bytevector
  (lambda (bv)
    (when (not (bytevector? bv))
      (error "bytevector->c-bytevector: bv argument must be bytevector" bv))
    (letrec* ((bytes-length (bytevector-length bv))
              (pointer (make-c-bytevector bytes-length))
              (looper (lambda (index)
                        (when (< index bytes-length)
                          (c-bytevector-u8-set! pointer
                                                index
                                                (bytevector-u8-ref bv index))
                          (looper (+ index 1))))))
      (looper 0)
      pointer)))

(define c-bytevector->bytevector
  (lambda (cbv size)
    (when (not (c-bytevector? cbv))
      (error "c-bytevector->bytevector: cbv argument must be c-bytevector" cbv))
    (when (not (integer? size))
      (error "c-bytevector->bytevector: size argument must be integer" size))
    (letrec* ((bv (make-bytevector size))
              (looper (lambda (index)
                        (let ((byte (c-bytevector-u8-ref cbv index)))
                          (if (= index size)
                            bv
                            (begin
                              (bytevector-u8-set! bv index byte)
                              (looper (+ index 1))))))))
      (looper 0))))

(define c-utf8->string
  (lambda (cbv)
    (when (not (c-bytevector? cbv))
      (error "c-utf8->string: cbv argument must be c-bytevector" cbv))
    (let ((size (c-strlen cbv)))
      (utf8->string (c-bytevector->bytevector cbv size)))))

(define string->c-utf8
  (lambda (str)
    (when (not (string? str))
      (error "string->c-utf8-: str argument must be string" cbv))
    (bytevector->c-bytevector
      (string->utf8
        (string-append str (string (integer->char 0)))))))

(define c-bytevector->address
  (lambda (cbv)
    (when (not (c-bytevector? cbv))
      (error "c-bytevector->address cbv argument must be c-bytevector" cbv))
    (c-memset-pointer->address cbv 0 0)))

(define address->c-bytevector
  (lambda (address)
    (when (not (integer? address))
      (error "c-bytevector->string: address argument must be integer" cbv))
    (c-memset-address->pointer address 0 0)))

(define-syntax call-with-address-of
  (syntax-rules ()
    ((_ cbv thunk)
     (let ((address-cbv (make-c-bytevector (c-type-size 'pointer))))
       (c-bytevector-pointer-set! address-cbv 0 cbv)
       (when (not (c-bytevector? cbv))
         (error "call-with-address-of: cbv argument must be c-bytevector"))
       (when (not (procedure? thunk))
         (error "call-with-address-of: thunk argument must be procedure"))
       (let ((result (apply thunk (list address-cbv))))
         (set! cbv (c-bytevector-pointer-ref address-cbv 0))
         (c-free address-cbv)
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
    ((_ name members struct-size-variable struct-cbv (field-name field-type accessor modifier) ...)
     (begin
       (when (not (or (equal? struct-cbv #f)
                      (c-bytevector? struct-cbv)))
         (error "define-c-struct: struct-cbv argument must be c-bytevector or #f"))
       (define accessor
         (lambda (cbv)
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
             (c-bytevector-ref cbv field-type offset))))
       ...
       (define modifier
         (lambda (cbv value)
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
             (c-bytevector-set! cbv field-type offset value))))
       ...
       (define members (calculate-struct-members
                         (list (list 'field-name field-type accessor) ...)))
       (define struct-size-variable (calculate-struct-size
                                      (list (list 'field-name field-type accessor) ...)))
       (define name
         (if (not struct-cbv)
           (make-c-bytevector (+ (c-type-size field-type) ...) 0)
           struct-cbv))))))

(c-bytevectors-init make-c-bytevector c-bytevector-u8-set! c-bytevector-u8-ref c-type-size)
