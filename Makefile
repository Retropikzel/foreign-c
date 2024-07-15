build:
	cp retropikzel/r7rs-pffi/version/main.scm retropikzel/r7rs-pffi/version/main.sld
	echo "#lang r7rs" > retropikzel/r7rs-pffi/version/main.rkt
	cat retropikzel/r7rs-pffi/version/main.scm >> retropikzel/r7rs-pffi/version/main.rkt

install:
	schubert install

test-arm64:
	#scheme_testrunner alpine:3.20 arm64 guile "bash test-guile.sh"
	#scheme_testrunner alpine:3.20 arm64 sagittarius "bash test-sagittarius.sh"
	scheme_testrunner alpine:3.20 arm64 chicken "bash test-chicken.sh"
	#
	#scheme_testrunner debian:trixie arm64 guile "bash test-guile.sh"
	#scheme_testrunner debian:trixie arm64 sagittarius "bash test-sagittarius.sh"
	#
	#scheme_testrunner fedora:40 arm64 guile "bash test-guile.sh"
	#scheme_testrunner fedora:40 arm64 sagittarius "bash test-sagittarius.sh"
	#
	#scheme_testrunner opensuse/tumbleweed arm64 guile "bash test-guile.sh"
	#scheme_testrunner opensuse/tumbleweed arm64 sagittarius "bash test-sagittarius.sh"

test-amd64:
	#scheme_testrunner alpine:3.20 amd64 guile "bash test-guile.sh"
	scheme_testrunner alpine:3.20 amd64 sagittarius "bash test-sagittarius.sh"
	#
	#scheme_testrunner debian:trixie amd64 guile "bash test-guile.sh"
	#scheme_testrunner debian:trixie amd64 sagittarius "bash test-sagittarius.sh"
	#
	#scheme_testrunner fedora:40 amd64 guile "bash test-guile.sh"
	#scheme_testrunner fedora:40 amd64 sagittarius "bash test-sagittarius.sh"
	#
	#scheme_testrunner opensuse/tumbleweed amd64 guile "bash test-guile.sh"
	#scheme_testrunner opensuse/tumbleweed amd64 sagittarius "bash test-sagittarius.sh"

test-amd64-wine:
	scheme_testrunner alpine:3.20 amd64 sagittarius_wine "bash test-sagittarius-wine.sh"
	scheme_testrunner alpine:3.20 amd64 racket_wine "bash test-racket-wine.sh"

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
	rm -rf dockerfiles/build
