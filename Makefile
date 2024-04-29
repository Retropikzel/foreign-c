test-sagittatius-sdl2:
	sash -r7 -L . test/sdl2.scm

test-guile-sdl2:
	guile --debug --r7rs -L . test/sdl2.scm
