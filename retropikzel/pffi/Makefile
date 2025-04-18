CC=gcc

chibi: chibi-src/pffi.stub
	chibi-ffi chibi-src/pffi.stub
	${CC} -g3 -o chibi-pffi.so chibi-src/pffi.c -fPIC -lffi -shared

chicken:
	@echo "Nothing to build for Chicken"

cyclone:
	@echo "Nothing to build for Cyclone"

gambit:
	@echo "Nothing to build for Gambit"

gauche: gauche-src/gauche-pffi.c gauche-src/gauchelib.scm
	gauche-package compile \
		--srcdir=gauche-src \
		--cc=${CC} \
		--cflags="-I./include" \
		--libs=-lffi \
		gauche-pffi gauche-pffi.c gauchelib.scm

gerbil:
	@echo "Nothing to build for Gerbil"

guile:
	@echo "Nothing to build for Guile"

kawa:
	@echo "Nothing to build for Kawa"

larceny:
	@echo "Nothing to build for Larceny"

mosh:
	@echo "Nothing to build for Mosh"

racket:
	@echo "Nothing to build for Racket"

sagittarius:
	@echo "Nothing to build for Sagittarius"

skint:
	@echo "Nothing to build for Skint"

stklos:
	@echo "Nothing to build for Stklos"

tr7:
	@echo "Nothing to build for tr7"

ypsilon:
	@echo "Nothing to build for Ypsilon"
