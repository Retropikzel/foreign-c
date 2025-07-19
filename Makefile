.PHONY=libtest.o tests/libtest.so libtest.a documentation README.html
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&
VERSION=$(shell awk '/version:/{ print $$2 }' README.md )
TEST=primitives
SCHEME=chibi
TMPDIR=tmp/${SCHEME}

all: build ${TMPDIR}

build:
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.md \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install foreign-c-${VERSION}.tgz

uninstall:
	snow-chibi --impls=${SCHEME} remove foreign.c

install-jenkins:
	snow-chibi --impls=${SCHEME} --always-yes install foreign-c-${VERSION}.tgz

test-java: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	mkdir -p ${TMPDIR}/test
	cp kawa.jar ${TMPDIR}/test/
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test \
	&& ${JAVA_HOME}/bin/java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=*.sld:./snow/*.sld:./snow/retropikzel/*.sld ${TEST}.scm

test-chibi: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	make chibi
	mkdir -p ${TMPDIR}/test
	cp kawa.jar ${TMPDIR}/test/
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && chibi-scheme -I . ${TEST}.scm

test: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	make ${SCHEME}
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && \
		COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		COMPILE_R7RS_KAWA="-J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED -J--enable-native-access=ALL-UNNAMED -J--enable-preview" \
		COMPILE_R7RS=${SCHEME} \
		compile-r7rs -I . -I /usr/local/share/kawa/lib -o ${TEST} ${TEST}.scm
	cd ${TMPDIR}/test && \
		LD_LIBRARY_PATH=. \
		GUILE_AUTO_COMPILE=0 \
		timeout 60
		./${TEST}

test-compile-r7rs-snow: ${TMPDIR}/test/libtest.o ${TMPDIR}/test/libtest.so ${TMPDIR}/test/libtest.a
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && \
		compile-r7rs -o hello hello.scm
	cd ${TMPDIR}/test && ./hello

test-compile-r7rs-wine:
	cp -r foreign ${TMPDIR}/test/
	cp tests/*.scm ${TMPDIR}/test/
	cp tests/c-include/libtest.h ${TMPDIR}/test/
	cd ${TMPDIR}/test && \
		wine "${HOME}/.wine/drive_c/Program Files (x86)/compile-r7rs/compile-r7rs.bat" -I . -o ${TEST} ${TEST}.scm
	cd ${TMPDIR}/test && \
		LD_LIBRARY_PATH=. \
		wine ./${TEST}.bat

test-docker:
	docker build --build-arg SCHEME=${SCHEME} --tag=foreign-c-test-${SCHEME} -f dockerfiles/Dockerfile.test .
	docker run -it -v "${PWD}:/workdir" -w /workdir -t foreign-c-test-${SCHEME} sh -c "make SCHEME=${SCHEME} TEST=${TEST} test"

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

# apt-get install pandoc weasyprint
documentation: README.md
	mkdir -p documentation
	pandoc --standalone \
		--template templates/documentation.html README.md \
		> documentation/foreign-c.html
	pandoc -t html5 \
		--pdf-engine=weasyprint \
		--css templates/css/pdf-documentation.css \
		-o documentation/foreign-c.pdf \
		README.md

chibi: foreign/c/primitives/chibi/foreign-c.stub
	chibi-ffi foreign/c/primitives/chibi/foreign-c.stub
	${CC} \
		-g3 \
		-o foreign/c/primitives/chibi/foreign-c.so \
		foreign/c/primitives/chibi/foreign-c.c \
		-fPIC \
		-lffi \
		-shared

chicken:
	@echo "Nothing to build for Chicken"

cyclone:
	@echo "Nothing to build for Cyclone"

foment:
	@echo "Nothing to build for Foment"

gambit:
	@echo "Nothing to build for Gambit"

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

guile:
	@echo "Nothing to build for Guile"

kawa:
	@echo "Nothing to build for Kawa"

larceny:
	@echo "Nothing to build for Larceny"

mosh:
	@echo "Nothing to build for Mosh"

racket:
	@echo "Nothing to build for Racket"

sagittarius:
	@echo "Nothing to build for Sagittarius"

skint:
	@echo "Nothing to build for Skint"

stklos:
	@echo "Nothing to build for Stklos"

tr7:
	@echo "Nothing to build for tr7"

ypsilon:
	@echo "Nothing to build for Ypsilon"

clean:
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
	rm -rf *.tgz
	rm -rf README.html
