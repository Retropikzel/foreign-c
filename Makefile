TEST_PACKAGES_APT="libcurl4-openssl-dev libuv1"
SCHEME_RUNNER=PACKAGES=${TEST_PACKAGES_APT} ./scheme_runner
TESTFILES=$(shell ls tests/*.scm)
SRFI_BUNDLE_VERSION=v0-1-0

build: retropikzel/r7rs-pffi/version/*.scm
	cp retropikzel/r7rs-pffi/version/main.scm retropikzel/r7rs-pffi/version/main.sld
	echo "#lang r7rs" > retropikzel/r7rs-pffi/version/main.rkt
	cat retropikzel/r7rs-pffi/version/main.scm >> retropikzel/r7rs-pffi/version/main.rkt

install:
	schubert install

test-tier1: \
	test-chicken\
	test-guile \
	test-kawa \
	test-sagittarius \
	test-racket

test-tier2:
	test-cyclone \
	test-gambit \
	test-stklos
	

CHICKEN_LIB=csc -X r7rs -R r7rs -s -J
build-chicken-libs:
	cp retropikzel/r7rs-pffi/version/chicken.scm retropikzel.r7rs-pffi.version.chicken.scm
	${SCHEME_RUNNER} chicken "${CHICKEN_LIB} retropikzel.r7rs-pffi.version.chicken.scm"
	cp retropikzel/r7rs-pffi/version/main.scm retropikzel.r7rs-pffi.version.main.scm
	${SCHEME_RUNNER} chicken "${CHICKEN_LIB} retropikzel.r7rs-pffi.version.main.scm"

CHICKEN=csc -X r7rs -R r7rs -L -lcurl
test-chicken: clean build build-chicken-libs
	${SCHEME_RUNNER} chicken "${CHICKEN} test.scm"
	${SCHEME_RUNNER} chicken "./test"

CYCLONE=cyclone -A . -A ./schubert
build-cyclone-libs:
	${SCHEME_RUNNER} cyclone "${CYCLONE} retropikzel/r7rs-pffi/version/cyclone.sld"
	${SCHEME_RUNNER} cyclone "${CYCLONE} retropikzel/r7rs-pffi/version/main.sld"

CYCLONE=cyclone -A . -A ./schubert
test-cyclone: clean build build-cyclone-libs
	${SCHEME_RUNNER} cyclone "icyc -s test.scm"

GAMBIT_LIB=gsc -:r7rs,search=.:./schubert -dynamic
build-gambit-libs:
	${SCHEME_RUNNER} gambit "${GAMBIT_LIB} retropikzel/pffi/version/gambit.scm"
	${SCHEME_RUNNER} gambit "${GAMBIT_LIB} retropikzel/pffi/version/main.scm"

GAMBIT=gsc -:r7rs,search=.:./schubert -ld-options -lcurl -exe
test-gambit: clean build
	${SCHEME_RUNNER} gambit "${GAMBIT} test.scm && ./test"

GUILE=guile -L . -L ./schubert
test-guile: build
	#${SCHEME_RUNNER} guile "${GUILE} test.scm"
	${GUILE} test.scm

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:./schubert
test-kawa: build
	echo "${SCHEME_RUNNER} kawa \"${KAWA} test.scm\""

SASH=sash -L . -L ./schubert
test-sagittarius: build
	${SCHEME_RUNNER} sagittarius "${SASH} test.scm"

RACKET=racket -I r7rs -S . -S ./schubert --script
test-racket: build
	${SCHEME_RUNNER} racket "${RACKET} test.scm"
	#${RACKET} test.scm

STKLOS=stklos -A . -A ./schubert -f
test-stklos: build
	${SCHEME_RUNNER} stklos "${STKLOS} test.scm"

documentation:
	cat README.md > docs/index.md
	mkdocs build


tmp:
	mkdir -p tmp

clean:
	@rm -rf docutmp
	@rm -rf retropikzel/r7rs-pffi/version/*.c
	@rm -rf retropikzel/r7rs-pffi/version/*.o*
	@rm -rf retropikzel/r7rs-pffi/version/*.so
	@rm -rf retropikzel/r7rs-pffi/version/*.meta
	@rm -rf retropikzel/r7rs-pffi/version/retropikzel.*
	@rm -rf retropikzel/r7rs-pffi/version/compiled
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
