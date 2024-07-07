.PHONY: test

VERSION=$(shell cat VERSION)


build: build-main-scm

install: build
	schubert install

build-main-scm:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/main.scm

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

tmp:
	mkdir -p tmp

.dockerfiles:
	mkdir -p dockerfiles/build
	cat dockerfiles/src/wine_alpine_x86_64 > dockerfiles/build/Dockerfile.wine_alpine_x86_64
	cat dockerfiles/src/debian_trixie > dockerfiles/build/Dockerfile.debian_trixie
	cat dockerfiles/src/shared >> dockerfiles/build/Dockerfile.debian_trixie
	cat dockerfiles/src/fedora_40 > dockerfiles/build/Dockerfile.fedora_40
	cat dockerfiles/src/shared >> dockerfiles/build/Dockerfile.fedora_40
	cat dockerfiles/src/alpine_320 > dockerfiles/build/Dockerfile.alpine_320
	cat dockerfiles/src/shared >> dockerfiles/build/Dockerfile.alpine_320

test-in-container-wine-alpine-x86_64: .dockerfiles
	docker build --arch=x86_64 . -f dockerfiles/build/Dockerfile.wine_alpine_x86_64 --tag pffi-test-wine-alpine-x86_64
	docker run --arch=x86_64  -v ${PWD}:/workdir:z pffi-test-wine-alpine-x86_64

test-in-container-debian-trixie-arm64: .dockerfiles
	docker build --arch=arm64 . -f dockerfiles/build/Dockerfile.debian_trixie --tag pffi-test-debian-trixie-arm64
	docker run --arch=arm64 -v ${PWD}:/workdir:z pffi-test-debian-trixie-arm64

test-in-container-fedora-40-arm64: .dockerfiles
	docker build --arch=arm64 . -f dockerfiles/build/Dockerfile.fedora_40 --tag pffi-test-fedora-40-arm64
	docker run --arch=arm64 -v ${PWD}:/workdir:z pffi-test-fedora-40-arm64

test-in-container-alpine-320-arm64: .dockerfiles
	docker build --arch=arm64 . -f dockerfiles/build/Dockerfile.alpine_320 --tag pffi-test-alpine-320-arm64
	docker run --arch=arm64 -v ${PWD}:/workdir:z pffi-test-alpine-320-arm64

test-in-container-arm64: test-in-container-fedora-40-arm64 test-in-container-debian-trixie-arm64 test-in-container-fedora-40-arm64

test: build
	bash test-all.sh

test-arm64:
	scheme_testrunner debian:trixie arm64 guile "test-guile.sh"
	scheme_testrunner debian:trixie arm64 kawa "test-kawa.sh"
	#scheme_testrunner fedora_40 arm64 "bash test-all.sh"

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
	rm -rf tmp
	find ./test -type f -not -name "*.scm" -exec bash -c "test -x {} && rm {}" \;
	rm -rf dockerfiles/build
