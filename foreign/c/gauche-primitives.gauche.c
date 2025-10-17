#include <math.h>
#include <stdint.h>
#include <gauche.h>
#include <gauche/extend.h>
#include <gauche/module.h>
#include <gauche/load.h>
#include <gauche/number.h>
#include <gauche/string.h>
#include <gauche-primitives.gauche.h>
#include <ffi.h>
#include <dlfcn.h>

void gauche_primitives_init(void) { puts("Hello from init"); }

extern ScmObj hello() { return Scm_MakeInteger(1); }
