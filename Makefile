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
