(define-module retropikzel.pffi.gauche
               (export spigot-calculate-pi
                       spigot-calculate-e))
(select-module retropikzel.pffi.gauche)

(dynamic-load "retropikzel-pffi-gauche")
;(define-module retropikzel.pffi.gauche (export pffi-foo))

;(dynamic-load "retropikzel/pffi/pffi-gauche" :init-function "Scm__Init_pffi_2dgauche")
;(select-module pffi-gauche)

;(pffi-foo 10)

#;(define size-of-type
  (lambda (type)
    (cond ((equal? type 'int8) 1))))
