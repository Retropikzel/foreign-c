VERSION=0.13.4
SCHEME=chibi
RNRS=r7rs
PKG=foreign-c-${VERSION}.tgz
CC=gcc

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

init-testvenv:
	scheme-venv ${SCHEME} ${RNRS} testvenv
	cp test.scm testvenv/test.scm
	cp test.scm testvenv/test.sps
	sed -i 's/srfi 64/srfi :64/' testvenv/test.sps

run-test: libtest.o libtest.so libtest.a ${TESTVENV} build
	./testvenv/bin/snow-chibi install --always-yes ${PKG} srfi.64
	./testvenv/bin/snow-chibi install --always-yes srfi.64
	./testvenv/bin/akku install akku-r7rs chez-srfi
	if [ "${RNRS}" = "r6rs" ]; then ./testvenv/bin/scheme-compile test.sps; fi
	if [ "${RNRS}" = "r7rs" ]; then ./testvenv/bin/scheme-compile test.scm; fi
	./test


run-test-docker: init-testvenv
	docker build --build-arg SCHEME=${SCHEME} -f Dockerfile.test .
	#docker run foreign-c-${SCHEME}-${RNRS} sh -c ". testvenv/bin/activate && make SCHEME=${SCHEME} RNRS=${RNRS} run-test"

test-r7rs: libtest.o libtest.so libtest.a init-testvenv build
	rm -rf test
	./testvenv/bin/snow-chibi install --always-yes ${PKG}
	./testvenv/bin/snow-chibi install --always-yes srfi.64
	./testvenv/bin/scheme-compile test.scm
	./test

test-r7rs-docker: build-docker-image
	COMPILE_SCHEME=${SCHEME} \
	COMPILE_R7RS_CHICKEN="-L -ltest -I./tests/c-include -L." \
	test-scheme --docker-head --docker-quiet tests foreign libtest.o libtest.so libtest.a test-r7rs.scm

## C libraries for testing

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

foreign/c/chibi-primitives.so:
	chibi-ffi foreign/c/chibi-primitives.stub
	gcc -fPIC -shared \
		-Os \
		-o foreign/c/chibi-primitives.so \
		foreign/c/chibi-primitives.c \
	-lffi -lchibi-scheme

Akku.manifest:
	akku install chez-srfi akku-r7rs

clean:
	git clean -X -f
	rm -rf .akku
	rm -rf testvenv
