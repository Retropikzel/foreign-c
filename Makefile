TEST_PACKAGES_APT="libcurl4-openssl-dev libuv1"
DOCKER_INIT=apt update && apt install libcurl4-openssl-dev libuv1 && cd /workdir
SCHEME_RUNNER=PACKAGES=${TEST_PACKAGES_APT} ./scheme_runner
TESTFILES=$(shell ls tests/*.scm)

test-tier1: \
	test-chicken\
	test-guile \
	test-kawa \
	test-sagittarius \
	test-racket

test-tier2: \
	test-cyclone \
	test-gambit \
	test-stklos

CHICKEN=csc -X r7rs -R r7rs
CHICKEN_LIB=csc -X r7rs -R r7rs -include-path ./retropikzel -s -J
test-chicken: clean
	docker build . --build-arg IMPLEMENTATION=chicken -f Dockerfile --tag=r7rs-pffi-chicken
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	docker run -it -v ${PWD}:/workdir r7rs-pffi-chicken bash -c "cd /workdir && ${CHICKEN_LIB} retropikzel.r7rs-pffi.sld"
	docker run -it -v ${PWD}:/workdir r7rs-pffi-chicken bash -c "cd /workdir && ${CHICKEN} test.scm && ./test"

CYCLONE=cyclone -A .
test-cyclone: clean
	docker build . --build-arg IMPLEMENTATION=cyclone -f Dockerfile --tag=r7rs-pffi-cyclone
	docker run -it -v ${PWD}:/workdir r7rs-pffi-cyclone bash -c "cd /workdir && ${CYCLONE} retropikzel/r7rs-pffi.sld"
	docker run -it -v ${PWD}:/workdir r7rs-pffi-cyclone bash -c "cd /workdir && ${CYCLONE} test.scm && ./test"

GAMBIT_LIB=gsc . retropikzel/r7rs-pffi
GAMBIT_CC=gsc -exe . -nopreload
test-gambit: clean
	docker build . --build-arg IMPLEMENTATION=gambit -f Dockerfile --tag=r7rs-pffi-gambit
	docker run -it -v ${PWD}:/workdir r7rs-pffi-gambit bash -c "cd /workdir && ${GAMBIT_LIB} retropikzel/r7rs-pffi.sld; echo $$?"
	docker run -it -v ${PWD}:/workdir r7rs-pffi-gambit bash -c "cd /workdir && ${GAMBIT_CC} test.scm; echo $$?"
	docker run -it -v ${PWD}:/workdir r7rs-pffi-gambit bash -c "cd /workdir && ./test -:search=.; echo $$?"

GUILE=guile --r7rs --fresh-auto-compile -L .
test-guile:
	docker build . --build-arg IMPLEMENTATION=guile -f Dockerfile --tag=r7rs-pffi-guile
	docker run -it -v ${PWD}:/workdir r7rs-pffi-guile bash -c "cd /workdir && ${GUILE} test.scm"

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:*.sld
test-kawa:
	docker build . --build-arg IMPLEMENTATION=kawa -f Dockerfile --tag=r7rs-pffi-kawa
	docker run -it -v ${PWD}:/workdir r7rs-pffi-kawa bash -c "cd /workdir && ${KAWA} test.scm"

SASH=sash -r7 -L . -L ./schubert
test-sagittarius:
	docker build . --build-arg IMPLEMENTATION=sagittarius -f Dockerfile --tag=r7rs-pffi-sagittarius
	docker run -it -v ${PWD}:/workdir r7rs-pffi-sagittarius bash -c "cd /workdir && ${SASH} test.scm"

RACKET=racket -I r7rs -S . -S ./schubert --script
test-racket:
	docker build . --build-arg IMPLEMENTATION=racket -f Dockerfile --tag=r7rs-pffi-racket
	docker run -it -v ${PWD}:/workdir r7rs-pffi-racket bash -c "cd /workdir && ${RACKET} test.scm"

STKLOS=stklos -A . -f
test-stklos:
	docker build . --build-arg IMPLEMENTATION=stklos -f Dockerfile --tag=r7rs-pffi-stklos
	docker run -it -v ${PWD}:/workdir r7rs-pffi-stklos bash -c "cd /workdir && ${STKLOS} test.scm"

CHIBI=chibi-scheme
CHIBI_STUB=chibi-ffi
test-chibi:
	docker build . --build-arg IMPLEMENTATION=chibi -f Dockerfile --tag=r7rs-pffi-chibi
	docker run -it -v ${PWD}:/workdir r7rs-pffi-chibi bash -c "cd /workdir && ${CHIBI_STUB} retropikzel/r7rs-pffi/chibi.stub"

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
