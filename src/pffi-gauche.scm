(in-module pffi)

(inline-stub
  (.include "pffi-gauche.h")
  (define-cproc foo (x::<int>) foo))

