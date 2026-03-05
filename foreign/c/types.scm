(define-record-type <c-integer-type>
  (internal-make-c-integer-type name size align signed?)
  c-integer-type?
  (name c-integer-type-name)
  (size c-integer-type-size)
  (align c-integer-type-align)
  (signed? c-integer-type-signed?))

(define-record-type <c-float-type>
  (internal-make-c-float-type name size align)
  c-float-type?
  (name c-float-type-name)
  (size c-float-type-size)
  (align c-float-type-align))

(define-record-type <c-double-type>
  (internal-make-c-double-type name size align)
  c-double-type?
  (name c-double-type-name)
  (size c-double-type-size)
  (align c-double-type-align))

(define-record-type <c-void-type>
  (internal-make-c-void-type name)
  c-void-type?
  (name c-void-type-name))

(define-record-type <c-pointer-type>
  (internal-make-c-pointer-type name size align)
  c-pointer-type?
  (name c-pointer-type-name)
  (size c-pointer-type-size)
  (align c-pointer-type-align))

(define-record-type <c-array-type>
  (internal-make-c-array-type name type)
  c-array-type?
  (name c-array-type-name)
  (type c-array-type-type))

(define-record-type <c-struct-type>
  (internal-make-c-struct-type name size members)
  c-struct-type?
  (name c-struct-type-name)
  (size c-struct-type-size)
  (members c-struct-type-members))

(define (make-c-integer-type name size align signed?)
  (when (not (symbol? name))
    (error "make-c-integer-type: name must be symbol" size))
  (when (not (exact-integer? size))
    (error "make-c-integer-type: size must be exact integer" size))
  (when (not (exact-integer? align))
    (error "make-c-integer-type: align must be exact integer" align))
  (when (not (boolean? signed?))
    (error "make-c-integer-type: signed? must be boolean" signed?))
  (internal-make-c-integer-type name size align signed?))

(define (make-c-float-type name size align)
  (when (not (symbol? name))
    (error "make-c-float-type: name must be symbol" size))
  (internal-make-c-float-type name size align))

(define (make-c-double-type name size align)
  (when (not (symbol? name))
    (error "make-c-float-type: name must be symbol" size))
  (internal-make-c-double-type name size align))

(define (make-c-void-type name)
  (internal-make-c-void-type name))

(define (make-c-pointer-type name size align)
  (when (not (symbol? name))
    (error "make-c-integer-type: name must be symbol" size))
  (when (not (exact-integer? size))
    (error "make-c-integer-type: size must be exact integer" size))
  (when (not (exact-integer? align))
    (error "make-c-integer-type: align must be exact integer" align))
  (internal-make-c-pointer-type name size align))

(define (make-c-array-type name type)
  (when (not (symbol? name))
    (error "make-c-array-type: name must be symbol" name))
  (when (not (c-type? type))
    (error "make-c-array-type: type must be C type" type))
  (internal-make-c-array-type name type))

(define (make-c-struct-type name members)
  (when (not (symbol? name))
    (error "make-c-struct-type: name must be symbol" name))
  (when (null? members)
    (error "make-c-struct-type: can not make struct type with no members" members))
  (for-each
    (lambda (memb)
      (when (not (pair? memb))
        (error "meake-c-struct-type: struct members must be pairs" memb))
      (when (not (symbol? (car memb)))
        (error "meake-c-struct-type: struct member car must be symbol" memb))
      (when (not (c-type? (cdr memb)))
        (error "meake-c-struct-type: struct member cdr must be C type" memb)))
    members)
  (internal-make-c-struct-type name
                               (calculate-struct-size members)
                               (calculate-struct-members members)))

(define (c-type? obj)
  (or (c-integer-type? obj)
      (c-float-type? obj)
      (c-double-type? obj)
      (c-pointer-type? obj)
      (c-struct-type? obj)))

(define (c-type-name type)
  (cond
    ((c-integer-type? type) (c-integer-type-name type))
    ((c-float-type? type) (c-float-type-name type))
    ((c-double-type? type) (c-double-type-name type))
    ((c-void-type? type) (c-void-type-name type))
    ((c-pointer-type? type) (c-pointer-type-name type))
    ((c-struct-type? type) (c-struct-type-name type))
    (else (error "c-type-name: argument must be C type" type))))

(define (c-type-name=? type-a type-b)
  (cond
    ((not (c-type? type-a)) (error "c-type-name=?: type-a must be C type"))
    ((not (c-type? type-b)) (error "c-type-name=?: type-b must be C type"))
    (else (equal? (c-type-name type-a) (c-type-name type-b)))))

(define (c-type-size type)
  (cond
    ((c-integer-type? type) (c-integer-type-size type))
    ((c-float-type? type) (c-float-type-size type))
    ((c-double-type? type) (c-double-type-size type))
    ((c-void-type? type) (error "c-type-size: c-void-type has no size" type))
    ((c-pointer-type? type) (c-pointer-type-size type))
    ((c-array-type? type) (c-type-size (c-array-type-type type)))
    ((c-struct-type? type) (c-struct-type-size type))
    (else (error "c-type-size: argument must be C type" type))))

(define (c-type-size=? type-a type-b)
  (cond
    ((c-void-type? type-a) (error "c-type-size=?: type-a can not be c-void-type" type-a))
    ((c-void-type? type-b) (error "c-type-size=?: type-b can not be c-void-type" type-b))
    ((not (c-type? type-a)) (error "c-type-size=?: type-a must be C type" type-a))
    ((not (c-type? type-b)) (error "c-type-size=?: type-b must be C type" type-b))
    (else (= (c-type-size type-a) (c-type-size type-b)))))

(define (c-type-align type)
  (cond
    ((c-integer-type? type) (c-integer-type-align type))
    ((c-float-type? type) (c-float-type-align type))
    ((c-pointer-type? type) (c-pointer-type-align type))
    (else (error "c-type-align: argument must be C type" type))))

(define (c-type-align=? type-a type-b)
  (cond
    ((not (c-type? type-a)) (error "c-type-align=?: type-a must be C type"))
    ((not (c-type? type-b)) (error "c-type-align=?: type-b must be C type"))
    (else (equal? (c-type-align type-a) (c-type-align type-b)))))


(define i8 (make-c-integer-type 'i8 (size-of-type 'i8) (align-of-type 'i8) #t))
(define u8 (make-c-integer-type 'u8 (size-of-type 'u8) (align-of-type 'u8) #f))
(define i16 (make-c-integer-type 'i16 (size-of-type 'i16) (align-of-type 'i16) #t))
(define u16 (make-c-integer-type 'u16 (size-of-type 'u16) (align-of-type 'u16) #f))
(define i32 (make-c-integer-type 'i32 (size-of-type 'i32) (align-of-type 'i32) #t))
(define u32 (make-c-integer-type 'u32 (size-of-type 'u32) (align-of-type 'u32) #f))
(define i64 (make-c-integer-type 'i64 (size-of-type 'i64) (align-of-type 'i64) #t))
(define u64 (make-c-integer-type 'u64 (size-of-type 'u64) (align-of-type 'u64) #f))
(define char (make-c-integer-type 'char (size-of-type 'char) (align-of-type 'char) #t))
(define uchar (make-c-integer-type 'uchar (size-of-type 'uchar) (align-of-type 'uchar) #f))
(define short (make-c-integer-type 'shot (size-of-type 'short) (align-of-type 'short) #t))
(define ushort (make-c-integer-type 'short (size-of-type 'short) (align-of-type 'short) #f))
(define int (make-c-integer-type 'int (size-of-type 'int) (align-of-type 'int) #t))
(define uint (make-c-integer-type 'int (size-of-type 'int) (align-of-type 'int) #f))
(define long (make-c-integer-type 'long (size-of-type 'long) (align-of-type 'long) #t))
(define ulong (make-c-integer-type 'ulong (size-of-type 'ulong) (align-of-type 'ulong) #f))
(define float (make-c-float-type 'float (size-of-type 'float) (align-of-type 'float)))
(define double (make-c-double-type 'double (size-of-type 'double) (align-of-type 'double)))
(define void (make-c-void-type 'void))
(define pointer (make-c-pointer-type 'pointer (size-of-type 'pointer) (align-of-type 'pointer)))
