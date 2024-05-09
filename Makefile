VERSION=v0.1.0
SASH=sash -r7 -L .
GUILE=guile --r7rs -L .
RACKET=racket -I r7rs --make -S $(shell pwd) --script
STKLOS=stklos -A .
KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=".."

build: build-rkt documentation

update-documentation:
	schubert document
	mkdir -p docuptmp
	cd docuptmp && git clone git@codeberg.org:r7rs-pffi/pffi.wiki.git
	cp retropikzel/pffi/${VERSION}/schubert-doc.md docuptmp/pffi.wiki/Documentation.md
	cd docuptmp/pffi.wiki && git add Documentation.md ; git commit -m "Update documentation" ; git push
	rm -rf docutmp

build-rkt:
	echo "#lang r7rs" > retropikzel/pffi/${VERSION}/main.rkt
	cat retropikzel/pffi/${VERSION}/main.scm >> retropikzel/pffi/${VERSION}/main.rkt

documentation:
	schubert document
	VERSION=${VERSION} bash doc/generate.sh > documentation.md

test/import.scm: build
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/size-of.scm: build
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/pointer-set-get.scm: build
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/string-to-pointer-to-string.scm: build
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

test/sdl2.scm: build
	${SASH} $@
	${GUILE} $@
	#${RACKET} $@
	#${STKLOS} $@
	${KAWA} $@

clean:
	rm -rf docuptmp
