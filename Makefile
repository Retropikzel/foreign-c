.PHONY=libtest.so
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir

libtest.so: libtest.c
	${CC} -o libtest.so -shared -fPIC libtest.c

CHIBI=chibi-scheme -A .
test-chibi-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chibi bash -c "cd /workdir && chibi-ffi retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chibi bash -c "cd /workdir && apt update && apt install -y build-essential libffi-dev && ${CC} -o retropikzel/r7rs-pffi/r7rs-pffi-chibi.so -fPIC -shared retropikzel/r7rs-pffi/r7rs-pffi-chibi.c -lchibi-scheme -lffi"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chibi bash -c "cd /workdir && ${CHIBI} test.scm"

retropikzel/r7rs-pffi/r7rs-pffi-chibi.c: retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub
	chibi-ffi retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub

retropikzel/r7rs-pffi/r7rs-pffi-chibi.so: retropikzel/r7rs-pffi/r7rs-pffi-chibi.c
	${CC} -o retropikzel/r7rs-pffi/r7rs-pffi-chibi.so \
		retropikzel/r7rs-pffi/r7rs-pffi-chibi.c \
		-fPIC \
		-lffi \
		-shared

test-chibi: retropikzel/r7rs-pffi/r7rs-pffi-chibi.so libtest.so
	${CHIBI} test.scm

CHICKEN5=SCMC=csc CSCFLAGS="-I. " compile-r7rs main.scm
#CHICKEN5=csc -X r7rs -R r7rs -uses scheme.base -I.
#CHICKEN5_LIB=csc -X r7rs -R r7rs -uses r7rs -I. -include-path ./retropikzel -s -J
#CHICKEN5_LIB=csc -X r7rs -R r7rs -uses r7rs -unit retropikzel.r7rs-pffi -include-path ./retropikzel -s -J
test-chicken5-podman-amd65: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chicken:5 bash -c "cd /workdir && ${CHICKEN5_LIB} retropikzel.r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chicken:5 bash -c "cd /workdir && ${CHICKEN5} test.scm && ./test"

test-chicken5-docker: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	docker run -it -v ${PWD}:/workdir docker.io/schemers/chicken:5 bash -c "cd /workdir && ${CHICKEN5_LIB} retropikzel.r7rs-pffi.sld"
	docker run -it -v ${PWD}:/workdir docker.io/schemers/chicken:5 bash -c "cd /workdir && ${CHICKEN5} test.scm && ./test"

test-chicken5: clean libtest.so
	#cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	#${CHICKEN5_LIB} retropikzel.r7rs-pffi.sld
	${CHICKEN5} test.scm
	./test

CHICKEN6=csc -I.
CHICKEN6_LIB=csc -I. -include-path ./retropikzel -s -J
test-chicken6-podman-amd65: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chicken:6 bash -c "cd /workdir && ${CHICKEN5_LIB} retropikzel.r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/chicken:6 bash -c "cd /workdir && ${CHICKEN5} test.scm && ./test"

test-chicken6-docker: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	docker run -it -v ${PWD}:/workdir docker.io/schemers/chicken:6 bash -c "cd /workdir && ${CHICKEN5_LIB} retropikzel.r7rs-pffi.sld"
	docker run -it -v ${PWD}:/workdir docker.io/schemers/chicken:6 bash -c "cd /workdir && ${CHICKEN5} test.scm && ./test"

test-chicken6: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	${CHICKEN6_LIB} retropikzel.r7rs-pffi.sld
	${CHICKEN6} test.scm && ./test

CYCLONE=cyclone -COPT -I. -A .
test-cyclone-podman-amd64: clean libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/cyclone bash -c "cd /workdir && ${CYCLONE} retropikzel/r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/cyclone bash -c "cd /workdir && ${CYCLONE} test.scm && ./test"

test-cyclone: clean libtest.so
	${CYCLONE} retropikzel/r7rs-pffi.sld
	${CYCLONE} test.scm
	./test

GAMBIT_LIB=gsc -:search=.
GAMBIT_CC=gsc -exe ./ -nopreload
test-gambit-podman-amd64: clean libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/gambit bash -c "cd /workdir && ${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$?"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/gambit bash -c "cd /workdir && ${GAMBIT_CC} test.scm; echo $$?"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/gambit bash -c "cd /workdir && ./test -:search=.; echo $$?"

test-gambit: clean libtest.so
	${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$?
	${GAMBIT_CC} test.scm; echo $$?
	./test -:search=.; echo $$?

test-gauche:
	gosh -r7 -A . test.scm

GERBIL_LIB=gxc -O
GERBIL=GERBIL_LOADPATH=. gxc r7rs
test-gerbil-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/gerbil bash -c "cd /workdir && ${GERBIL_LIB} retropikzel/r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/gerbil bash -c "cd /workdir && ${GERBIL} test.scm"

test-gerbil:
	${GERBIL} test.scm

GUILE=guile --r7rs --fresh-auto-compile -L .
test-guile-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/guile bash -c "cd /workdir && ${GUILE} test.scm"

test-guile: libtest.so
	${GUILE} test.scm

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:*.sld
test-kawa-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/kawa bash -c "cd /workdir && ${KAWA} test.scm"

test-kawa-docker: libtest.so
	docker run -it -v ${PWD}:/workdir docker.io/schemers/kawa bash -c "cd /workdir && ${KAWA} test.scm"

test-kawa: libtest.so
	${KAWA} test.scm

LARCENY=larceny -r7 -I .
test-larceny-docker: libtest.so
	${DOCKER} schemers/larceny:latest bash -c "cd /workdir && ${LARCENY} test.scm"

test-larceny: libtest.so
	${LARCENY} test.scm

MOSH=mosh --loadpath=.
test-mosh-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/mosh:0 bash -c "cd /workdir && ${MOSH} test.scm"

test-mosh-docker: libtest.so
	docker run -it -v ${PWD}:/workdir docker.io/schemers/mosh:0 bash -c "cd /workdir && ${MOSH} test.scm"

test-mosh: libtest.so
	${MOSH} test.scm

SASH=sash --clean-cache -r7 -L . -L ./schubert
test-sagittarius-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/sagittarius bash -c "cd /workdir && ${SASH} test.scm"

test-sagittarius-docker: libtest.so
	docker run -it -v ${PWD}:/workdir docker.io/schemers/sagittarius bash -c "cd /workdir && ${SASH} test.scm"

test-sagittarius: libtest.so
	${SASH} test.scm

RACKET=racket -I r7rs -S . -S ./schubert --script
test-racket-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/racket bash -c "cd /workdir && ${RACKET} test.scm"

test-racket: libtest.so
	${RACKET} test.scm

test-skint: libtest.so
	skint test.scm

STKLOS=stklos -A . -f
test-stklos-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/stklos bash -c "cd /workdir && ${STKLOS} test.scm"

test-stklos: libtest.so
	${STKLOS} test.scm

test-tr7: libtest.so
	tr7i test.scm

YPSILON=ypsilon --r7rs --sitelib=. --top-level-program
test-ypsilon-podman-amd64: libtest.so
	podman run --arch=amd64 -it -v ${PWD}:/workdir docker.io/schemers/ypsilon bash -c "cd /workdir && ${YPSILON} test.scm"

test-ypsilon: libtest.so
	${YPSILON} test.scm

documentation:
	cat README.md > docs/index.md
	mkdocs build


tmp:
	mkdir -p tmp

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
	find . -name "*.c" -not -name "libtest.c" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	@rm -rf test
	@rm -rf tmp
	find . -name "core.1" -delete
	find . -name "test@gambit*" -delete
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.so
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.c
