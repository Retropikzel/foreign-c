CC=gcc

CHIBI=chibi-scheme -A .
test-chibi-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/chicken bash -c "cd /workdir && ${CHIBI} test.scm"

test-chibi:
	chibi-ffi retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub
	${CC} -o retropikzel/r7rs-pffi/r7rs-pffi-chibi.so -fPIC -shared retropikzel/r7rs-pffi/r7rs-pffi-chibi.c -lchibi-scheme -lffi
	${CHIBI} test.scm

CHICKEN=csc -X r7rs -R r7rs
CHICKEN_LIB=csc -X r7rs -R r7rs -include-path ./retropikzel -s -J
test-chicken-podman-amd65: clean
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/chicken bash -c "cd /workdir && ${CHICKEN_LIB} retropikzel.r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/chicken bash -c "cd /workdir && ${CHICKEN} test.scm && ./test"

test-chicken: clean
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	${CHICKEN_LIB} retropikzel.r7rs-pffi.sld
	${CHICKEN} test.scm && ./test

CYCLONE=cyclone -A .
test-cyclone-podman-amd64: clean
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/cyclone bash -c "cd /workdir && ${CYCLONE} retropikzel/r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/cyclone bash -c "cd /workdir && ${CYCLONE} test.scm && ./test"

test-cyclone: clean
	${CYCLONE} retropikzel/r7rs-pffi.sld
	${CYCLONE} test.scm
	./test

GAMBIT_LIB=gsc -:search=.
GAMBIT_CC=gsc -exe ./ -nopreload
test-gambit-podman-amd64: clean
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/gambit bash -c "cd /workdir && ${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$?"
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/gambit bash -c "cd /workdir && ${GAMBIT_CC} test.scm; echo $$?"
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/gambit bash -c "cd /workdir && ./test -:search=.; echo $$?"

test-gambit: clean
	${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$?
	${GAMBIT_CC} test.scm; echo $$?
	./test -:search=.; echo $$?

test-gauche:
	gosh -r7 -A . test.scm

GERBIL_LIB=gxc -O
GERBIL=GERBIL_LOADPATH=. gxi --lang r7rs
test-gerbil-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/gerbil bash -c "cd /workdir && ${GERBIL_LIB} retropikzel/r7rs-pffi.sld"
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/gerbil bash -c "cd /workdir && ${GERBIL} test.scm"

test-gerbil:
	gxi --lang r7rs test.scm

GUILE=guile --r7rs --fresh-auto-compile -L .
test-guile-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/guile bash -c "cd /workdir && ${GUILE} test.scm"

test-guile:
	${GUILE} test.scm

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:*.sld
test-kawa-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/kawa bash -c "cd /workdir && ${KAWA} test.scm"

test-kawa:
	${KAWA} test.scm

MOSH=mosh --loadpath=.
test-mosh-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/mosh:0 bash -c "cd /workdir && ${MOSH} test.scm"

test-mosh:
	${MOSH} test.scm

SASH=sash -r7 -L . -L ./schubert
test-sagittarius-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/sagittarius bash -c "cd /workdir && ${SASH} test.scm"

test-sagittarius:
	${SASH} test.scm

RACKET=racket -I r7rs -S . -S ./schubert --script
test-racket-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/racket bash -c "cd /workdir && ${RACKET} test.scm"

test-racket:
	${RACKET} test.scm

test-skint:
	skint test.scm

STKLOS=stklos -A . -f
test-stklos-podman-amd64:
	podman run --arch=amd64 -it -v ${PWD}:/workdir schemers/stklos bash -c "cd /workdir && ${STKLOS} test.scm"

test-stklos:
	${STKLOS} test.scm

test-tr7:
	tr7i test.scm

documentation:
	cat README.md > docs/index.md
	mkdocs build


tmp:
	mkdir -p tmp

clean:
	@rm -rf docutmp
	@rm -rf retropikzel/r7rs-pffi/*.c
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
	find . -name "*.c" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	@rm -rf test
	@rm -rf tmp
	find . -name "core.1" -delete
	find . -name "test@gambit*" -delete
