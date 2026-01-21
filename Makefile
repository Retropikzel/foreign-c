.PHONY: \
	package test libtest.o tests/libtest.so libtest.a documentation \
	README.html test-r6rs.sps test-r6rs test-r6rs-primitives.sps \
	test-r6rs-primitives test-r7rs.scm test-r7rs test-r7rs-primitives.scm \
	test-r7rs-primitives foreign/c/chibi-primitives.so \
	libtest.o libtest.a libtest.so
.SILENT: build install clean test-r6rs.sps test-r6rs test-r6rs-primitives.sps \
	test-r6rs-primitives test-r6rs-docker test-r7rs.scm test-r7rs \
	test-r7rs-primitives.scm test-r7rs-primitives test-r7rs-docker \
	libtest.o libtest.a libtest.so

SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.13.4
PKG=foreign-c-${VERSION}.tgz
CC=gcc
PKG=foreign-c-${VERSION}.tgz
ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif

DOCKER_TAG=foreign-c-test-${SCHEME}

## Build and install

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

## R6RS Tests

Akku.manifest:
	akku install chez-srfi akku-r7rs

snow:
	snow-chibi install --impls=generic --install-prefix=${PWD} --always-yes retropikzel.ctrf
	rm -rf srfi/64.*

test-r6rs: libtest.o libtest.so libtest.a snow Akku.manifest
	printf "#!r6rs\n(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (rnrs programs) (foreign c)  (retropikzel ctrf) (srfi :64) (only (rnrs bytevectors) make-bytevector bytevector?))\n" > test-r6rs.sps
	echo "(test-runner-current (ctrf-runner))" >> test-r6rs.sps
	echo "(test-begin \"foreign-c-r6rs\")" >> test-r6rs.sps
	cat test.scm >> test-r6rs.sps
	echo "(test-end \"foreign-c-r6rs\")" >> test-r6rs.sps
	COMPILE_SCHEME=${SCHEME} test-scheme foreign retropikzel srfi libtest.o libtest.so libtest.a Akku.manifest test-r6rs.sps

## R7RS Tests

foreign/c/chibi-primitives.so:
	chibi-ffi foreign/c/chibi-primitives.stub
	gcc -fPIC -shared \
		-Os \
		-o foreign/c/chibi-primitives.so \
		foreign/c/chibi-primitives.c \
	-lffi -lchibi-scheme

test-r7rs: libtest.o libtest.so libtest.a foreign/c/chibi-primitives.so
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context)  (retropikzel ctrf) (srfi 64) (foreign c))" > test-r7rs.scm
	echo "(test-runner-current (ctrf-runner))" >> test-r7rs.scm
	echo "(test-begin \"foreign-c-r7rs\")" >> test-r7rs.scm
	cat test.scm >> test-r7rs.scm
	echo "(test-end \"foreign-c-r7rs\")" >> test-r7rs.scm
	COMPILE_SCHEME=${SCHEME} test-scheme foreign libtest.o libtest.so libtest.a test-r7rs.scm

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
