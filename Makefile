.PHONY: libtest.o tests/libtest.so libtest.a documentation README.html foreign-c.pdf
PDFENGINE=weasyprint
CC=gcc
VERSION=0.10.6
TEST=primitives
SCHEME=chibi
TMPDIR=tmp/${SCHEME}
SNOW_CHIBI_ARGS=""
DOCKERIMG=${SCHEME}:head
ifeq "${SCHEME}" "chicken"
DOCKERIMG="chicken:5"
endif

GAUCHE_LIB_DIR=""
ifeq "${SCHEME}" "gauche"
GAUCHE_LIB_DIR=$(shell gauche-config --sitelibdir)
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

install: package
	snow-chibi --impls=${SCHEME} ${SNOW_CHIBI_ARGS} install foreign-c-${VERSION}.tgz; \
	if [ "${SCHEME}" = "gauche" ]; then \
		make gauche; \
		cp foreign/c/primitives/gauche.scm ${GAUCHE_LIB_DIR}/foreign/c/primitives/;\
		mkdir -p $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
		cp -r foreign/c/lib/gauche.so $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
		tree ${GAUCHE_LIB_DIR}/; \
	fi

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && \
		COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		COMPILE_R7RS=${SCHEME} \
		compile-r7rs -o ${TEST} ${TEST}.scm
	cd ${TMPDIR}/test \ && timeout 60 printf "\n" | LD_LIBRARY_PATH=. ./${TEST}

test-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=foreign-c-test-${SCHEME} -f dockerfiles/Dockerfile.test .
	docker run -it -v "${PWD}:/workdir" -w /workdir -t foreign-c-test-${SCHEME} sh -c "make SCHEME=${SCHEME} TEST=${TEST} SNOW_CHIBI_ARGS=--always-yes install test"

${TMPDIR}/test/libtest.o: tests/c-src/libtest.c
	mkdir -p ${TMPDIR}/test
	${CC} -o ${TMPDIR}/test/libtest.o -fPIC -c tests/c-src/libtest.c -I./include

${TMPDIR}/test/libtest.so: tests/c-src/libtest.c
	mkdir -p ${TMPDIR}/test
	${CC} -o ${TMPDIR}/test/libtest.so -shared -fPIC tests/c-src/libtest.c -I./include

${TMPDIR}/test/libtest.a: ${TMPDIR}/test/libtest.o tests/c-src/libtest.c
	ar rcs ${TMPDIR}/test/libtest.a ${TMPDIR}/test/libtest.o

${TMPDIR}:
	mkdir -p ${TMPDIR}

README.html: README.md
	pandoc --metadata title="Foreign C" --standalone README.md > README.html

foreign-c.pdf:
	pandoc -f markdown -t pdf --pdf-engine=${PDFENGINE} README.md -o foreign-c.pdf

chibi: foreign/c/primitives/chibi/foreign-c.stub
	chibi-ffi foreign/c/primitives/chibi/foreign-c.stub
	${CC} \
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
		--cflags="-I.foreign/c/primitives/gauche" \
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
