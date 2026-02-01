VERSION=0.13.6
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
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} --always-yes install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

init-venv: build
	rm -rf venv
	scheme-venv ${SCHEME} ${RNRS} venv
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > venv/test.scm
	echo "(import (rnrs) (srfi :64) (foreign c))" > venv/test.sps
	cat tests/${TEST}.scm >> venv/test.scm
	cat tests/${TEST}.scm >> venv/test.sps
	cp -r foreign venv/lib
	if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/snow-chibi install --always-yes srfi.64; fi
	if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/snow-chibi install --always-yes ${PKG}; fi
	./venv/bin/akku install akku-r7rs chez-srfi

run-test: libtest.o libtest.so libtest.a init-venv
	if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-compile venv/test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/scheme-compile venv/test.scm; fi
	./venv/test

run-test-docker: init-venv
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test .
	#docker run foreign-c-${SCHEME}-${RNRS} sh -c ". venv/bin/activate && make SCHEME=${SCHEME} RNRS=${RNRS} run-test"

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
	rm -rf .akku
	rm -rf venv
