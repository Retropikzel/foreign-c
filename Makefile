.PHONY=libtest.o tests/libtest.so libtest.a documentation
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&
VERSION=$(shell awk '/version:/{ print $$2 }' README.md )
TESTNAME=primitives

chibi: foreign/c/primitives/chibi/foreign-c.stub
	chibi-ffi foreign/c/primitives/chibi/foreign-c.stub
	${CC} \
		-g3 \
		-o foreign/c/primitives/chibi/foreign-c.so \
		foreign/c/primitives/chibi/foreign-c.c \
		-fPIC \
		-lffi \
		-shared

package:
	markdown README.md > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--description="Portable foreign function interface for R7RS Schemes" \
	foreign/c.sld

clean-package:
	rm -rf *.tgz

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

documentation/foreign-c.html:

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
