CC=gcc

chibi-pffi.so: chibi/pffi.stub
	chibi-ffi chibi/pffi.stub
	${CC} -g3 -o chibi-pffi.so chibi/pffi.c -fPIC -lffi -shared
