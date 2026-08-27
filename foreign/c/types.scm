;;>\section{C Types}

;;>\pre{
;;> Returns #t if given type is C integer type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-integer-type? 'i8)
;;> > #t
;;>}
(define (c-integer-type? type)
  (or (equal? type 'i8)
      (equal? type 'u8)
      (equal? type 'i16)
      (equal? type 'u16)
      (equal? type 'i32)
      (equal? type 'u32)
      (equal? type 'i64)
      (equal? type 'u64)
      (equal? type 'short)
      (equal? type 'ushort)
      (equal? type 'int)
      (equal? type 'uint)
      (equal? type 'long)
      (equal? type 'ulong)
      (equal? type 'llong)
      (equal? type 'ullong)))

;;>\pre{
;;> Returns #t if given type is C char type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-char-type? 'char)
;;> > #t
;;>}
(define (c-char-type? type)
  (or (equal? type 'char)
      (equal? type 'uchar)))

;;>\pre{
;;> Returns #t if given type is C float type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-float-type? 'float)
;;> > #t
;;>}
(define (c-float-type? type) (equal? type 'float))

;;>\pre{
;;> Returns #t if given type is C double type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-double-type? 'double)
;;> > #t
;;>}
(define (c-double-type? type)
  (or (equal? type 'double)
      (equal? type 'ldouble)))

;;>\pre{
;;> Returns #t if given type is C signed type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-signed-type? 'i8)
;;> > #t
;;> (c-signed-type? 'u8)
;;> > #f
;;>}
(define (c-signed-type? type)
  (or (equal? type 'i8)
      (equal? type 'i16)
      (equal? type 'i32)
      (equal? type 'i64)
      (equal? type 'char)
      (equal? type 'short)
      (equal? type 'int)
      (equal? type 'long)
      (equal? type 'llong)
      (equal? type 'float)
      (equal? type 'double)
      (equal? type 'ldouble)))

;;>\pre{
;;> Returns #t if given type is C pointer type, otherwise returns #f
;;>
;;> Example:
;;>
;;> (c-pointer-type? 'pointer)
;;> > #t
;;>}
(define (c-pointer-type? type) (equal? type 'pointer))

;;>\subsection{Size}

;;>\pre{
;;> Returns the size of given type.
;;>
;;> Example:
;;>
;;> (c-type-size 'i8)
;;> > 1
;;> (define-c-array-type items 'i8)
;;> (c-type-size items)
;;> > 1
;;> (define-c-array-type color '((r u8) (g u8) (b u8)))
;;> (c-type-size color)
;;> > 3
;;>}
(define (c-type-size type)
  (cond ((equal? type 'void) 0)
        ((equal? type 'i8) 1)
        ((equal? type 'u8) 1)
        ((equal? type 'i16) 2)
        ((equal? type 'u16) 2)
        ((equal? type 'i32) 4)
        ((equal? type 'u32) 4)
        ((equal? type 'i64) 8)
        ((equal? type 'u64) 8)
        ((equal? type 'char) 1)
        ((equal? type 'uchar) 1)
        ((equal? type 'short) 2)
        ((equal? type 'ushort) 2)
        ((equal? type 'int) 4)
        ((equal? type 'uint) 4)
        ((equal? type 'long) 8)
        ((equal? type 'ulong) 8)
        ((equal? type 'llong) 16)
        ((equal? type 'ullong) 16)
        ((equal? type 'float) 4)
        ((equal? type 'double) 8)
        ((equal? type 'ldouble) 16)
        ((equal? type 'pointer) 8)
        ((c-array-type? type) (internal-array-type-size type))
        ((c-struct-type? type) (c-struct-type-size type))
        ;((assoc type c-struct-type-list) (c-type-size (cdr (assoc type c-struct-type-list))))
        (else (error "c-type-size: Unknown type" type))))

;;>\pre{
;;> Adds given types together and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-size+ 'u8 'u8)
;;> > 2
;;>}
(define c-type-size+ (lambda types (apply + (map c-type-size types))))
;;>\pre{
;;> Subtracts given types and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-size- 'int 'u8)
;;> > 3
;;>}
(define c-type-size- (lambda types (apply - (map c-type-size types))))
;;>\pre{
;;> Divides given type with n and retursn the result.
;;>
;;> Example:
;;>
;;> (c-type-size/ 'int 2)
;;> > 2
;;>}
(define (c-type-size/ type n) (/ (c-type-size type) n))
;;>\pre{
;;> Multiplies given type with n and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-size* 'int 10)
;;> > 40
;;>}
(define (c-type-size* type n) (* (c-type-size type) n))

;;>\subsection{Alignment}

;;>\pre{
;;> Returns the align of given type.
;;>
;;> Example:
;;>
;;> (c-type-align 'int)
;;> > 4
;;>}
(define (c-type-align type)
  (cond ((equal? type 'i8) 1)
        ((equal? type 'u8) 1)
        ((equal? type 'i16) 2)
        ((equal? type 'u16) 2)
        ((equal? type 'i32) 4)
        ((equal? type 'u32) 4)
        ((equal? type 'i64) 8)
        ((equal? type 'u64) 8)
        ((equal? type 'char) 1)
        ((equal? type 'uchar) 1)
        ((equal? type 'short) 2)
        ((equal? type 'ushort) 2)
        ((equal? type 'int) 4)
        ((equal? type 'uint) 4)
        ((equal? type 'long) 8)
        ((equal? type 'ulong) 8)
        ((equal? type 'llong) 16)
        ((equal? type 'ullong) 16)
        ((equal? type 'float) 4)
        ((equal? type 'double) 8)
        ((equal? type 'ldouble) 16)
        ((equal? type 'pointer) 8)
        ((c-array-type? type) (internal-array-type-size type))
        ((c-struct-type? type) (c-struct-type-size type))
        ;((assoc type c-struct-type-list) (c-type-size (cdr (assoc type c-struct-type-list))))
        (else (error "c-type-align: Unknown type" type))))

;;>\pre{
;;> Adds given aligns together and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-align+ 'u8 'u8)
;;> > 2
;;>}
(define c-type-align+ (lambda types (apply + (map c-type-align types))))
;;>\pre{
;;> Subtracts given aligns and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-align- 'int 'u8)
;;> > 3
;;>}
(define c-type-align- (lambda types (apply - (map c-type-align types))))
;;>\pre{
;;> Multiples given align with n and returns the result.
;;>
;;> Example:
;;>
;;> (c-type-align* 'int 100)
;;> > 400
;;>}
(define (c-type-align* type n) (* (c-type-align type) n))
;;>\pre{
;;> Divides given align with n and retursn the result.
;;>
;;> Example:
;;>
;;> (c-type-align/ 'int 2)
;;> > 2
;;>}
(define (c-type-align/ type n) (/ (c-type-align type) n))
