(import (scheme base)
        (scheme write)
        (scheme file)
        (scheme process-context)
        (arvyy mustache))

(define slurp-loop
  (lambda (line result)
    (if (eof-object? line)
      result
      (slurp-loop (read-line) (string-append result line (string #\newline))))))

(define slurp
  (lambda (path)
    (with-input-from-file
      path
      (lambda ()
        (slurp-loop (read-line) "")))))

(define script-implementations
  (vector "chibi"
          "chicken"
          "cyclone"
          "gambit"
          "gauche"
          ;"gauche-wine" TODO
          "gerbil"
          "guile"
          "kawa"
          ;"meevax" TODO
          "mosh"
          "racket"
          "racket-wine"
          "sagittarius"
          ;"sagittarius-wine" TODO
          "stklos"
          "skint"
          "tr7i"
          "ypsilon"))

 (define compiler-implementations
  (vector "chicken"
          "cyclone"
          "gambit"
          "gauche"
          "gerbil"
          "kawa"
          "racket"
          ;"racket-wine" TODO
          ))

;; Jenkinsfile
(call-with-output-file
  "Jenkinsfile"
  (lambda (out)
    (execute (compile (slurp "templates/Jenkinsfile"))
             (list (cons 'script-implementations script-implementations)
                   (cons 'compiler-implementations compiler-implementations))
             out)))
