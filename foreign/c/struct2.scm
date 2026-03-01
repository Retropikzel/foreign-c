(define (round-to-next-modulo-of to-round roundee)
  (if (= (modulo to-round roundee) 0)
    to-round
    (round-to-next-modulo-of (+ to-round 1) roundee)))

(define (calculate-struct-members members . return-just-size)
  (let*
    ((size 0)
     (largest-member-size 0)
     (data (map (lambda (memb)
                  (let* ((name (car memb))
                         (type (cdr memb))
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

(define calculate-struct-size
  (lambda (members)
    (calculate-struct-members members #t)))

(define (internal-c-struct-type-member type name)
  (assq name (c-struct-type-members type)))
