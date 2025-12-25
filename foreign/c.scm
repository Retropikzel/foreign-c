(define c-type-size
  (lambda (type)
    (size-of-type type)))

(define c-type-align
  (lambda (type)
    (align-of-type type)))

(define c-type-signed?
  (lambda (type)
    (if (member type '(int8 int16 int32 int64 char short int long float double))
      #t
      #f)))

(define c-type-unsigned?
  (lambda (type)
    (if (member type '(uint8 uint16 uint32 uint64 unsigned-char unsigned-short unsigned-int unsigned-long))
      #t
      #f)))

(define make-c-bytevector
  (lambda (k . byte)
    (if (null? byte)
      (c-malloc k)
      (bytevector->c-bytevector (make-bytevector k (car byte))))))

(define c-bytevector
  (lambda bytes
    (bytevector->c-bytevector
      (apply (lambda (b) (make-bytevector 1 b)) bytes))))

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
  (lambda (members)
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
      data)))


(define-syntax define-c-struct
  (syntax-rules ()
    ((_ name members struct-pointer (field-name field-type accessor modifier) ...)
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
             (cond
               ((equal? 'pointer field-type)
                (c-bytevector-pointer-ref c-bytevector offset))
               ((c-type-signed? field-type)
                (c-bytevector-sint-ref c-bytevector
                                       offset
                                       (native-endianness)
                                       (c-type-size field-type)))
               (else
                 (c-bytevector-uint-ref c-bytevector
                                        offset
                                        (native-endianness)
                                        (c-type-size field-type)))))))
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
       (define name
         (if (not struct-pointer)
           (make-c-bytevector (+ (c-type-size field-type) ...) 0)
           struct-pointer))))))

(c-bytevectors-init make-c-bytevector c-bytevector-u8-set! c-bytevector-u8-ref)
