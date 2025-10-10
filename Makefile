.PHONY: package test libtest.o tests/libtest.so libtest.a documentation README.html
SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.10.9
CC=gcc
PKG=foreign-c-${VERSION}.tgz

ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif

all: package

package: README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
		--test=test.scm \
	foreign/c.sld

README.html: README.md
	echo "<pre>$$(cat README.md)</pre>" > README.html

install:
	snow-chibi --impls=${SCHEME} ${SNOW_CHIBI_ARGS} install foreign-c-${VERSION}.tgz; \
	if [ "${SCHEME}" = "gauche" ]; then \
		make gauche; \
		sudo cp foreign/c/primitives/gauche.scm $(shell gauche-config --sitelibdir)/foreign/c/primitives/;\
		sudo mkdir -p $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
		sudo cp -r foreign/c/lib/gauche.so $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
	fi

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test: libtest.o libtest.so libtest.a
	rm -rf test
	COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		COMPILE_R7RS=${SCHEME} compile-r7rs -o test test.scm
	./test

test-no: package libtest.o libtest.so libtest.a
	COMPILE_R7RS=${SCHEME} test-snowball --apt-pkgs "libffi-dev" ${PKG}

test-docker:
	docker run -it -v "${PWD}:/workdir" -w /workdir retropikzel1/compile-r7rs sh -c \
		"make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes install test"

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

chibi: foreign/c/primitives/chibi/foreign-c.stub
	chibi-ffi foreign/c/primitives/chibi/foreign-c.stub
	${CC} \
		${CFLAGS} \
		-g3 \
		-o foreign/c/primitives/chibi/foreign-c.so \
		foreign/c/primitives/chibi/foreign-c.c \
		-fPIC \
		-lffi \
		-shared

gauche:
	gauche-package compile \
		--srcdir=foreign/c/primitives/gauche \
		--cc=${CC} \
		--cflags="${CFLAGS} -I.foreign/c/primitives/gauche" \
		--libs=-lffi \
		foreign-c-primitives-gauche foreign-c-primitives-gauche.c gauchelib.scm
	mkdir -p foreign/c/lib
	mv foreign-c-primitives-gauche.so foreign/c/lib/gauche.so
	mv foreign-c-primitives-gauche.o foreign/c/lib/gauche.o

clean:
	find . -name "*.meta" -delete
	find . -name "*.link" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	rm -rf tmp
	rm -rf foreign/c/primitives/chibi/foreign-c.c
	rm -rf foreign/c/lib
	rm -rf *.tgz
	rm -rf README.html
