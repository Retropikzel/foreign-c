CC=gcc

chibi-pffi.so: chibi/pffi.stub
	chibi-ffi chibi/pffi.stub
	${CC} -g3 -o chibi-pffi.so chibi/pffi.c -fPIC -lffi -shared

gauche-pffi.so:
	gauche-package compile \
		--srcdir=gauche \
		--cc=${CC} \
		--cflags="-I./include" \
		--libs=-lffi \
		gauche-pffi gauche-pffi.c gauchelib.scm
