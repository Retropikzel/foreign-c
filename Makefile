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

CHICKEN_LIB=csc -X r7rs -R r7rs -s -J
build-chicken-libs:
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	${SCHEME_RUNNER} chicken "${CHICKEN_LIB} retropikzel.r7rs-pffi.sld"

CHICKEN=csc -X r7rs -R r7rs -L -lcurl
test-chicken: clean build-chicken-libs
	${SCHEME_RUNNER} chicken "${CHICKEN} test.scm"
	${SCHEME_RUNNER} chicken "./test"

CYCLONE=cyclone -A . -A ./schubert
build-cyclone-libs:
	${SCHEME_RUNNER} cyclone "${CYCLONE} retropikzel/r7rs-pffi.sld"

CYCLONE=cyclone -A . -A ./schubert
test-cyclone: clean build-cyclone-libs
	${SCHEME_RUNNER} cyclone "${CYCLONE} test.scm && icyc -s test.scm"

GAMBIT_LIB=gsc -:r7rs -dynamic
build-gambit-libs:
	${SCHEME_RUNNER} gambit "${GAMBIT_LIB} retropikzel/r7rs-pffi/gambit.scm"
	${SCHEME_RUNNER} gambit "${GAMBIT_LIB} retropikzel/r7rs-pffi.sld"

GAMBIT=gsc -:r7rs,search=.:./schubert -ld-options -lcurl -exe
test-gambit: clean build-gambit-libs
	${SCHEME_RUNNER} gambit "${GAMBIT} test.scm && ./test"
	#${GAMBIT} test.scm && ./test

GUILE=guile --r7rs -L . -L ./schubert
test-guile:
	#${SCHEME_RUNNER} guile "${GUILE} test.scm"
	${GUILE} test.scm

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:*.sld
test-kawa:
	#${SCHEME_RUNNER} kawa "${KAWA} test.scm"
	${KAWA} test.scm

SASH=sash -L . -L ./schubert
test-sagittarius:
	${SCHEME_RUNNER} sagittarius "${SASH} test.scm"

RACKET=racket -I r7rs -S . -S ./schubert --script
test-racket:
	${SCHEME_RUNNER} racket "${RACKET} test.scm"
	#${RACKET} test.scm

STKLOS=stklos -A . -A ./schubert -f
test-stklos:
	${SCHEME_RUNNER} stklos "${STKLOS} test.scm"

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
	@rm -rf test/*.c
	@rm -rf test/*.o*
	@rm -rf test/*.so
	@rm -rf test/*.meta
	@rm -rf test/pffi-define
	@rm -rf test/*gambit*
	@rm -rf test/*.link
	@rm -rf *.c
	@rm -rf *.o
	@rm -rf *.so
	@rm -rf *.a
	@rm -rf test
	@rm -rf tmp
