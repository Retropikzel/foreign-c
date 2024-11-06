(define pffi-init (lambda () #t))

(define pffi-size-of
  (lambda (type)
    (cond ((equal? type 'int8) 1))))
