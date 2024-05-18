.PHONY: test/import.scm test/import.scm test/pffi-define.scm test/size-of.scm

VERSION=v0-1-0
GUILE=GUILE_AUTO_COMPILE=0 guile --no-auto-compile --fresh-auto-compile --r7rs -L .
RACKET=racket -I r7rs --make -S $(shell pwd) --script
STKLOS=STKLOS_FRAMES=200 stklos -A . --compiler-flags='+line-info,+time-display,unroll-iterations=3' -f
KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=".."
CYCLONE=cyclone -t -A .
CHICKEN=csc -X r7rs -R r7rs
CHICKEN_I=csi -R r7rs
GERBIL=gxc -prelude :scheme/r7rs -exe
GERBIL_I=gxi --lang r7rs

build: build-main-scm

build-main-scm:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/main.scm

build-main-chicken:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.main.scm
	cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.chicken.scm
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel.pffi.${VERSION}.main.scm
	cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel.pffi.${VERSION}.chicken.scm
	${CHICKEN} -sJ retropikzel.pffi.${VERSION}.chicken.scm
	${CHICKEN} -sJ retropikzel.pffi.${VERSION}.main.scm

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

test/import.scm: clean build
	${GUILE} $@ 
	${RACKET} $@
	${STKLOS} $@
	${KAWA} $@
	${CYCLONE} $@ && test/import
	#${GAMBIT} -exe $@ && ./test/import
	${CHICKEN} $@ && ./test/import
	#${GERBIL} $@

test/pffi-define.scm: clean build
	${GUILE} $@
	${RACKET} $@
	${KAWA} $@
	${CHICKEN} -L -lcurl $@ && ./test/pffi-define

test/pffi-define.scm: clean build
	${GAMBIT} -ld-options -lcurl -exe $@ && ./test/pffi-define

test/size-of.scm:
	${GUILE} $@
	${KAWA} $@

test/pointer-set-get.scm:
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/string-to-pointer-to-string.scm:
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

tmp:
	mkdir -p tmp

clean:
	rm -rf docutmp
	rm -rf retropikzel/pffi/${VERSION}/*.c
	rm -rf retropikzel/pffi/${VERSION}/*.o*
	rm -rf retropikzel/pffi/${VERSION}/*.so
	rm -rf retropikzel/pffi/${VERSION}/*.meta
	rm -rf retropikzel.*
	rm -rf test/*.c
	rm -rf test/*.o*
	rm -rf test/*.so
	rm -rf test/*.meta
	rm -rf test/import
	rm -rf test/pffi-define
	rm -rf test/*gambit*
	rm -rf test/*.link
	rm -rf *.c
	rm -rf *.o
	rm -rf *.so
	rm -rf *.a
	rm -rf tmp
