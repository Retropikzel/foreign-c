(define pffi-init (lambda () #t))

(define pffi-size-of
  (lambda (type)
    (cond ((eq? type 'int8) 1) ; FIXME
          ((eq? type 'uint8) 1) ; FIXME
          ((eq? type 'int16) 2) ; FIXME
          ((eq? type 'uint16) 2) ;FIXME
          ((eq? type 'int32) 4) ; FIXME
          ((eq? type 'uint32) 4) ; FIXME
          ((eq? type 'int64) 8) ; FIXME
          ((eq? type 'uint64) 8) ; FIXME
          ((eq? type 'char) size-of-bool)
          ((eq? type 'unsigned-char) size-of-bool)
          ((eq? type 'short) size-of-short)
          ((eq? type 'unsigned-short) size-of-unsigned-short)
          ((eq? type 'int) size-of-int)
          ((eq? type 'unsigned-int) size-of-unsigned-int)
          ((eq? type 'long) size-of-long)
          ((eq? type 'unsigned-long) size-of-unsigned-long)
          ((eq? type 'float) size-of-float)
          ((eq? type 'double) size-of-double)
          ((eq? type 'pointer) size-of-pointer)
          (else (error "Can not get size of unknown type" type)))))

(define pffi-shared-object-load
  (lambda (header path)
    (open-shared-library path)))

(define pffi-pointer-null
  (lambda ()
    #f)) ; TODO

(define pffi-pointer-null?
  (lambda (pointer)
    (if (equal? pointer #f) #t #f))) ; TODO

