.PHONY=libtest.o tests/libtest.so libtest.a documentation
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&
VERSION=$(shell grep "version:" README.md | awk '{split\($0,a\); print a[2];}')

# apt-get install pandoc weasyprint
docs:
	mkdir -p documentation
	pandoc --standalone \
		--template templates/documentation.html README.md \
		> documentation/R7RS-PFFI.html
	pandoc -t html5 \
		--pdf-engine=weasyprint \
		--css templates/css/pdf-documentation.css \
		-o documentation/R7RS-PFFI.pdf \
		README.md

chibi:
	make -C retropikzel/pffi chibi

chicken:
	make -C retropikzel/pffi chicken

cyclone:
	make -C retropikzel/pffi cyclone

gambit:
	make -C retropikzel/pffi gambit

gauche:
	make -C retropikzel/pffi gauche

gerbil:
	make -C retropikzel/pffi gerbil

guile:
	make -C retropikzel/pffi guile

kawa:
	make -C retropikzel/pffi kawa

larceny:
	make -C retropikzel/pffi larceny

mosh:
	make -C retropikzel/pffi mosh

racket:
	make -C retropikzel/pffi racket

sagittarius:
	make -C retropikzel/pffi sagittarius

skint:
	make -C retropikzel/pffi skint

stklos:
	make -C retropikzel/pffi stklos

tr7:
	make -C retropikzel/pffi tr7

ypsilon:
	make -C retropikzel/pffi tr7

test-compile-r7rs: tmp/test/libtest.o tmp/test/libtest.so tmp/test/libtest.a
	make ${COMPILE_R7RS}
	cp -r retropikzel tmp/test/
	cp tests/*.scm tmp/test/
	cp tests/c-include/libtest.h tmp/test/
	cd tmp/test && \
		COMPILE_R7RS_GAMBIT="-cc-options \"-ltest -I. -L\" -ld-options \"-L.\"" \
		COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." \
		compile-r7rs -I . -o ${TESTNAME} ${TESTNAME}.scm
	cd tmp/test && \
		LD_LIBRARY_PATH=. \
		./${TESTNAME}

test-compile-r7rs-docker:
	docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} -f dockerfiles/test .
	docker run -v "${PWD}":/workdir -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c "make COMPILE_R7RS=${COMPILE_R7RS} test-compile-r7rs"

tmp/test/libtest.o: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.o -fPIC -c tests/c-src/libtest.c -I./include

tmp/test/libtest.so: tests/c-src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.so -shared -fPIC tests/c-src/libtest.c -I./include

tmp/test/libtest.a: tmp/test/libtest.o tests/c-src/libtest.c
	ar rcs tmp/test/libtest.a tmp/test/libtest.o

clean:
	@rm -rf retropikzel/pffi/pffi.c
	@rm -rf retropikzel/pffi/*.o*
	@rm -rf retropikzel/pffi/*.so
	@rm -rf retropikzel/pffi/*.meta
	@rm -rf retropikzel/pffi/retropikzel.*
	@rm -rf retropikzel/pffi/compiled
	@rm -rf retropikzel.*
	find . -name "*.meta" -delete
	@rm -rf test/pffi-define
	@rm -rf test/*gambit*
	find . -name "*.link" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	@rm -rf test
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	rm -rf retropikzel/pffi.c
	rm -rf tests/compliance.c*
	rm -rf tests/compliance.o
	rm -rf tests/compliance.so
	rm -rf tests/compliance
	rm -rf tests/retropikzel.*.import.scm
	rm -rf tmp
