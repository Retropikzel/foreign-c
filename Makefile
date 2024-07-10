VERSION=$(shell cat VERSION)

build:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/main.scm

install:
	schubert install

update-documentation:
	schubert document
	mkdir -p docutmp
	cd docutmp && git clone git@codeberg.org:r7rs-pffi/pffi.wiki.git
	cp retropikzel/pffi/${VERSION}/schubert-doc.md docutmp/pffi.wiki/Documentation.md
	cd docutmp/pffi.wiki && git add Documentation.md ; git commit -m "Update documentation" ; git push
	rm -rf docutmp

documentation:
	schubert document
	VERSION=${VERSION} bash doc/generate.sh > documentation.md

test-arm64:
	#scheme_testrunner alpine:3.20 arm64 guile "bash test-guile.sh"
	scheme_testrunner alpine:3.20 arm64 sagittarius "bash test-sagittarius.sh"
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
	scheme_testrunner alpine:3.20 amd64 guile "bash test-guile.sh"
	scheme_testrunner alpine:3.20 amd64 sagittarius "bash test-sagittarius.sh"
	#
	scheme_testrunner debian:trixie amd64 guile "bash test-guile.sh"
	scheme_testrunner debian:trixie amd64 sagittarius "bash test-sagittarius.sh"
	#
	scheme_testrunner fedora:40 amd64 guile "bash test-guile.sh"
	scheme_testrunner fedora:40 amd64 sagittarius "bash test-sagittarius.sh"
	#
	scheme_testrunner opensuse/tumbleweed amd64 guile "bash test-guile.sh"
	scheme_testrunner opensuse/tumbleweed amd64 sagittarius "bash test-sagittarius.sh"

test-amd64-wine:
	scheme_testrunner alpine:3.20 amd64 sagittarius_wine "bash test-sagittarius-wine.sh"
	scheme_testrunner alpine:3.20 amd64 racket_wine "bash test-racket-wine.sh"

tmp:
	mkdir -p tmp

clean:
	rm -rf docutmp
	rm -rf retropikzel/pffi/${VERSION}/*.c
	rm -rf retropikzel/pffi/${VERSION}/*.o*
	rm -rf retropikzel/pffi/${VERSION}/*.so
	rm -rf retropikzel/pffi/${VERSION}/*.meta
	rm -rf retropikzel/pffi/${VERSION}/retropikzel.*
	rm -rf retropikzel/pffi/${VERSION}/compiled
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
