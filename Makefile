VERSION=0.14.0
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main

all: build

build:
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install --skip-tests?=1 ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

SNOW=snow-chibi install --impls=${SCHEME} --skip-tests?=1 --always-yes --install-source-dir=.tmp/snow --install-library-dir=.tmp/snow
.tmp/snow:
	mkdir -p .tmp
	${SNOW} srfi.39
	${SNOW} srfi.64
	${SNOW} srfi.145
	${SNOW} srfi.180
	${SNOW} retropikzel.ctrf

test: libtest.so libtest.o libtest.a build .tmp/snow
	cp libtest.so .tmp/
	cp libtest.o .tmp/
	cp libtest.a .tmp/
	cp tests/c-include/libtest.h .tmp/
	mkdir -p logs/${RNRS}
	echo "(import (except (rnrs) remove) (srfi :64) (retropikzel ctrf) (foreign c))" > .tmp/test.sps
	echo "(test-runner-current (ctrf-runner))" >> .tmp/test.sps
	cat tests/${TEST}.scm >> .tmp/test.sps
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (retropikzel ctrf) (foreign c))" > .tmp/test.scm
	echo "(test-runner-current (ctrf-runner))" >> .tmp/test.scm
	cat tests/${TEST}.scm >> .tmp/test.scm
	${SNOW} ${PKG}
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && akku install akku-r7rs; fi
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && COMPILE_R7RS=${SCHEME} compile-r7rs -I .akku/lib test.sps; fi
	rm -rf .tmp/test
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I." compile-r7rs -I .akku/lib test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then cd .tmp && COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I." compile-r7rs -I snow test.scm; fi
	cd .tmp && LD_LIBRARY_PATH=. ./test
	mv -f .tmp/*.json logs/${RNRS}/

test-docker:
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test --tag=${SCHEME}-testing .
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
