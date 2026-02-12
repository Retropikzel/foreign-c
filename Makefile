VERSION=0.13.7
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main

all: build

build:
	rm -rf *.tgz
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld #\
	#foreign/c/struct.sld \
	#foreign/c/stdio.sld

install:
	snow-chibi --impls=${SCHEME} install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

run-test: libtest.so libtest.o libtest.a build
	rm -rf venv
	scheme-venv ${SCHEME} ${RNRS} venv
	echo "(import (rnrs) (srfi :64) (foreign c))" > venv/test.sps
	cat tests/${TEST}.scm >> venv/test.sps
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > venv/test.scm
	cat tests/${TEST}.scm >> venv/test.scm
	cp -r foreign venv/lib
	cp tests/c-include/libtest.h venv/lib/
	cp libtest.so venv/lib/
	cp libtest.a venv/lib
	./venv/bin/snow-chibi install --always-yes ${PKG}
	./venv/bin/akku install akku-r7rs chez-srfi
	#if [ "${SCHEME}" = "chezscheme" ]; then akku install akku-r7rs chez-srfi; fi
	#if [ "${SCHEME}" = "ikarus" ]; then akku install akku-r7rs chez-srfi; fi
	#if [ "${SCHEME}" = "ironscheme" ]; then akku install akku-r7rs chez-srfi; fi
	#if [ "${SCHEME}-${RNRS}" = "ypsilon-r6rs" ]; then akku install akku-r7rs chez-srfi; fi
	#if [ "${RNRS}" = "r6rs" ]; then akku install; fi
	#if [ "${SCHEME}" = "chicken" ]; then snow-chibi install --always-yes srfi.64; fi
	#if [ "${SCHEME}-${RNRS}" = "mosh-r7rs" ]; then snow-chibi install --always-yes srfi.64; fi
	#if [ -d ../foreign-c ]; then make -C ../foreign-c build && snow-chibi install --always-yes ../foreign-c/*.tgz; fi
	#if [ "${RNRS}" = "r7rs" ]; then snow-chibi install --always-yes ${PKG}; fi
	#if [ "${RNRS}" = "r6rs" ]; then scheme-compile r6rs-test.sps; fi
	#if [ "${RNRS}" = "r7rs" ]; then VENV_CSC_ARGS="-L -ltest" scheme-compile r7rs-test.scm; fi
	#if [ "${RNRS}" = "r6rs" ]; then COMPILE_SCHEME=${SCHEME} scheme-compile -I .akku/lib -I . test.sps; fi
	#if [ "${RNRS}" = "r7rs" ]; then VENV_CSC_ARGS="-L -ltest" COMPILE_SCHEME=${SCHEME} compile-scheme test.scm; fi
	if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-compile ./venv/test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then CSC_OPTIONS="-L -ltest -I." ./venv/bin/scheme-compile ./venv/test.scm; fi
	LD_LIBRARY_PATH=. ./venv/test

run-test-docker:
	docker build -f Dockerfile.test --tag=foreign-c-${SCHEME}-${RNRS} .
	docker run -v "${PWD}:/workdir" -w /workdir foreign-c-${SCHEME}-${RNRS} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} run-test"

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	@ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
	rm -rf .akku
