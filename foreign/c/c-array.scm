;;>\subsection{Arrays}

(define-record-type <c-array-type>
  (internal-make-c-array-type name type)
  internal-c-array-type?
  (name c-array-type-name)
  (type c-array-type-type))

;;> Returns #t if given type is C array type, otherwise returns #f
;;> Example:
;;>
;;>\pre{
;;> (define-c-array-type items 'i8)
;;> (c-integer-type? items)
;;> > #t
;;>}
;;>
(define (c-array-type? type) (internal-c-array-type? type))

;;>\pre{
;;> Creates a new C array type that can be used when accessing c-bytevectors.
;;> name is the name of the type and type is the type of items.
;;>
;;> Example:
;;>
;;>     (define-c-array-type i8-array 'i8)
;;>     (define ar1 (make-c-bytevector (* (c-type-size i8-array) 10)))
;;>     (c-bytevector-set! ar1 i8-array 5 25) ; Set the 5th item of array to 25
;;>     (write (c-bytevector-ref ar1 i8-array 5))
;;>     > 25
;;>}
(define-syntax define-c-array-type
  (syntax-rules ()
    ((_ name type)
     (define name (internal-make-c-array-type 'name type)))))

(define (internal-array-type-size type)
  (c-type-size (c-array-type-type type)))
