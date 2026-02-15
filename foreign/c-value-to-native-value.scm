(define (value->native-value value)
  (if (c-bytevector? value)
    (c-bytevector-pointer value)
    value))
