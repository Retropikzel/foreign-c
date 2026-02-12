(define (round-to-next-modulo-of to-round roundee)
  (if (= (modulo to-round roundee) 0)
    to-round
    (round-to-next-modulo-of (+ to-round 1) roundee)))

(define (calculate-struct-members members . return-just-size)
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
      size)))

(define calculate-struct-size
  (lambda (members)
    (calculate-struct-members members #t)))

(define-syntax define-c-struct
  (syntax-rules ()
    ((_ name members struct-size-variable struct-cbv (field-name field-type accessor modifier) ...)
     (begin
       (when (not (or (equal? struct-cbv #f)
                      (c-bytevector? struct-cbv)))
         (error "define-c-struct: struct-cbv argument must be c-bytevector or #f"
                struct-cbv))
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
