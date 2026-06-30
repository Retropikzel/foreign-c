(define-record-type <c-struct-type>
  (internal-make-c-struct-type name size members)
  c-struct-type?
  (name c-struct-type-name)
  (size c-struct-type-size)
  (members c-struct-type-members))

(define (calculate-struct-members members . return-just-size)
  (letrec* ((size 0)
            (largest-member-size 0)
            (round-to-next-modulo-of
              (lambda (to-round roundee)
                (if (= (modulo to-round roundee) 0)
                  to-round
                  (round-to-next-modulo-of (+ to-round 1) roundee))))
            (data (map (lambda (memb)
                         (let* ((name (car memb))
                                (type (cadr memb))
                                (type-size (c-type-size type))
                                (type-alignment (c-type-align type)))
                           (when (> type-size largest-member-size)
                             (set! largest-member-size type-size))
                           (if (or (= size 0)
                                   (= (modulo size type-alignment) 0))
                             (begin
                               (set! size (+ size type-alignment))
                               (list name type (- size type-alignment)))
                             (let ((next-alignment
                                     (round-to-next-modulo-of size type-alignment)))
                               (set! size (+ next-alignment type-alignment))
                               (list name type next-alignment)))))
                       members)))
    (if (null? return-just-size)
      data
      size)))

(define (internal-c-struct-type-member type name)
  (assq name (c-struct-type-members type)))

(define-syntax define-c-struct-type
  (syntax-rules ()
    ((_ name members)
       (define name
         (internal-make-c-struct-type 'name
                                      (calculate-struct-members members #t)
                                      (calculate-struct-members members))))))
