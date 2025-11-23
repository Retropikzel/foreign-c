.PHONY: package test libtest.o tests/libtest.so libtest.a documentation README.html snow
.SILENT: build install test test-docker clean
SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.11.0
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
	foreign/c.sld \
	foreign/c/chez-primitives.sld \
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

Akku.manifest:
	akku install chez-srfi akku-r7rs

snow:
	#snow-chibi install --impls=generic --install-prefix=./snow --always-yes "(srfi 64)"
	#snow-chibi install --impls=generic --install-prefix=./snow --always-yes "(srfi 69)"
	#snow-chibi install --impls=generic --install-prefix=./snow --always-yes "(macduffie json)"
	mkdir -p snow/srfi
	cp -r ../r7rs-srfi/srfi/64.sld snow/srfi/
	cp -r ../r7rs-srfi/srfi/64.scm snow/srfi/
	cp -r ../r7rs-srfi/srfi/145.sld snow/srfi/
	cp -r ../r7rs-srfi/srfi/180.sld snow/srfi/
	cp -r ../r7rs-srfi/srfi/180.scm snow/srfi/
	mkdir -p snow/retropikzel
	cp ../scheme-libraries/retropikzel/ctrf.sld snow/retropikzel/
	cp ../scheme-libraries/retropikzel/ctrf.scm snow/retropikzel/

test-r6rs: libtest.o libtest.so libtest.a Akku.manifest snow
	if [ "${SCHEME}" = "mosh" ]; then rm -rf Akku.manifest ; rm -rf Akku.lock ; rm -rf .akku ; fi
	akku install
	rm -rf test-r6rs
	printf "#!r6rs\n(import (rnrs base) (rnrs control) (rnrs io simple) (rnrs files) (rnrs programs) (foreign c) (retropikzel ctrf))\n" > test-r6rs.sps
	cat test.scm >> test-r6rs.sps
	COMPILE_R7RS=${SCHEME} compile-scheme -I ./snow -o test-r6rs test-r6rs.sps
	./test-r6rs

test-r6rs-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-r6rs-test-${SCHEME} -f Dockerfile-r6rs.test .
	docker run -t retropikzel-foreign-c-r6rs-test-${SCHEME} \
		sh -c "akku install && make SCHEME=${SCHEME} test-r6rs"

test-r7rs: libtest.o libtest.so libtest.a snow
	rm -rf test-r7rs
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (retropikzel ctrf) (foreign c))" > test-r7rs.scm
	cat test.scm >> test-r7rs.scm
	COMPILE_R7RS_CHICKEN="-L -ltest -I./tests/c-include -L." \
		COMPILE_R7RS=${SCHEME} compile-scheme -I ./snow -I . -o test-r7rs test-r7rs.scm
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
	git clean -X -f
