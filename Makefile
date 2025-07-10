.PHONY=libtest.o tests/libtest.so libtest.a documentation README.html
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&
VERSION=$(shell awk '/version:/{ print $$2 }' README.md )
TEST=primitives
SCHEME=chibi

all: package

package:
	markdown README.md > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

install:
	snow-chibi --impls=${SCHEME} install foreign-c-${VERSION}.tgz

install-jenkins:
	snow-chibi --impls=${SCHEME} --always-yes install foreign-c-${VERSION}.tgz

test-java: tmp/test/libtest.o tmp/test/libtest.so tmp/test/libtest.a
	mkdir -p tmp/test
	cp kawa.jar tmp/test/
	cp -r foreign tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test \
	&& ${JAVA_HOME}/bin/java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=*.sld:./snow/*.sld:./snow/retropikzel/*.sld ${TEST}.scm

test: tmp/test/libtest.o tmp/test/libtest.so tmp/test/libtest.a
	make ${SCHEME}
	cp -r foreign tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		COMPILE_R7RS_KAWA="-J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED -J--enable-native-access=ALL-UNNAMED -J--enable-preview" \
		COMPILE_R7RS=${SCHEME} \
		compile-r7rs -I . -I /usr/local/share/kawa/lib -o ${TEST} ${TEST}.scm
	cd tmp/test && \
		LD_LIBRARY_PATH=. \
		GUILE_AUTO_COMPILE=0 \
		./${TEST}

test-compile-r7rs-snow: tmp/test/libtest.o tmp/test/libtest.so tmp/test/libtest.a
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		compile-r7rs -o hello hello.scm
	cd tmp/test && ./hello

test-compile-r7rs-wine:
	cp -r foreign tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		wine "${HOME}/.wine/drive_c/Program Files (x86)/compile-r7rs/compile-r7rs.bat" -I . -o ${TEST} ${TEST}.scm
	cd tmp/test && \
		LD_LIBRARY_PATH=. \
		wine ./${TEST}.bat

test-docker:
	docker build --build-arg SCHEME=${SCHEME} --tag=r7rs-pffi-test-${SCHEME} -f dockerfiles/Dockerfile.test .
	docker run -it -v "${PWD}:/workdir" -w /workdir -t r7rs-pffi-test-${SCHEME} sh -c "make SCHEME=${SCHEME} TEST=${TEST} test-compile-r7rs"

tmp/test/libtest.o: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.o -fPIC -c tests/c-src/libtest.c -I./include

tmp/test/libtest.so: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.so -shared -fPIC tests/c-src/libtest.c -I./include

tmp/test/libtest.a: tmp/test/libtest.o tests/c-src/libtest.c
	ar rcs tmp/test/libtest.a tmp/test/libtest.o

documentation/foreign-c.html:

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

gerbil:
	@echo "Nothing to build for Gerbil"

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
