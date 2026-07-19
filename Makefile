.SILENT:
VERSION=0.22.0
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main
DOCKER_TAG=latest
tmpdir=.tmp/${SCHEME}-${RNRS}

SFX=scm
LIBDIRS=
SNOW_IMPLS=${SCHEME}
AKKU_PACKAGES=
ifeq "${RNRS}" "r6rs"
SFX=sps
LIBDIRS=-I .akku/lib
SNOW_IMPLS=generic
AKKU_PACKAGES="akku-r7rs chez-srfi"
endif

ifeq "${SCHEME}" "capyscheme"
DOCKER_TAG=head
endif
ifeq "${SCHEME}" "chibi"
DOCKER_TAG=head
endif
ifeq "${SCHEME}" "chicken"
DOCKER_TAG=head
endif
ifeq "${SCHEME}" "gauche"
DOCKER_TAG=head
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

${PKG}: package

install:
	snow-chibi --impls=${SCHEME} install --always-yes ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove foreign.c

testfiles: libtest.so libtest.o libtest.a ${PKG}
	rm -rf ${tmpdir}
	mkdir -p ${tmpdir}
	cp -r libtest.so libtest.o libtest.a tests/c-include/libtest.h foreign \
		${tmpdir}/
	cat tests/r6rs-header.sps > ${tmpdir}/test.sps
	cat tests/${TEST}.scm >> ${tmpdir}/test.sps
	cat tests/r7rs-header.scm > ${tmpdir}/test.scm
	cat tests/${TEST}.scm >> ${tmpdir}/test.scm
	cp ${PKG} ${tmpdir}/

test: testfiles
	cd ${tmpdir} && \
		CSC_OPTIONS="-L -ltest -L. -I." \
		COMPILE_R7RS=${SCHEME} \
		COMPILE_R7RS_DEBUG=1 \
		compile-r7rs -o test-program ${LIBDIRS} test.${SFX}
	cd ${tmpdir} && LD_LIBRARY_PATH=. ./test-program
	mkdir -p test-results/
	cp ${tmpdir}/junit-result.xml test-results/${SCHEME}.xml

test-docker: testfiles
	cd ${tmpdir} && \
		TEST_R7RS_DEBUG=1 \
		DOCKER_TAG=${DOCKER_TAG} \
		APT_PACKAGES="make gcc libffi-dev" \
		SNOW_PACKAGES="srfi.64 retropikzel.junit ${PKG}"\
		AKKU_PACKAGES=${AKKU_PACKAGES} \
		COMPILE_R7RS=${SCHEME} \
		CSC_OPTIONS="-L -ltest -L. -I." \
		LD_LIBRARY_PATH=. \
		PASS_ENV_VARS="CSC_OPTIONS LD_LIBRARY_PATH" \
		test-r7rs ${LIB_PATHS} -o test-program test.${SFX}
	mkdir -p test-results/
	cp ${tmpdir}/junit-result.xml test-results/${SCHEME}.xml

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
