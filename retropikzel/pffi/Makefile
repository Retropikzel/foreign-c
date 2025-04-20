CC=gcc

chibi: chibi-src/pffi.stub
	chibi-ffi chibi-src/pffi.stub
	${CC} -g3 -o chibi-pffi.so chibi-src/pffi.c -fPIC -lffi -shared

gauche: gauche-src/gauche-pffi.c gauche-src/gauchelib.scm
	gauche-package compile \
		--srcdir=gauche-src \
		--cc=${CC} \
		--cflags="-I./include" \
		--libs=-lffi \
		gauche-pffi gauche-pffi.c gauchelib.scm
