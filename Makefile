.PHONY=libtest.o tests/libtest.so libtest.a documentation
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&
VERSION=$(shell grep "version:" README.md | awk '{split\($0,a\); print a[2];}')
TESTNAME=primitives

all: chibi chicken cyclone gambit gauche gerbil guile kawa larceny mosh racket sagittarius skint stklos tr7 ypsilon

test-compile-r7rs: tmp/test/libtest.o tmp/test/libtest.so tmp/test/libtest.a
	make ${COMPILE_R7RS}
	cp -r foreign tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		COMPILE_R7RS_GAMBIT="-cc-options \"-ltest -I. -L\" -ld-options \"-L.\"" \
		COMPILE_R7RS_CHICKEN="-L -static -L -ltest -I. -L." \
		compile-r7rs -I . -o ${TESTNAME} ${TESTNAME}.scm
	cd tmp/test && ./${TESTNAME}

test-compile-r7rs-wine:
	cp -r foreign tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		wine "${HOME}/.wine/drive_c/Program Files (x86)/compile-r7rs/compile-r7rs.bat" -I . -o ${TESTNAME} ${TESTNAME}.scm
	cd tmp/test && \
		LD_LIBRARY_PATH=. \
		wine ./${TESTNAME}.bat

test-compile-r7rs-docker-old:
	docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} -f Dockerfile.test .
	docker run -v "${PWD}:/workdir" -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c "make COMPILE_R7RS=${COMPILE_R7RS} TESTNAME=${TESTNAME} test-compile-r7rs"

test-compile-r7rs-docker:
	docker run -v "${PWD}:/workdir" -w /workdir retropikzel1/compile-r7rs:${COMPILE_R7RS} sh -c "make test-compile-r7rs COMPILE_R7RS=${COMPILE_R7RS} TESTNAME=${TESTNAME}"

tmp/test/libtest.o: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.o -fPIC -c tests/c-src/libtest.c -I./include

tmp/test/libtest.so: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.so -shared -fPIC tests/c-src/libtest.c -I./include

tmp/test/libtest.a: tmp/test/libtest.o tests/c-src/libtest.c
	ar rcs tmp/test/libtest.a tmp/test/libtest.o


# apt-get install pandoc weasyprint
docs:
	mkdir -p documentation
	pandoc --standalone \
		--template templates/documentation.html README.md \
		> documentation/foreign-c.html
	pandoc -t html5 \
		--pdf-engine=weasyprint \
		--css templates/css/pdf-documentation.css \
		-o documentation/foreign-c.pdf \
		README.md

chibi:
	make -C foreign/c chibi

chicken:
	make -C foreign/c chicken

cyclone:
	make -C foreign/c cyclone

gambit:
	make -C foreign/c gambit

gauche:
	make -C foreign/c gauche

gerbil:
	make -C foreign/c gerbil

guile:
	make -C foreign/c guile

kawa:
	make -C foreign/c kawa

larceny:
	make -C foreign/c larceny

mosh:
	make -C foreign/c mosh

racket:
	make -C foreign/c racket

sagittarius:
	make -C foreign/c sagittarius

skint:
	make -C foreign/c skint

stklos:
	make -C foreign/c stklos

tr7:
	make -C foreign/c tr7

ypsilon:
	make -C foreign/c tr7

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
