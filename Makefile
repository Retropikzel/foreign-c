.PHONY: libtest.o tests/libtest.so libtest.a documentation README.html
SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.10.7
CC=gcc
TMPDIR=.tmp

ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif

all: package

package: README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

README.html: README.md
	echo "<pre>" > README.html
	cat README.md >> README.html
	echo "</pre>" >> README.html

install: package
	snow-chibi --impls=${SCHEME} ${SNOW_CHIBI_ARGS} install foreign-c-${VERSION}.tgz; \
	if [ "${SCHEME}" = "gauche" ]; then \
		make gauche; \
		cp foreign/c/primitives/gauche.scm $(shell gauche-config --sitelibdir)/foreign/c/primitives/;\
		mkdir -p $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
		cp -r foreign/c/lib/gauche.so $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
	fi

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && \
		COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		COMPILE_R7RS=${SCHEME} timeout 600 compile-r7rs -o test test.scm
	cd ${TMPDIR}/test && printf "\n" | LD_LIBRARY_PATH=. timeout 600 ./test

test-docker:
	docker run -it -v "${PWD}:/workdir" -w /workdir retropikzel1/compile-r7rs sh -c \
		"make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes install test"

${TMPDIR}/test/libtest.o: tests/c-src/libtest.c ${TMPDIR}/test
	${CC} ${CFLAGS} -o ${TMPDIR}/test/libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

${TMPDIR}/test/libtest.so: tests/c-src/libtest.c ${TMPDIR}/test
	${CC} ${CFLAGS} -o ${TMPDIR}/test/libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

${TMPDIR}/test/libtest.a: ${TMPDIR}/test/libtest.o tests/c-src/libtest.c ${TMPDIR}/test
	ar rcs ${TMPDIR}/test/libtest.a ${TMPDIR}/test/libtest.o ${LDFLAGS}

${TMPDIR}:
	mkdir -p ${TMPDIR}

${TMPDIR}/test: ${TMPDIR}
	mkdir -p ${TMPDIR}/test

chibi: foreign/c/primitives/chibi/foreign-c.stub
	chibi-ffi foreign/c/primitives/chibi/foreign-c.stub
	${CC} \
		${CFLAGS} \
		-g3 \
		-o foreign/c/primitives/chibi/foreign-c.so \
		foreign/c/primitives/chibi/foreign-c.c \
		-fPIC \
		-lffi \
		-shared

gauche:
	gauche-package compile \
		--srcdir=foreign/c/primitives/gauche \
		--cc=${CC} \
		--cflags="${CFLAGS} -I.foreign/c/primitives/gauche" \
		--libs=-lffi \
		foreign-c-primitives-gauche foreign-c-primitives-gauche.c gauchelib.scm
	mkdir -p foreign/c/lib
	mv foreign-c-primitives-gauche.so foreign/c/lib/gauche.so
	mv foreign-c-primitives-gauche.o foreign/c/lib/gauche.o

clean:
	rm -rf ${TMPDIR}

clean-all:
	find . -name "*.meta" -delete
	find . -name "*.link" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	rm -rf tmp
	rm -rf foreign/c/primitives/chibi/foreign-c.c
	rm -rf foreign/c/lib
	rm -rf *.tgz
	rm -rf README.html
