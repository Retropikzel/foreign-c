(define-record-type <pffi-array>
  (array-make type size pointer)
  pffi-array?
  (type pffi-array-type)
  (size pffi-array-size)
  (pointer pffi-array-pointer))

(define pffi-list->array
  (lambda (type list-arg)
    (let* ((array-size (length list-arg))
           (type-size (c-size-of type))
           (array (make-c-bytevector (* type-size array-size)))
           (offset 0))
      (for-each
        (lambda (item)
          (pffi-pointer-set! array type offset item)
          (set! offset (+ offset type-size)))
        list-arg)
      (array-make type array-size array))))

(define pffi-pointer->array
  (lambda (pointer type size)
    (array-make type size pointer)))

(define pffi-array->list
  (lambda (array)
    (letrec* ((type (pffi-array-type array))
              (type-size (c-size-of type))
              (max-offset (* type-size (pffi-array-size array)))
              (array-pointer (pffi-array-pointer array))
              (looper (lambda (offset result)
                        (if (= offset max-offset)
                          result
                          (looper (+ offset type-size)
                                  (append result
                                          (list (pffi-pointer-get array-pointer
                                                                  type
                                                                  offset))))))))
      (looper 0 (list)))))

(define pffi-array-allocate
  (lambda (type size)
    (array-make type size (pffi-pointer-allocate-calloc size (c-size-of type)))))

(define pffi-array-get
  (lambda (array index)
    (let ((type (pffi-array-type array)))
      (pffi-pointer-get (pffi-array-pointer array)
                        type
                        (* (c-size-of type) index)))))

(define pffi-array-set!
  (lambda (array index value)
    (let ((type (pffi-array-type array)))
      (pffi-pointer-set! (pffi-array-pointer array)
                        type
                        (* (c-size-of type) index)
                        value))))
