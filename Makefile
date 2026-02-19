VERSION=0.13.7
SCHEME=chibi
RNRS=r7rs
VENV=venv-${SCHEME}
DOCKERIMG=${SCHEME}:head
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TEST=main

ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:latest
endif

all: build

build:
	rm -rf *.tgz
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld #\
	#foreign/c/struct.sld \
	#foreign/c/stdio.sld

install:
	snow-chibi --impls=${SCHEME} install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

snow:
	snow-chibi install --impls=generic --always-yes --install-source-dir=snow --install-library-dir=snow retropikzel.ctrf | true
	snow-chibi install --impls=generic --always-yes --install-source-dir=snow --install-library-dir=snow srfi.64 | true

${VENV}:
	scheme-venv ${SCHEME} ${RNRS} ${VENV}
	if [ "${RNRS}" = "r6rs" ]; then ./${VENV}/bin/akku install akku-r7rs; fi
	if [ "${RNRS}" = "r7rs" ]; then ./${VENV}/bin/snow-chibi install --always-yes srfi.64; fi
	if [ "${RNRS}" = "r7rs" ]; then ./${VENV}/bin/snow-chibi install --always-yes retropikzel.ctrf; fi

run-test-venv: libtest.so libtest.o libtest.a snow build ${VENV}
	rm -rf run-test.sps
	rm -rf run-test.scm
	rm -rf run-test
	cp -r snow ./${VENV}/lib/
	cp -r foreign ./${VENV}/lib/
	echo "(import (rnrs) (srfi :64) (retropikzel ctrf) (foreign c))" > run-test.sps
	echo "(test-runner-current (ctrf-runner))" >> run-test.sps
	cat tests/${TEST}.scm >> run-test.sps
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (retropikzel ctrf) (foreign c))" > run-test.scm
	echo "(test-runner-current (ctrf-runner))" >> run-test.scm
	cat tests/${TEST}.scm >> run-test.scm
	if [ "${RNRS}" = "r7rs" ]; then ./${VENV}/bin/snow-chibi install ${PKG}; fi
	if [ "${RNRS}" = "r6rs" ]; then COMPILE_R7RS=${SCHEME} ./${VENV}/bin/scheme-compile run-test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" ./${VENV}/bin/scheme-compile run-test.scm; fi
	LD_LIBRARY_PATH=. ./run-test

run-test-system: libtest.so libtest.o libtest.a snow build
	echo "(import (rnrs) (srfi :64) (retropikzel ctrf) (foreign c))" > run-test.sps
	echo "(test-runner-current (ctrf-runner))" >> run-test.sps
	cat tests/${TEST}.scm >> run-test.sps
	echo "(import (scheme base) (scheme write) (scheme read) (scheme char) (scheme file) (scheme process-context) (srfi 64) (retropikzel ctrf) (foreign c))" > run-test.scm
	echo "(test-runner-current (ctrf-runner))" >> run-test.scm
	cat tests/${TEST}.scm >> run-test.scm
	if [ "${RNRS}" = "r6rs" ]; then akku install akku-r7rs; fi
	if [ "${RNRS}" = "r7rs" ]; then snow-chibi install --impls=${SCHEME} --always-yes srfi.64; fi
	if [ "${RNRS}" = "r7rs" ]; then snow-chibi install --impls=${SCHEME} --always-yes retropikzel.ctrf; fi
	if [ "${RNRS}" = "r7rs" ]; then snow-chibi install --impls=${SCHEME} --always-yes ${PKG}; fi
	if [ "${RNRS}" = "r6rs" ]; then COMPILE_R7RS=${SCHEME} compile-scheme -I .akku/lib run-test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then COMPILE_R7RS=${SCHEME} CSC_OPTIONS="-L -ltest -L. -I./tests/c-include" compile-scheme run-test.scm; fi
	LD_LIBRARY_PATH=. ./run-test

run-test-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} -f Dockerfile.test --tag=foreign-c-${SCHEME}-${RNRS} .
	docker run -v "${PWD}/logs:/workdir/logs" -w /workdir foreign-c-${SCHEME}-${RNRS} sh -c "make SCHEME=${SCHEME} RNRS=${RNRS} TEST=${TEST} run-test-system ; mv *.json logs/ || true"

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	@${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./tests/c-include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	@ar rcs libtest.a libtest.o ${LDFLAGS}

clean:
	git clean -X -f
	rm -rf .akku
