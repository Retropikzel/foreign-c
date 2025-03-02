.PHONY=libtest.o libtest.so libtest.a
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&

all: chibi

chibi:
	chibi-ffi src/chibi.stub && mv src/chibi.c src/pffi-chibi.c
	${CC} -Werror -g3 -o retropikzel/pffi/pffi-chibi.so \
		src/pffi-chibi.c \
		-fPIC \
		-lffi \
		-shared

gauche:
	${CC} -Werror -g3 -o retropikzel/pffi/pffi-gauche.so \
		src/pffi-gauche.c \
		-fPIC \
		-lffi \
		-shared \
		-I./include

jenkinsfile:
	gosh -r7 -I ./snow build.scm

libtest.o: src/libtest.c
	${CC} -o libtest.o -fPIC -c src/libtest.c -I./include

libtest.so: libtest.c
	${CC} -o libtest.so -shared -fPIC src/libtest.c -I./include

libtest.a: libtest.o src/libtest.c
	ar rcs libtest.a libtest.o

test-script: libtest.so
	SCHEME=${SCHEME} script-r7rs -I . test.scm

test-script-docker:
	docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} script-r7rs -I . test.scm"

test-compile-library: libtest.so libtest.a libtest.o
	SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld

test-compile: test-compile-library
	SCHEME=${SCHEME} CFLAGS="-I./include" LDFLAGS="-ltest" compile-r7rs -I . test.scm && ./test

test-compile-docker: libtest.so libtest.a
	docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld"
	docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs -I . test.scm && ./test"

clean:
	@rm -rf docutmp
	@rm -rf retropikzel/r7rs-pffi/*.o*
	@rm -rf retropikzel/r7rs-pffi/*.so
	@rm -rf retropikzel/r7rs-pffi/*.meta
	@rm -rf retropikzel/r7rs-pffi/retropikzel.*
	@rm -rf retropikzel/r7rs-pffi/compiled
	@rm -rf retropikzel.*
	find . -name "*.meta" -delete
	@rm -rf test/pffi-define
	@rm -rf test/*gambit*
	find . -name "*.link" -delete
	find . -name "*.c" -not -name "libtest.c" -and -not -name "pffi-gauche.c" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	@rm -rf test
	@rm -rf tmp
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.so
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.c
