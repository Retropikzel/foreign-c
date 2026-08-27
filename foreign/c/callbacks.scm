;;>\section{C Callbacks}

;;>\macro{(define-c-callback scheme-name return-type argument-types procedure)}
;;>\pre{
;;> Takes scheme-name to bind the Scheme procedure to, return-type,
;;> argument-types and procedure as in place lambda.
;;>
;;> Defines a new Sceme function to be used as callback to C code.
;;>}

;;>\subsection{Callback utilities}
;;>\pre{
;;> This procedure can be used inside the callback to make c-bytevector out of
;;> C pointer.
;;>}
(define pointer->c-bytevector foreign-c-internal-make-c-bytevector)
