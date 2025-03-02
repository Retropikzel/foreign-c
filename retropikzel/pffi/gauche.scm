(dynamic-load "retropikzel/pffi/pffi-gauche" :init-function "Scm__Init_pffi_gauche")

(foo 10)

(define size-of-type
  (lambda (type)
    (cond ((equal? type 'int8) 1))))
