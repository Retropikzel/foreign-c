.DEFAULT: all
.POSIX:
VERSION=0.23.3
SCHEME=chibi
PKG=foreign-c-${VERSION}.tgz
CC=gcc
DOCKER_TAG=latest

all: package

package:
	snow-chibi package \
		--always-yes \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc-from-scribble=1 \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install --always-yes ${PKG}

test: libtest.so libtest.o libtest.a
	rm -rf test-program
	CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" \
	COMPILE_R7RS=${SCHEME} \
		compile-r7rs -o test-program tests/test.scm
	LD_LIBRARY_PATH=. ./test-program

test-r6rs: libtest.so libtest.o libtest.a
	rm -rf test-program
	echo "(import (rnrs) (foreign c) (srfi :0) (srfi :64))" > tests/test.sps
	tail -n+12 tests/test.scm >> tests/test.sps
	akku install akku-r7rs chez-srfi
	CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" \
	COMPILE_R7RS=${SCHEME} \
		compile-r7rs -o test-program -I .akku/lib tests/test.sps
	LD_LIBRARY_PATH=. ./test-program

test-docker:
	rm -rf test-program
	DOCKER_TAG=${DOCKER_TAG} \
	APT_PACKAGES="make gcc libffi-dev" \
	SNOW_PACKAGES="srfi.64 retropikzel.tap ${PKG}" \
	COMPILE_R7RS=${SCHEME} \
	CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" \
	LD_LIBRARY_PATH=. \
	SCM_TAP_NO_EXIT_FAIL=1 \
	PASS_ENV_VARS="CSC_OPTIONS LD_LIBRARY_PATH SCM_TAP_NO_EXIT_FAIL" \
		test-r7rs -o test-program tests/test.scm

test-docker-r6rs:
	rm -rf test-program
	DOCKER_TAG=${DOCKER_TAG} \
	APT_PACKAGES="make gcc libffi-dev" \
	SNOW_PACKAGES="${PKG}" \
	AKKU_PACKAGES="akku-r7rs chez-srfi" \
	COMPILE_R7RS=${SCHEME} \
	CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" \
	LD_LIBRARY_PATH=. \
	SCM_TAP_NO_EXIT_FAIL=1 \
	PASS_ENV_VARS="CSC_OPTIONS LD_LIBRARY_PATH SCM_TAP_NO_EXIT_FAIL" \
		test-r7rs -I .akku/lib -o test-program tests/test.sps

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
