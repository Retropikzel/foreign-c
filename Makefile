TEST_PACKAGES_APT=libcurl4 libcurl4-openssl-dev

build: retropikzel/r7rs-pffi/version/*.scm
	cp retropikzel/r7rs-pffi/version/main.scm retropikzel/r7rs-pffi/version/main.sld
	echo "#lang r7rs" > retropikzel/r7rs-pffi/version/main.rkt
	cat retropikzel/r7rs-pffi/version/main.scm >> retropikzel/r7rs-pffi/version/main.rkt

install:
	schubert install

test-all: \
	test-chicken\
	test-cyclone \
	test-gambit \
	test-gerbil \
	test-guile \
	test-kawa \
	test-sagittarius \
	test-racket \
	test-stklos

test-chicken: build
	PACKAGES="${TEST_PACKAGES_APT}" \
			 scheme_runner chicken "bash test-chicken.sh"

test-cyclone: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner cyclone "bash test-cyclone.sh"

test-gambit: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner gambit "bash test-gambit.sh"

test-gerbil: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner gerbil "bash test-gerbil.sh"

test-guile: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner guile "bash test-guile.sh"

test-kawa: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner kawa "bash test-kawa.sh"

test-sagittarius: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner sagittarius "bash test-sagittarius.sh"

test-racket: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner racket "bash test-racket.sh"

test-stklos: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_runner stklos "bash test-stklos.sh"

test-amd64-wine: build
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_testrunner sagittarius_wine "bash test-sagittarius-wine.sh"
	PACKAGES="${TEST_PACKAGES_APT}" \
	scheme_testrunner racket_wine "bash test-racket-wine.sh"

tmp:
	mkdir -p tmp

clean:
	rm -rf docutmp
	rm -rf retropikzel/r7rs-pffi/version/*.c
	rm -rf retropikzel/r7rs-pffi/version/*.o*
	rm -rf retropikzel/r7rs-pffi/version/*.so
	rm -rf retropikzel/r7rs-pffi/version/*.meta
	rm -rf retropikzel/r7rs-pffi/version/retropikzel.*
	rm -rf retropikzel/r7rs-pffi/version/compiled
	rm -rf retropikzel.*
	rm -rf test/*.c
	rm -rf test/*.o*
	rm -rf test/*.so
	rm -rf test/*.meta
	rm -rf test/pffi-define
	rm -rf test/*gambit*
	rm -rf test/*.link
	rm -rf *.c
	rm -rf *.o
	rm -rf *.so
	rm -rf *.a
	find ./test -type f -not -name "*.scm" -exec bash -c "test -x {} && rm {}" \;
