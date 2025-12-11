# (foreign c)


## Variables

.PHONY: \
	package test libtest.o tests/libtest.so libtest.a documentation \
	README.html test-r6rs.sps test-r6rs test-r6rs-primitives.sps \
	test-r6rs-primitives test-r7rs.scm test-r7rs test-r7rs-primitives.scm \
	test-r7rs-primitives
.SILENT: build install clean test-r6rs test-r6rs-docker test-r6rs-primitives \
	test-r6rs-primitives-docker test-r7rs test-r7rs-docker \
	test-r7rs-primitives  test-r7rs-primitives-docker

SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.12.0
PKG=foreign-c-${VERSION}.tgz
CC=gcc
PKG=foreign-c-${VERSION}.tgz
ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif
ifeq "${SCHEME}" "racket"
DOCKERIMG=${SCHEME}:latest
endif
PRIM_TESTFILES=\
	primitives/size-of-type.scm

ALL_R6RS_EXCEPT=capyscheme larceny
ALL_R7RS_EXCEPT=capyscheme cyclone foment gauche larceny loko meevax \
	mit-scheme skint tr7

TESTFILES= \
	c-type-size.scm \
	define-c-library.scm \
	define-c-procedure.scm \
	make-c-bytevector.scm \
	c-bytevector?.scm \
	c-bytevector-u8-set!.scm \
	c-bytevector-u8-ref.scm \
	c-bytevector-pointer-set!.scm \
	c-bytevector-pointer-ref.scm \
	make-c-null.scm \
	c-null?.scm \
	c-free.scm \
	call-with-address-of.scm \
	bytevector-\>c-bytevector.scm \
	c-bytevector-\>bytevector.scm \
	string-\>c-utf8.scm \
	c-utf8-\>string.scm \
	libc-name.scm \
	c-bytevectors/native-endianness.scm \
	c-bytevectors/c-bytevector-s8-set!.scm \
	c-bytevectors/c-bytevector-s8-ref.scm \
	c-bytevectors/c-bytevector-char-set!.scm \
	c-bytevectors/c-bytevector-char-ref.scm \
	c-bytevectors/c-bytevector-uchar-set!.scm \
	c-bytevectors/c-bytevector-uchar-ref.scm \
	c-bytevectors/c-bytevector-sint-set!.scm \
	c-bytevectors/c-bytevector-sint-ref.scm


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
	foreign/c.sld \
	foreign/c-bytevectors.sld \
	foreign/c/chezscheme-primitives.sld \
	foreign/c/chibi-primitives.sld \
	foreign/c/chicken-primitives.sld \
	foreign/c/gauche-primitives.sld \
	foreign/c/guile-primitives.sld \
	foreign/c/ikarus-primitives.sld \
	foreign/c/ironscheme-primitives.sld \
	foreign/c/kawa-primitives.sld \
	foreign/c/larceny-primitives.sld \
	foreign/c/mosh-primitives.sld \
	foreign/c/racket-primitives.sld \
	foreign/c/sagittarius-primitives.sld \
	foreign/c/stklos-primitives.sld \
	foreign/c/ypsilon-primitives.sld

install:
	snow-chibi --impls=${SCHEME} --always-yes install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"


## R6RS Primitives tests

test-r6rs-primitives.sps:
	printf "#!r6rs\n(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (rnrs programs) (foreign c ${SCHEME}-primitives) (srfi :64) (only (rnrs bytevectors) make-bytevector bytevector?))\n" > test-r6rs-primitives.sps
	echo "(test-begin \"foreign-c-r6rs-primitives\")" >> test-r6rs-primitives.sps
	cd tests && cat ${PRIM_TESTFILES} >> ../test-r6rs-primitives.sps
	echo "(test-end \"foreign-c-r6rs-primitives\")" >> test-r6rs-primitives.sps

test-r6rs-primitives: Akku.manifest test-r6rs-primitives.sps
	if [ "${SCHEME}" = "mosh" ]; then rm -rf Akku.manifest ; rm -rf Akku.lock ; rm -rf .akku ; fi
	if [ "${SCHEME}" = "ypsilon" ]; then rm -rf Akku.manifest ; rm -rf Akku.lock ; rm -rf .akku ; fi
	rm -rf test-r6rs-primitives
	akku install
	COMPILE_R7RS=${SCHEME} compile-scheme -I .akku/lib -o test-r6rs-primitives --debug test-r6rs-primitives.sps
	./test-r6rs-primitives

test-r6rs-primitives-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r6rs-test-${SCHEME} --quiet . > /dev/null
	docker run -t retropikzel-foreign-c-r6rs-test-${SCHEME} \
		sh -c "akku install && make SCHEME=${SCHEME} test-r6rs-primitives"


## R6RS Tests

test-r6rs.sps:
	printf "#!r6rs\n(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (rnrs programs) (foreign c) (srfi :64) (only (rnrs bytevectors) make-bytevector bytevector?))\n" > test-r6rs.sps
	echo "(test-begin \"foreign-c-r6rs\")" >> test-r6rs.sps
	cd tests && cat ${TESTFILES} >> ../test-r6rs.sps
	echo "(test-end \"foreign-c-r6rs\")" >> test-r6rs.sps

test-r6rs: libtest.o libtest.so libtest.a Akku.manifest test-r6rs.sps
	if [ "${SCHEME}" = "mosh" ]; then rm -rf Akku.manifest ; rm -rf Akku.lock ; rm -rf .akku ; fi
	if [ "${SCHEME}" = "ypsilon" ]; then rm -rf Akku.manifest ; rm -rf Akku.lock ; rm -rf .akku ; fi
	rm -rf test-r6rs
	akku install
	COMPILE_R7RS=${SCHEME} compile-scheme -I .akku/lib -o test-r6rs --debug test-r6rs.sps
	./test-r6rs

test-r6rs-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r6rs-test-${SCHEME} --quiet . > /dev/null
	docker run -t retropikzel-foreign-c-r6rs-test-${SCHEME} \
		sh -c "akku install && make SCHEME=${SCHEME} test-r6rs"


## R7RS Primitives Tests

test-r7rs-primitives.sps:
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c ${SCHEME}-primitives))" > test-r7rs-primitives.scm
	echo "(test-begin \"foreign-c-r7rs-primitives\")" >> test-r7rs-primitives.scm
	cd tests && cat ${PRIM_TESTFILES} >> ../test-r7rs-primitives.scm
	echo "(test-end \"foreign-c-r7rs-primitives\")" >> test-r7rs-primitives.scm

test-r7rs-primitives: Akku.manifest test-r7rs-primitives.sps
	rm -rf test-r7rs-primitives
	COMPILE_R7RS=${SCHEME} compile-scheme -I .akku/lib -o test-r7rs-primitives --debug test-r7rs-primitives.scm
	./test-r7rs-primitives

test-r7rs-primitives-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r7rs-test-${SCHEME} --quiet . > /dev/null
	docker run -t retropikzel-foreign-c-r7rs-test-${SCHEME} \
		sh -c "make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes build install test-r7rs"


## R7RS Tests

test-r7rs.scm:
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > test-r7rs.scm
	echo "(test-begin \"foreign-c-r7rs\")" >> test-r7rs.scm
	cd tests && cat ${TESTFILES} >> ../test-r7rs.scm
	echo "(test-end \"foreign-c-r7rs\")" >> test-r7rs.scm

test-r7rs: libtest.o libtest.so libtest.a test-r7rs.scm
	rm -rf test-r7rs
	COMPILE_R7RS_CHICKEN="-L -ltest -I./tests/c-include -L." \
		COMPILE_R7RS=${SCHEME} compile-scheme -I . -o test-r7rs --debug test-r7rs.scm
	LD_LIBRARY_PATH=. ./test-r7rs

test-r7rs-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r7rs-test-${SCHEME} --quiet . > /dev/null
	docker run -t retropikzel-foreign-c-r7rs-test-${SCHEME} \
		sh -c "make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes build install test-r7rs"

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}


## Utils
Akku.manifest:
	akku install chez-srfi akku-r7rs

clean:
	git clean -X -f
