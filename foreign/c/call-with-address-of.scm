;;>\section{Call with address of (C &)}

;;>\pre{
;;> Calls thunk with address c-bytevector of c-bytevector.
;;>
;;> Since the support for calling C functions taking pointer address arguments,
;;> ones prefixed with & in C, varies, some additional ceremony is needed on
;;> the Scheme side.
;;>
;;> Example:
;;>
;;> Calling from C:
;;>
;;>     //void func(int** i);
;;>     func(&i);
;;>
;;> Calling from Scheme:
;;>
;;>     (define cbv (make-bytevector (c-type-size 'int)))
;;>     (call-with-address-of
;;>      cbv
;;>      (lambda (address)
;;>       (func address)))
;;>     ; Use cbv here
;;> The passed c-bytevector, in example named cbv, should only be used **after**
;;> call to call-with-addres-of ends.
;;>}
(define-syntax call-with-address-of
  (syntax-rules ()
    ((_ cbv thunk)
     (let ((address-cbv (make-c-bytevector (c-type-size 'pointer))))
       (c-bytevector-set! address-cbv 'pointer 0 cbv)
       (when (not (c-bytevector? cbv))
         (error "call-with-address-of: cbv argument must be c-bytevector" cbv))
       (when (not (procedure? thunk))
         (error "call-with-address-of: thunk argument must be procedure" thunk))
       (let ((result (apply thunk (list address-cbv))))
         (set! cbv (c-bytevector-ref address-cbv 'pointer 0))
         (c-bytevector-free address-cbv)
         result)))))
