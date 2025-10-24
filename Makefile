.PHONY: package test libtest.o tests/libtest.so libtest.a documentation README.html
.SILENT: build install test test-docker clean
SCHEME=chibi
DOCKERIMG=${SCHEME}:head
VERSION=0.10.9
PKG=foreign-c-${VERSION}.tgz
GAUCHE_PKG=foreign-c-gauche-primitives-${VERSION}.tgz
GAUCHE_TAR=foreign-c-gauche-primitives-${VERSION}.tar
CC=gcc
PKG=foreign-c-${VERSION}.tgz
ifeq "${SCHEME}" "chicken"
DOCKERIMG=${SCHEME}:5
endif

# Mit scheme specific
MITCMD=mit-scheme --batch-mode
MITDIR=${PWD}/foreign/c/primitives/mit-scheme
MITLIBDIR=$(shell echo "(display (->namestring (system-library-directory-pathname)))" | mit-scheme --batch-mode 2> /dev/null | tail -1)


build:
	rm -rf *.tgz
	echo "<pre>$$(cat README.md)</pre>" > README.html
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--doc=README.html \
		--foreign-depends=ffi \
		--description="Portable foreign function interface for R7RS Schemes" \
		--test=test.scm \
	foreign/c.sld \
	foreign/c/chibi-primitives.sld \
	foreign/c/chicken-primitives.sld \
	foreign/c/guile-primitives.sld \
	foreign/c/kawa-primitives.sld \
	foreign/c/mosh-primitives.sld \
	foreign/c/racket-primitives.sld \
	foreign/c/stklos-primitives.sld \
	foreign/c/ypsilon-primitives.sld

build-gauche:
	snow-chibi package \
		--version=${VERSION} \
		--authors="Retropikzel" \
		--foreign-depends="libgauche ffi" \
		--description="Portable foreign function interface for R7RS Schemes - Gauche primitives" \
	foreign/c/gauche-primitives.sld \
	foreign/c/gauche-primitives.stub

install:
	snow-chibi --impls=${SCHEME} --always-yes install ${PKG}

install-gauche:
	if [ "${SCHEME}" = "gauche" ]; then \
		snow-chibi --impls=${SCHEME} ${SNOW_CHIBI_ARGS} install ${GAUCHE_PKG}; \
	fi

		#make gauche; \
		#sudo cp foreign/c/primitives/gauche.scm $(shell gauche-config --sitelibdir)/foreign/c/primitives/;\
		#sudo mkdir -p $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
		#sudo cp -r foreign/c/lib/gauche.so $(shell gauche-config --sitearchdir)/foreign/c/lib/; \
	#fi

uninstall:
	snow-chibi --impls=${SCHEME} remove "(foreign c)"

test: libtest.o libtest.so libtest.a
	rm -rf test
	COMPILE_R7RS_CHICKEN="-L -ltest -I./tests/c-include -L." \
		COMPILE_R7RS=${SCHEME} compile-r7rs -I . -o test test.scm
	LD_LIBRARY_PATH=. ./test

test-docker:
	docker build --build-arg IMAGE=${DOCKERIMG} --build-arg SCHEME=${SCHEME} --tag=retropikzel-foreign-c-test-${SCHEME} -f Dockerfile.test .
	docker run -v "${PWD}:/workdir" -w /workdir -t retropikzel-foreign-c-test-${SCHEME} sh -c "make SCHEME=${SCHEME} SNOW_CHIBI_ARGS=--always-yes build install test"

libtest.o: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.o -fPIC -c tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.so: tests/c-src/libtest.c
	${CC} ${CFLAGS} -o libtest.so -shared -fPIC tests/c-src/libtest.c -I./include ${LDFLAGS}

libtest.a: libtest.o tests/c-src/libtest.c
	ar rcs libtest.a libtest.o ${LDFLAGS}

chibi: foreign/c/chibi-primitives.stub
	chibi-ffi foreign/c/chibi-primitives.stub
	#${CC} ${CFLAGS} -g3 -o foreign/c/primitives/chibi/foreign-c.so foreign/c/primitives/chibi/foreign-c.c -fPIC -lffi -shared

gauche:
	gauche-package compile \
		--srcdir=foreign/c \
		--keep-c-files \
		gauche-primitives \
		gauche-primitives.gauche.scm
	#gcc -shared -o foreign/c/gauche-primitives.so gauche-primitives.so
		#--verbose \
		#--keep-c-files \
		#--srcdir=foreign/c/gauche \
		#--cc=${CC} \
		#--cflags="${CFLAGS} -I.foreign/c/gauche" \
		#--libs=-lffi \
		#foreign-c-gauche-primitives foreign-c-gauche-primitives.c gauchelib.scm
	#mkdir -p foreign/c/lib
	#mv foreign-c-gauche-primitives.so foreign/c/lib/gauche.so
	#mv foreign-c-gauche-primitives.o foreign/c/lib/gauche.o

mit-scheme:
	cd ${MITDIR} && echo "(load-option 'ffi) (c-generate \"mit-scheme-foreign-c\" \"#include <stdio.h>\n#include <ffi.h>\") " | ${MITCMD}
	cd ${MITDIR} && ${CC} -shared -Wall -fPIC -lffi -o mit-scheme-foreign-c-shim.so mit-scheme-foreign-c-shim.c -I${MITLIBDIR}
	cd ${MITDIR} && ${CC} -Wall -fPIC -lffi -o mit-scheme-foreign-c-const mit-scheme-foreign-c-const.c -I$(shell mit-scheme --batch-mode --eval "(display (->namestring (system-library-directory-pathname)))" --eval "(exit 0)" | tail -1)
	cd ${MITDIR} && ./mit-scheme-foreign-c-const
	cd ${MITDIR} && echo "(sf \"mit-scheme-foreign-c-const\")" | ${MITCMD}
	cd ${MITDIR} && echo "(generate-shim \"mit-scheme-foreign-c\" \"#include <stdio.h>\n#include <ffi.h>\")" | ${MITCMD}
	sudo cp foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-types.bin ${MITLIBDIR}
	sudo cp foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const.bin ${MITLIBDIR}
	sudo cp foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-shim.so ${MITLIBDIR}
	cd foreign && echo '(compile-file "c-mit-scheme.sld")' | ${MITCMD}
	sudo mkdir -p ${MITLIBDIR}/libraries/foreign
	sudo cp foreign/c-mit-scheme.binld ${MITLIBDIR} #/libraries/foreign/
	sudo cp foreign/c-mit-scheme.comld ${MITLIBDIR} #/libraries/foreign/
	#sudo cp foreign/c-mit-scheme.sld ${MITLIBDIR} #/libraries/foreign/


test-mit-scheme:
	LD_LIBRARY_PATH=${PWD}/foreign/c/primitives/mit-scheme \
		echo "(exit 0)" | mit-scheme --batch-mode --load test.scm --eval "(exit 0)"


mit-scheme-old:
	cd foreign/c/primitives/mit-scheme \
		&& ${CC} \
		-c -Wall -fPIC -lffi -o mit-scheme-foreign-c.o mit-scheme-foreign-c-shim.c \
		-I$(shell mit-scheme --batch-mode --eval "(display (->namestring (system-library-directory-pathname)))" --eval "(exit 0)" | tail -1)
	cd foreign/c/primitives/mit-scheme \
		#&& ${CC} -shared -Wall -fPIC -o mit-scheme-foreign-c.so mit-scheme-foreign-c-shim.o
	cd foreign/c/primitives/mit-scheme \
		&& mit-scheme --batch-mode \
			--eval "(generate-shim \"mit-scheme-foreign-c\" \"#include <stdio.h>\n#include <ffi.h>\")" \
			--eval "(exit 0)"
	cd foreign/c/primitives/mit-scheme \
		&& ${CC} -c -o mit-scheme-foreign-c-const.o mit-scheme-foreign-c-const.c
	cd foreign/c/primitives/mit-scheme \
		&& ${CC} -o mit-scheme-foreign-c-const mit-scheme-foreign-c-const.o
	cd foreign/c/primitives/mit-scheme \
		&& ./mit-scheme-foreign-c-const
	cd foreign/c/primitives/mit-scheme \
		&& echo '(sf "mit-scheme-foreign-c-const")' | mit-scheme --batch-mode
	cd foreign \
		&& echo '(sf "c-mit-scheme.sld")' | mit-scheme --batch-mode

clean:
	find . -name "*.meta" -delete
	find . -name "*.link" -delete
	find . -name "*.o" -delete
	find . -name "*.bci" -delete
	find . -name "*.com" -delete
	find . -name "*.comld" -delete
	find . -name "*.bin" -delete
	find . -name "*.binld" -delete
	find . -name "*.bcild" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	find . -name "*.jar" -delete
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	find . -name "*.import.scm" -delete
	find . -name "*.cdecl" -delete
	find . -name "*.log" -delete
	find . -name "*.tgz" -delete
	find . -name "*.rkt" -delete
	find . -name "*.tar.gz" -delete
	rm -rf MANIFEST.mf
	rm -rf tmp
	rm -rf foreign/c/primitives/chibi/foreign-c.c
	rm -rf foreign/c/lib
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-shim.c
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const.c
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const
	rm -rf foreign/c/primitives/mit-scheme/mit-scheme-foreign-c-const.scm
	rm -rf *.tgz
	rm -rf README.html
	rm -rf test
	rm -rf testfile.test
