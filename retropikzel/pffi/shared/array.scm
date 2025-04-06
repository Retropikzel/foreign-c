(define pffi-list->array
  (lambda (type list-arg)
    (let* ((type-size (pffi-size-of type))
           (array (pffi-pointer-allocate (* type-size (length list-arg))))
           (offset 0))
      (for-each
        (lambda (item)
          (pffi-pointer-set! array type offset item)
          (set! offset (+ offset type-size)))
        list-arg)
      array)))

(define pffi-array->list
  (lambda (type array size)
    (letrec* ((type-size (pffi-size-of type))
              (max-offset (* type-size size))
              (looper (lambda (offset result)
                        (if (= offset max-offset)
                          result
                          (looper (+ offset type-size)
                                  (append result (list (pffi-pointer-get array type offset))))))))
      (looper 0 (list)))))
