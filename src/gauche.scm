(use gauche.cgen)

(define unit (make <cgen-unit> :name "pffi-gauche"))
(cgen-current-unit unit)


(cgen-decl "#include <ffi.h>")
(cgen-decl "#include <stdio.h>")

(cgen-init "printf(\"initialization function\\n\");")

(cgen-body "void foo(int n) { printf(\"got %u\\n\", n); }")

(cgen-extern "void foo(int n);")

;(cgen-extern "void foo(int n);")

#;(parameterize ([cgen-current-unit *unit*])
  (cgen-decl "#include <ffi.h>")
  (cgen-decl "#include <stdio.h>")
  (cgen-body "void foo(int n) { printf(\"got %u\\n\", n); }")
  (cgen-extern "void foo(int n);")
  (cgen-init "printf(\"initialization function\\n\");")
  )

(cgen-emit-c unit)
(cgen-emit-h unit)
