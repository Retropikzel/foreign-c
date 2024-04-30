VERSION=v0.1.0
RACKETEXE=${HOME}/.wine/drive_c/Program Files/Racket/racket.exe

test-sagittatius-sdl2:
	sash -r7 -L . test/sdl2.scm

test-guile-sdl2:
	guile --debug --r7rs -L . test/sdl2.scm

build-rkt:
	echo "#lang r7rs" > retropikzel/pffi/${VERSION}/main.rkt
	cat retropikzel/pffi/${VERSION}/main.scm >> retropikzel/pffi/${VERSION}/main.rkt

test-racket-load: build-rkt
	racket -I r7rs retropikzel/pffi/${VERSION}/main.rkt

test-racket-load-wine: build-rkt
	wine64 ${RACKETEXE} -I r7rs retropikzel/pffi/${VERSION}/main.rkt

test-racket-hello: build-rkt
	racket -I r7rs -S $(shell pwd) -f test/hello.scm

test-racket-hello-wine: build-rkt
	wine64 ${RACKETEXE} -I r7rs -S $(shell pwd) -f test/hello.scm

test-racket-sdl2: build-rkt
	racket -I r7rs -S $(shell pwd) -f test/sdl2.scm
