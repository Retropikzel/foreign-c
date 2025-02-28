.PHONY=libtest.so
CC=gcc
DOCKER=docker run -it -v ${PWD}:/workdir
DOCKER_INIT=cd /workdir && make clean &&

jenkinsfile:
	gosh -r7 -I ./snow build.scm

libtest.so: libtest.c
	${CC} -o libtest.so -shared -fPIC libtest.c

libtest.a: libtest.c
	${CC} -fPIC -c libtest.c
	ar rcs libtest.a libtest.o

test-script: libtest.so
	SCHEME=${SCHEME} script-r7rs -I . test.scm

test-script-docker:
	sudo docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	sudo docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && make libtest.so && SCHEME=${SCHEME} script-r7rs -I . test.scm"

test-compile: libtest.so libtest.a
	SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld
	SCHEME=${SCHEME} compile-r7rs -I . test.scm && ./test

test-compile-docker: libtest.so libtest.a
	sudo docker build -f dockerfiles/test . --build-arg SCHEME=${SCHEME} --tag=pffi-${SCHEME}
	sudo docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs-library retropikzel/pffi.sld"
	sudo docker run -v ${PWD}:/workdir pffi-${SCHEME} bash -c "cd /workdir && SCHEME=${SCHEME} compile-r7rs -I . test.scm && ./test"

CHIBI=chibi-scheme -A .
test-chibi-docker:
	docker build -f Dockerfile --build-arg SCHEME=chibi --tag=r7rs-pffi-chibi .
	${DOCKER} r7rs-pffi-chibi bash -c \
		"${DOCKER_INIT} chibi-ffi retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub \
		&& ${CC} -o retropikzel/r7rs-pffi/r7rs-pffi-chibi.so -fPIC -shared retropikzel/r7rs-pffi/r7rs-pffi-chibi.c -lchibi-scheme -lffi \
		&& ${CHIBI} test.scm"

retropikzel/r7rs-pffi/r7rs-pffi-chibi.c: retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub
	chibi-ffi retropikzel/r7rs-pffi/r7rs-pffi-chibi.stub

retropikzel/r7rs-pffi/r7rs-pffi-chibi.so: retropikzel/r7rs-pffi/r7rs-pffi-chibi.c
	${CC} -o retropikzel/r7rs-pffi/r7rs-pffi-chibi.so \
		retropikzel/r7rs-pffi/r7rs-pffi-chibi.c \
		-fPIC \
		-lffi \
		-shared

test-chibi: retropikzel/r7rs-pffi/r7rs-pffi-chibi.so libtest.so
	${CHIBI} test.scm

CHICKEN5=SCMC=csc CSC_FLAGS='-I. -L. -L -ltest' compile-r7rs -I . main.scm
test-chicken-5-docker:
	docker build --build-arg SCHEME=chicken:5 -f Dockerfile --tag=r7rs-pffi-chicken-5 .
	${DOCKER} r7rs-pffi-chicken-5 bash -c "${DOCKER_INIT} ${CHICKEN5} test.scm && ./test"

test-chicken-5: clean libtest.a
	${CHICKEN5} test.scm
	./test

CHICKEN6=SCMC=csc CSC_FLAGS='-I. -L. -L -ltest' compile-r7rs -I . main.scm
test-chicken-6-docker:
	docker build --build-arg SCHEME=chicken:6 -f Dockerfile --tag=r7rs-pffi-chicken-6 .
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	${DOCKER} r7rs-pffi-chicken-6 bash -c "${DOCKER_INIT} ${CHICKEN6} test.scm && ./test"

test-chicken-6: clean libtest.so
	cp retropikzel/r7rs-pffi.sld retropikzel.r7rs-pffi.sld
	${CHICKEN6_LIB} retropikzel.r7rs-pffi.sld
	${CHICKEN6} test.scm && ./test

CYCLONE=cyclone -COPT -I. -A .
test-cyclone-docker:
	docker build --build-arg SCHEME=cyclone -f Dockerfile --tag=r7rs-pffi-cyclone .
	${DOCKER} r7rs-pffi-cyclone bash -c "${DOCKER_INIT} ${CYCLONE} retropikzel/r7rs-pffi.sld && ${CYCLONE} test.scm && ./test"

test-cyclone: clean libtest.so
	${CYCLONE} retropikzel/r7rs-pffi.sld
	${CYCLONE} test.scm
	./test

GAMBIT_LIB=gsc -:search=.
GAMBIT_CC=gsc -exe ./ -nopreload
test-gambit-docker:
	docker build --build-arg SCHEME=gambit -f Dockerfile --tag=r7rs-pffi-gambit .
	${DOCKER} r7rs-pffi-gambit bash -c "${DOCKER_INIT} ${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$? && ${GAMBIT_CC} test.scm; echo $$? && ./test -:search=.; echo $$?"

test-gambit: clean libtest.so
	${GAMBIT_LIB} retropikzel/r7rs-pffi; echo $$?
	${GAMBIT_CC} test.scm; echo $$?
	./test -:search=.; echo $$?

test-gauche:
	gosh -r7 -A . test.scm

GERBIL_LIB=gxc -O
GERBIL=GERBIL_LOADPATH=. gxc r7rs
test-gerbil-docker:
	docker build --build-arg SCHEME=gerbil -f Dockerfile --tag=r7rs-pffi-gerbil .
	${DOCKER} r7rs-pffi-gerbil bash -c "${DOCKER_INIT} ${GERBIL_LIB} retropikzel/r7rs-pffi.sld && ${GERBIL} test.scm"

test-gerbil:
	${GERBIL} test.scm

GUILE=guile --r7rs --fresh-auto-compile -L .
test-guile-docker:
	docker build --build-arg SCHEME=guile:head -f Dockerfile --tag=r7rs-pffi-guile .
	${DOCKER} r7rs-pffi-guile bash -c "${DOCKER_INIT} ${GUILE} test.scm"

test-guile: libtest.so
	${GUILE} test.scm

KAWA=java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar --r7rs --full-tailcalls -Dkawa.import.path=.:*.sld
test-kawa-docker:
	docker build --build-arg SCHEME=kawa -f Dockerfile --tag=r7rs-pffi-kawa .
	${DOCKER} r7rs-pffi-kawa bash -c "${DOCKER_INIT} ${KAWA} test.scm"

test-kawa: libtest.so
	${KAWA} test.scm

LARCENY=larceny -r7 -I .
test-larceny-docker:
	docker build --build-arg SCHEME=larceny -f Dockerfile --tag=r7rs-pffi-larceny .
	${DOCKER} r7rs-pffi-larceny bash -c "${DOCKER_INIT} ${LARCENY} test.scm"

test-larceny: libtest.so
	${LARCENY} test.scm

MOSH=mosh --loadpath=.
test-mosh-docker:
	docker build --build-arg SCHEME=mosh -f Dockerfile --tag=r7rs-pffi-mosh .
	${DOCKER} r7rs-pffi-mosh bash -c "${DOCKER_INIT} ${MOSH} test.scm"

test-mosh: libtest.so
	${MOSH} test.scm

SASH=sash --clean-cache -r7 -L .
test-sagittarius-docker:
	docker build --build-arg SCHEME=sagittarius:head -f Dockerfile --tag=r7rs-pffi-sagittarius .
	${DOCKER} r7rs-pffi-sagittarius bash -c "${DOCKER_INIT} ${SASH} test.scm"

test-sagittarius: libtest.so
	${SASH} test.scm

RACKET=racket -I r7rs -S . --script
test-racket-docker:
	docker build --build-arg SCHEME=racket -f Dockerfile --tag=r7rs-pffi-racket .
	${DOCKER} r7rs-pffi-racket bash -c "${DOCKER_INIT} ${RACKET} test.scm"

test-racket: libtest.so
	${RACKET} test.scm

SKINT=skint
test-skint-docker:
	docker build --build-arg SCHEME=skint:head -f Dockerfile --tag=r7rs-pffi-skint .
	${DOCKER} r7rs-pffi-skint bash -c "${DOCKER_INIT} ${SKINT} test.scm"

test-skint: libtest.so
	${SKINT} test.scm

STKLOS=stklos -A . -f
test-stklos-docker:
	docker build --build-arg SCHEME=stklos:head -f Dockerfile --tag=r7rs-pffi-stklos .
	${DOCKER} r7rs-pffi-stklos bash -c "${DOCKER_INIT} ${STKLOS} test.scm"

test-stklos: libtest.so
	${STKLOS} test.scm

TR7=tr7i
test-tr7-docker:
	docker build --build-arg SCHEME=tr7:head -f Dockerfile --tag=r7rs-pffi-tr7 .
	${DOCKER} r7rs-pffi-tr7 bash -c "${DOCKER_INIT} ${TR7} test.scm"

test-tr7: libtest.so
	${TR7} test.scm

YPSILON=ypsilon --r7rs --sitelib=. --top-level-program
test-ypsilon-docker:
	docker build --build-arg SCHEME=ypsilon -f Dockerfile --tag=r7rs-pffi-ypsilon .
	${DOCKER} r7rs-pffi-ypsilon bash -c "${DOCKER_INIT} ${YPSILON} test.scm"

test-ypsilon: libtest.so
	${YPSILON} test.scm

documentation:
	cat README.md > docs/index.md
	mkdocs build

tmp:
	mkdir -p tmp

clean:
	@rm -rf docutmp
	@rm -rf retropikzel/r7rs-pffi/*.o*
	@rm -rf retropikzel/r7rs-pffi/*.so
	@rm -rf retropikzel/r7rs-pffi/*.meta
	@rm -rf retropikzel/r7rs-pffi/retropikzel.*
	@rm -rf retropikzel/r7rs-pffi/compiled
	@rm -rf retropikzel.*
	find . -name "*.meta" -delete
	@rm -rf test/pffi-define
	@rm -rf test/*gambit*
	find . -name "*.link" -delete
	find . -name "*.c" -not -name "libtest.c" -delete
	find . -name "*.o" -delete
	find . -name "*.o[1-9]" -delete
	find . -name "*.so" -delete
	find . -name "*.a" -delete
	find . -name "*.class" -delete
	@rm -rf test
	@rm -rf tmp
	find . -name "core.1" -delete
	find . -name "*@gambit*" -delete
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.so
	rm -rf retropikzel/r7rs-pffi/r7rs-pffi-chibi.c
