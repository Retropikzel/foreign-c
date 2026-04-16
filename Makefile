VERSION=0.14.1
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main
LINUX=debian

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
	snow-chibi --impls=${SCHEME} install --always-yes foreign.c

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
	cd .tmp && snow-chibi install --install-source-dir=. --install-library-dir=. --impls=${SNOW_IMPLS} ${PKG}
	cd .tmp && if [ "${RNRS}" = "r6rs" ]; then akku install akku-r7rs chez-srfi; fi
	cd .tmp && CSC_OPTIONS="-L -ltest -L. -I." COMPILE_R7RS=${SCHEME} compile-r7rs -o test-program ${LIBDIRS} test.${SFX}
	cd .tmp && LD_LIBRARY_PATH=. ./test-program

test-docker: testfiles
	# Tests
	cd .tmp && \
		LINUX=${LINUX} \
		APT_PACKAGES="make libffi-dev" \
		APK_PACKAGES="make libffi-dev" \
		SNOW_PACKAGES=srfi.64 \
		COMPILE_R7RS=${SCHEME} \
		CSC_OPTIONS="-L -ltest -L. -I." \
		LD_LIBRARY_PATH=. \
		test-r7rs ${LIB_PATHS} -o test-program test.${SFX} ${PKG}

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
