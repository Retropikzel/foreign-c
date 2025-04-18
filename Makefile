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

test-compile-r7rs: tmp/test/libtest.o tmp/test/libtest.so
	make ${COMPILE_R7RS}
	cp -r retropikzel tmp/test/
	cp tests/compliance.scm tmp/test/
	cp include/libtest.h tmp/test/
	cd tmp/test && COMPILE_R7RS_CHICKEN="-L -ltest -I. -L." compile-r7rs -I . -o compliance compliance.scm
	cd tmp/test && LD_LIBRARY_PATH=. ./compliance

test-compile-r7rs-docker:
	docker build --build-arg COMPILE_R7RS=${COMPILE_R7RS} --tag=r7rs-pffi-test-${COMPILE_R7RS} .
	docker run -v "${PWD}":/workdir -w /workdir -t r7rs-pffi-test-${COMPILE_R7RS} sh -c "make COMPILE_R7RS=${COMPILE_R7RS} test-compile-r7rs"

#chicken-objects:
	#cd chicken/src && gcc -Os -fomit-frame-pointer -DHAVE_CHICKEN_CONFIG_H -c *.c -I../include

#test-chicken-c: libtest.o
	#csc -R r7rs -X r7rs -t -J -I ./retropikzel retropikzel/pffi.sld -o retropikzel.pffi.c
	#csc -R r7rs -X r7rs -t tests/compliance.scm -o tests/compliance.c
	#gcc -Os -fomit-frame-pointer -DHAVE_CHICKEN_CONFIG_H -o tests/compliance chicken/src/*.o tests/compliance.c -ltest -L. -I./include -I./chicken/include

#test-chicken: libtest.o
	#csc -R r7rs -X r7rs -c -J -I ./retropikzel retropikzel/pffi.sld -o retropikzel.pffi.o
	#csc -v -R r7rs -X r7rs -static tests/compliance.scm -o tests/compliance -C -ltest -I./include
	#csc -R r7rs -X r7rs -J -t -I ./retropikzel retropikzel/pffi.sld
	#csc -R r7rs -X r7rs -uses retropikzel.pffi -static tests/compliance.scm -L -ltest -L. -I./include -L./retropikzel
	#csc -R r7rs -X r7rs -t -I ./retropikzel retropikzel/pffi.sld -o retropikzel/pffi.c
	#cp retropikzel/pffi.sld retropikzel.pffi.scm
	#csc -J -t -I ./retropikzel retropikzel/pffi.sld -o retropikzel/pffi.c
	#csc -R r7rs -X r7rs -t -I retropikzel retropikzel/pffi.sld tests/compliance.scm -optimize-level 3 -o tests/compliance.c
	#csc -t tests/compliance.scm -o tests/compliance.c #-L -ltest -I./include -L. -L./tests
	#./tests/compliance

#jenkinsfile:
	#gosh -r7 -I ./snow build.scm

tmp/test/libtest.o: src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.o -fPIC -c src/libtest.c -I./include

tmp/test/libtest.so: src/libtest.c
	mkdir -p tmp/test
	${CC} -o tmp/test/libtest.so -shared -fPIC src/libtest.c -I./include

tmp/test/libtest.a: tmp/test/libtest.o src/libtest.c
	ar rcs tmp/test/libtest.a tmp/test/libtest.o

#test-interpreter-compliance: tests/libtest.so
	#SCHEME=${SCHEME} script-r7rs -I . -I .. tests/compliance.scm

#test-interpreter-compliance-docker:
	#docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	#docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} script-r7rs -I . -I .. tests/compliance.scm"

#test-compile-library: tests/libtest.so libtest.a libtest.o
	#SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld

#test-compiler-compliance-compile: test-compile-library
	#SCHEME=${SCHEME} CFLAGS="-I./include -L." LDFLAGS="-ltest -L." compile-r7rs -I . tests/compliance.scm
	#./tests/compliance

#test-compiler-compliance: test-compiler-compliance-compile
	#./tests/compliance

#test-compiler-compliance-docker: tests/libtest.so libtest.a
	#docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	#docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld"
	#docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs -I . compliance.scm && ./test"

clean:
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
	#find . -name "*.c" -not -name "libtest.c" -and -not -name "pffi.c" -delete
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
