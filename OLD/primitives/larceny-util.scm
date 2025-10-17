;; Copied from Larceny source
;; Copyright 1998 Lars T Hansen.
;; Copied code begins

(define %set32u)

; %peek* and %poke*: convenient access to values in memory.

(define (%peek8 addr)
  (let ((x (make-bytevector 1)))
    (peek-bytes addr x 1)
    (let ((v (bytevector-ref x 0)))
      (if (> v 127)
        (- (- 256 v))
        v))))

(define (%peek16 addr)
  (let ((x (make-bytevector 2)))
    (peek-bytes addr x 2)
    (%get16 x 0)))

(define (%peek32 addr)
  (let ((x (make-bytevector 4)))
    (peek-bytes addr x 4)
    (%get32 x 0)))

(define (%peek8u addr)
  (let ((x (make-bytevector 1)))
    (peek-bytes addr x 1)
    (bytevector-ref x 0)))

(define (%peek16u addr)
  (let ((x (make-bytevector 2)))
    (peek-bytes addr x 2)
    (%get16u x 0)))

(define (%peek32u addr)
  (let ((x (make-bytevector 4)))
    (peek-bytes addr x 4)
    (%get32u x 0)))

(define (%poke8 addr val)
  (let ((x (make-bytevector 1)))
    (if (< val 0)
      (bytevector-set! x 0 (+ 256 val))
      (bytevector-set! x 0 val))
    (poke-bytes addr x 1)))

(define (%poke16 addr val)
  (let ((x (make-bytevector 2)))
    (%set16 x 0 val)
    (poke-bytes addr x 2)))

(define (%poke32 addr val)
  (let ((x (make-bytevector 4)))
    (%set32 x 0 val)
    (poke-bytes addr x 4)))

(define (%poke8u addr val)
  (let ((x (make-bytevector 1)))
    (bytevector-set! x 0 val)
    (poke-bytes addr x 1)))

(define (%poke16u addr val)
  (let ((x (make-bytevector 2)))
    (%set16u x 0 val)
    (poke-bytes addr x 2)))

(define (%poke32u addr val)
  (let ((x (make-bytevector 4)))
    (%set32u x 0 val)
    (poke-bytes addr x 4)))

(define %peek-int %peek32)
(define %peek-long %peek32)
(define %peek-uint %peek32u)
(define %peek-ulong %peek32u)
(define %peek-short %peek16)
(define %peek-ushort %peek16u)
(define %peek-pointer %peek32u)

(define %poke-int %poke32)
(define %poke-long %poke32)
(define %poke-uint %poke32u)
(define %poke-ulong %poke32u)
(define %poke-short %poke16)
(define %poke-ushort %poke16u)
(define %poke-pointer %poke32u)
