;; generated automatically.  DO NOT EDIT
#!no-fold-case
(define-module foreign.c.primitives.gauche (export size-of-type shared-object-load c-bytevector-u8-set! c-bytevector-u8-ref c-bytevector-pointer-set! c-bytevector-pointer-ref pointer-null? c-bytevector? c-free define-c-callback dlerror dlsym internal-ffi-call))
(select-module foreign.c.primitives.gauche)
(dynamic-load "gauche-primitives.so")
(define-syntax define-c-callback (syntax-rules () ((_ scheme-name return-type argument-types procedure) (define scheme-name (make-c-callback return-type 'argument-types procedure)))))
