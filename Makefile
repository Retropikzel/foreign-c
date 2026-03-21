VERSION=0.14.0
SCHEME=chibi
DOCKER_TAG=latest
IMAGE=${SCHEME}:${DOCKER_TAG}
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main

SNOW=snow-chibi --impls=${SCHEME} install --always-yes
SFX=scm
LIB_PATHS=
ifeq "${RNRS}" "r6rs"
SNOW=snow-chibi --impls=${SCHEME} install --always-yes --install-source-dir=. --install-library-dir=.
SFX=sps
LIB_PATHS=-I .akku/lib
endif

all: build

build:
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--always-yes \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install --always-yes foreign.c

test: libtest.so libtest.o libtest.a build
	# tmpdir
	mkdir -p .tmp
	cp -r libtest.so libtest.o libtest.a tests/c-include/libtest.h foreign .tmp/
	mkdir -p logs/${RNRS}
	# R6RS files
	printf "#!r6rs\n(import (rnrs) (srfi :64) (foreign c))\n" > .tmp/test.sps
	cat tests/${TEST}.scm >> .tmp/test.sps
	# R7RS testfiles
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > .tmp/test.scm
	cat tests/${TEST}.scm >> .tmp/test.scm
	# Tests
	cd .tmp && ${SNOW} srfi.64
	cd .tmp && ${SNOW} ../${PKG}
	cd .tmp && akku install akku-r7rs 2> /dev/null
	rm -rf .tmp/test
	cd .tmp && COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I." compile-r7rs ${LIB_PATHS} test.${SFX}
	cd .tmp && LD_LIBRARY_PATH=. ./test

test-docker:
	docker build --build-arg SCHEME=${SCHEME} --build-arg IMAGE=${IMAGE} -f Dockerfile.test --tag=${SCHEME}-testing .
	docker run -v "${PWD}/logs:/workdir/logs" -w /workdir ${SCHEME}-testing sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} TEST=${TEST} test"

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
