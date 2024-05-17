.PHONY: test/import.scm test/import.scm test/pffi-define.scm

CHICKEN_INSTALL_REPOSITORY=${HOME}/.local/share/chicken
ENV_CHICKEN_REPOSITORY_PATH=${CHICKEN_REPOSITORY_PATH}


VERSION=v0-1-0
SASH=sash -c -r7 -L .
GUILE=GUILE_AUTO_COMPILE=0 guile --no-auto-compile --fresh-auto-compile --r7rs -L .
RACKET=racket -I r7rs --make -S $(shell pwd) --script
STKLOS=STKLOS_FRAMES=200 stklos -A . --compiler-flags='+line-info,+time-display,unroll-iterations=3' -f
KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=".."
CYCLONE=cyclone -t -A .
GAMBIT=gsc -:r7rs,search=$(shell pwd)
GAMBIT_I=gsi -:r7rs,search=$(shell pwd)
CHICKEN_ENV=CHICKEN_REPOSITORY_PATH=${ENV_CHICKEN_REPOSITORY_PATH}:${CHICKEN_INSTALL_REPOSITORY}:$(shell pwd) CHICKEN_INCLUDE_PATH=$(shell pwd) LD_LIBRARY_PATH=${GUIX_ENVIRONMENT}/lib
CHICKEN=${CHICKEN_ENV} csc -X r7rs -R r7rs -sJ
CHICKEN_I=${CHICKEN_ENV} csi -R r7rs -s
GERBIL=gxc -prelude :scheme/r7rs -exe
GERBIL_I=gxi --lang r7rs

build: build-rkt build-main-scm build-main-chicken build-main-gambit build-main-gerbil

chicken-install:
	mkdir -p ${CHICKEN_INSTALL_REPOSITORY}
	CHICKEN_INSTALL_REPOSITORY=${CHICKEN_INSTALL_REPOSITORY} \
							   CHICKEN_REPOSITORY_PATH=${ENV_CHICKEN_REPOSITORY_PATH}:${CHICKEN_INSTALL_REPOSITORY} \
							   chicken-install r7rs

build-rkt:
	echo "#lang r7rs" > retropikzel/pffi/${VERSION}/main.rkt
	cat retropikzel/pffi/${VERSION}/main.sld >> retropikzel/pffi/${VERSION}/main.rkt

build-main-scm:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/main.scm

build-main-chicken:
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.main.scm
	cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.chicken.scm
	cp retropikzel/pffi/${VERSION}/main.sld retropikzel.pffi.${VERSION}.main.scm
	cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel.pffi.${VERSION}.chicken.scm
	${CHICKEN} retropikzel.pffi.${VERSION}.chicken.scm
	${CHICKEN} retropikzel.pffi.${VERSION}.main.scm
	cp *.so test/

build-main-gambit:
	${GAMBIT} -obj retropikzel/pffi/${VERSION}/gambit.scm
	${GAMBIT} -obj retropikzel/pffi/${VERSION}/main.sld
	#cp retropikzel/pffi/${VERSION}/*.o* test/

build-main-gerbil:
	#${GAMBIT} -obj retropikzel/pffi/${VERSION}/gambit.scm
	#${GAMBIT} -obj retropikzel/pffi/${VERSION}/main.sld
	#cp retropikzel/pffi/${VERSION}/*.o* test/


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
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	${STKLOS} $@
	${KAWA} $@
	#${CYCLONE} $@ && test/import
	#${GAMBIT} -exe $@ && ./test/import
	#${CHICKEN} $@
	#${GERBIL} $@

test/pffi-define.scm: clean build
	${SASH} $@
	${GUILE} $@
	${KAWA} $@

test/size-of.scm:
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/pointer-set-get.scm:
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/string-to-pointer-to-string.scm:
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@


test/sdl2.scm:
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

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
