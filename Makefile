VERSION=0.14.3
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main
DOCKER_TAG=head

ifeq "${SCHEME}" "chicken"
DOCKER_TAG=5
endif

SFX=scm
LIBDIRS=-I .
SNOW_IMPLS=${SCHEME}
ifeq "${RNRS}" "r6rs"
SFX=sps
LIBDIRS=-I .akku/lib
SNOW_IMPLS=generic
endif

all: package

package:
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
	snow-chibi --impls=${SCHEME} install --always-yes ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove foreign.c

testfiles: libtest.so libtest.o libtest.a package
	rm -rf .tmp
	mkdir -p .tmp
	cp -r libtest.so libtest.o libtest.a tests/c-include/libtest.h foreign .tmp/
	mkdir -p logs/${RNRS}
	# R6RS files
	printf "#!r6rs\n(import (rnrs) (srfi :64) (foreign c))\n" > .tmp/test.sps
	cat tests/${TEST}.scm >> .tmp/test.sps
	# R7RS testfiles
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (foreign c))" > .tmp/test.scm
	cat tests/${TEST}.scm >> .tmp/test.scm
	cp ${PKG} .tmp/

test: testfiles
	if [ "${RNRS}" = "r6rs" ]; then cd .tmp && snow-chibi install --install-source-dir=. --install-library-dir=. --impls=${SNOW_IMPLS} ${PKG}; fi
	cd .tmp && if [ "${RNRS}" = "r6rs" ]; then akku install akku-r7rs chez-srfi; fi
	cd .tmp && CSC_OPTIONS="-L -ltest -L. -I." COMPILE_R7RS=${SCHEME} compile-r7rs -I /usr/local/share/tr7/tr7libs -o test-program ${LIBDIRS} test.${SFX}
	cd .tmp && LD_LIBRARY_PATH=. ./test-program

test-docker: testfiles
	# Tests
	cd .tmp && \
		TEST_R7RS_DEBUG=1 \
		DOCKER_TAG=${DOCKER_TAG} \
		APT_PACKAGES="make gcc libffi-dev" \
		SNOW_PACKAGES="srfi.64 ${PKG}"\
		COMPILE_R7RS=${SCHEME} \
		CSC_OPTIONS="-L -ltest -L. -I." \
		LD_LIBRARY_PATH=. \
		PASS_ENV_VARS="CSC_OPTIONS LD_LIBRARY_PATH" \
		test-r7rs ${LIB_PATHS} -o test-program test.${SFX}

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
	rm -rf snow
	rm -rf logs
