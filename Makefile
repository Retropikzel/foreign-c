VERSION=0.14.0
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main
TEST_DEPENDS=srfi.64

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

index:
	snow-chibi index ${PKG}

install: index
	snow-chibi --impls=${SCHEME} install --always-yes --skip-tests?=1 foreign.c

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test: libtest.so libtest.o libtest.a build index
	# tmpdir
	mkdir -p .tmp
	cp -r libtest.so libtest.o libtest.a tests/c-include/libtest.h foreign .tmp/
	mkdir -p logs/${RNRS}
	# R6RS files
	printf "#!r6rs\n(import (rnrs) (srfi :64) (foreign c))\n" > .tmp/test.sps
	cat tests/${TEST}.scm >> .tmp/test.sps
	if [ "${RNRS}" = "r6rs" ]; then snow-chibi install --impls=${SCHEME} --skip-tests?=1 --always-yes --install-source-dir=.tmp --install-library-dir=.tmp srfi.64; fi
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && akku install akku-r7rs chez-srfi; fi
	# R7RS testfiles
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > .tmp/test.scm
	cat tests/${TEST}.scm >> .tmp/test.scm
	if [ "${RNRS}" = "r7rs" ]; then snow-chibi install --impls=${SCHEME} --skip-tests?=1 --always-yes ${TEST_DEPENDS} foreign.c; fi
	# Tests
	rm -rf .tmp/test
	# R6RS
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I." compile-r7rs -I .akku/lib test.sps; fi
	# R7RS
	if [ "${RNRS}" = "r7rs" ]; then cd .tmp && COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I." compile-r7rs -I . test.scm; fi
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
