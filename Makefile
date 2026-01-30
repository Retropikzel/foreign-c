VERSION=0.13.4
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc
TESTNAME=main

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
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} --always-yes install ${PKG}

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

init-venv:
	rm -rf venv
	scheme-venv ${SCHEME} ${RNRS} venv
	cp tests/${TESTNAME}.scm venv/${TESTNAME}.scm
	cp tests/${TESTNAME}.scm venv/${TESTNAME}.sps
	sed -i 's/srfi 64/srfi :64/' venv/${TESTNAME}.sps
	cp -r foreign venv/lib
	./venv/bin/snow-chibi install --always-yes ${PKG}
	./venv/bin/snow-chibi install --always-yes srfi.64
	./venv/bin/akku install akku-r7rs chez-srfi

run-test: libtest.o libtest.so libtest.a init-venv build
	if [ "${RNRS}" = "r6rs" ]; then ./venv/bin/scheme-compile venv/${TESTNAME}.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then ./venv/bin/scheme-compile venv/${TESTNAME}.scm; fi
	./venv/${TESTNAME}

run-test-docker: init-venv
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test .
	#docker run foreign-c-${SCHEME}-${RNRS} sh -c ". venv/bin/activate && make SCHEME=${SCHEME} RNRS=${RNRS} run-test"

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
	rm -rf venv
