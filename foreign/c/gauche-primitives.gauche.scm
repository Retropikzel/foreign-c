(in-module gauche-primitives)

(inline-stub
  (declcode "#include <stdio.h>")
  (declcode "#include <ffi.h>")

  (declcode "void Scm_Init_foreign_c_gauche_primitives_internal(void) { puts(\"Hello from init\"); }")

  (declcode "ScmObj hello() { return Scm_MakeInteger(1); }")

  (define-cproc hello-lol () hello))


