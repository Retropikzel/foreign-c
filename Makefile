.PHONY: package test libtest.o tests/libtest.so libtest.a documentation README.html
.SILENT: build install test test-docker clean
SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.10.9
PKG=foreign-c-${VERSION}.tgz
CC=gcc
PKG=foreign-c-${VERSION}.tgz
ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif

build:
	rm -rf *.tgz
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
		--test=test.scm \
	foreign/c.sld \
	foreign/c/chibi-primitives.sld \
	foreign/c/chicken-primitives.sld \
	foreign/c/guile-primitives.sld \
	foreign/c/kawa-primitives.sld \
	foreign/c/mosh-primitives.sld \
	foreign/c/racket-primitives.sld \
	foreign/c/stklos-primitives.sld \
	foreign/c/ypsilon-primitives.sld

install:
	snow-chibi --impls=${SCHEME} --always-yes install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test-r6rs: libtest.o libtest.so libtest.a
	rm -rf test-r6rs
	printf "#!r6rs\n(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (foreign c) (srfi :64))\n" > test-r6rs.sps
	cat test.scm >> test-r6rs.sps
	COMPILE_R7RS=${SCHEME} compile-r7rs -I .akku/lib -o test-r6rs test-r6rs.sps
	./test-r6rs

test-r6rs-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r6rs-test-${SCHEME} -f Dockerfile-r6rs.test .
	docker run -t retropikzel-foreign-c-r6rs-test-${SCHEME} \
		sh -c "make SCHEME=${SCHEME} test-r6rs && cat foreign-c.log"

test-r7rs: libtest.o libtest.so libtest.a
	rm -rf test-r7rs
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > test-r7rs.scm
	cat test.scm >> test-r7rs.scm
	COMPILE_R7RS_CHICKEN="-L -ltest -I./tests/c-include -L." \
		COMPILE_R7RS=${SCHEME} compile-r7rs -I . -o test-r7rs test-r7rs.scm
	LD_LIBRARY_PATH=. ./test-r7rs

test-r7rs-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-test-${SCHEME} -f Dockerfile.test .
	docker run -t retropikzel-foreign-c-test-${SCHEME} \
		sh -c "make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes build install test-r7rs && cat foreign-c.log"

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	find . -name "*.meta" -delete
	find . -name "*.link" -delete
	find . -name "*.o" -delete
	find . -name "*.bci" -delete
	find . -name "*.com" -delete
	find . -name "*.comld" -delete
	find . -name "*.bin" -delete
	find . -name "*.binld" -delete
	find . -name "*.bcild" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	find . -name "*.jar" -delete
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	find . -name "*.import.scm" -delete
	find . -name "*.cdecl" -delete
	find . -name "*.log" -delete
	find . -name "*.tgz" -delete
	find . -name "*.rkt" -delete
	find . -name "*.tar.gz" -delete
	rm -rf MANIFEST.mf
	rm -rf tmp
	rm -rf foreign/c/primitives/chibi/foreign-c.c
	rm -rf foreign/c/lib
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-shim.c
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const.c
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const.scm
	rm -rf *.tgz
	rm -rf README.html
	rm -rf test
	rm -rf testfile.test
