VERSION=0.13.6
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main

all: build

build:
	@rm -rf *.tgz
	@echo "<pre>$$(cat README.md)</pre>" > README.html
	@snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

init-venv: build
	@rm -rf venv
	@scheme-venv ${SCHEME} ${RNRS} venv
	@echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > venv/test.scm
	@echo "(import (rnrs) (srfi :64) (foreign c))" > venv/test.sps
	@cat tests/${TEST}.scm >> venv/test.scm
	@cat tests/${TEST}.scm >> venv/test.sps
	@if [ "${RNRS}" = "r6rs" ]; then cp -r foreign venv/lib/; fi
	@if [ "${SCHEME}" = "chezscheme" ]; then ./venv/bin/akku install akku-r7rs chez-srfi; fi
	@if [ "${SCHEME}" = "ikarus" ]; then ./venv/bin/akku install akku-r7rs chez-srfi; fi
	@if [ "${SCHEME}" = "ironscheme" ]; then ./venv/bin/akku install akku-r7rs chez-srfi; fi
	@if [ "${SCHEME}-${RNRS}" = "ypsilon-r6rs" ]; then ./venv/bin/akku install akku-r7rs chez-srfi; fi
	@if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/akku install; fi
	@if [ "${SCHEME}" = "chicken" ]; then ./venv/bin/snow-chibi install --always-yes srfi.64; fi
	@if [ "${SCHEME}-${RNRS}" = "mosh-r7rs" ]; then ./venv/bin/snow-chibi install --always-yes srfi.64; fi
	#@if [ -d ../foreign-c ]; then make -C ../foreign-c build && ./venv/bin/snow-chibi install --always-yes ../foreign-c/*.tgz; fi
	@if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/snow-chibi install --always-yes ${PKG}; fi

run-test: init-venv venv/include/libtest.h venv/lib/libtest.o venv/lib/libtest.so venv/lib/libtest.a
	if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-compile venv/test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then VENV_CSC_ARGS="-L -ltest" ./venv/bin/scheme-compile venv/test.scm; fi
	LD_LIBRARY_PATH=venv/lib ./venv/test

run-test-docker: venv
	#docker build --build-arg SCHEME=${SCHEME} --tag=foreign-c-${SCHEME}-${RNRS} -f Dockerfile.test .
	#docker run schemers/${SCHEME}:head foreign-c-${SCHEME}-${RNRS} sh -c ". venv/bin/activate && make SCHEME=${SCHEME} RNRS=${RNRS} run-test"
	#docker run -v "${PWD}:${PWD}" -w "${PWD}" schemers/${SCHEME}:head sh -c "apt-get update && apt-get install -y make && make SCHEME=${SCHEME} RNRS=${RNRS} run-test"

## C libraries for testing

venv/lib/libtest.o: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o venv/lib/libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

venv/lib/libtest.so: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o venv/lib/libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

venv/lib/libtest.a: libtest.o tests/c-src/libtest.c
	@ar rcs libtest.a libtest.o ${LDFLAGS}

venv/include/libtest.h: tests/c-include/libtest.h
	@cp tests/c-include/libtest.h venv/include/libtest.h

clean:
	git clean -X -f
	rm -rf .akku
	rm -rf venv
