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
	cat dockerfiles/src/wine > dockerfiles/build/Dockerfile.wine
	cat dockerfiles/src/debian_trixie > dockerfiles/build/Dockerfile.debian_trixie
	cat dockerfiles/src/shared >> dockerfiles/build/Dockerfile.debian_trixie
	cat dockerfiles/src/fedora_40 > dockerfiles/build/Dockerfile.fedora_40
	cat dockerfiles/src/shared >> dockerfiles/build/Dockerfile.fedora_40

test-in-docker-wine: .dockerfiles
	docker build . -f dockerfiles/build/Dockerfile.wine --tag pffi-test-wine
	docker run --privileged --cap-add=all -v ${PWD}:/workdir:z pffi-test-wine

test-in-docker-debian-trixie: .dockerfiles
	docker build . -f dockerfiles/build/Dockerfile.debian_trixie --tag pffi-test-debian-trixie
	docker run -v ${PWD}:/workdir:z pffi-test-debian-trixi2

test-in-docker-fedora-40: .dockerfiles
	docker build . -f dockerfiles/build/Dockerfile.fedora_40 --tag pffi-test-fedora-40
	docker run -v ${PWD}:/workdir:z pffi-test-fedora-40

test-in-docker: test-in-docker-debian-trixie test-in-docker-fedora-40
	

test: build
	bash test-all.sh

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
