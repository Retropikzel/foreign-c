# pffi


## Procedures


### pffi-call

Arguments:

- shared-object (object)
  - Shared object returned by pffi-shared-object-load or pffi-shared-object-auto-load
- name (symbol)
  - Name of the C function you want to call
- type (symbol)
  - Return type of the C function you want to call
- arguments (list (cons type value)...)
  - Arguments you want to pass to the C function as pairs of type and value

Example:

(define sdl2* (pffi-shared-object-auto-load "SDL2" (list))

(pffi-call sdl2* 'SDL_Init 'int '((int . 32)))

(define window* (pffi-call sdl2*
                          'SDL_CreateWindow
                          'pointer
                          (list (cons 'pointer (pffi-string->pointer "Hello"))
                                (cons 'int 1)
                                (cons 'int 1)
                                (cons 'int 400)
                                (cons 'int 400)
                                (cons 'int 4))


### pffi-shared-object-load

Arguments:
- path (string) The path to the shared object you want to load, including any "lib" infront and .so/.dll at the end

Returns:



### pffi-shared-object-auto-load

Arguments:
- object-name (symbol)
 - The name of the dynamic library file you want to load without the "lib" in fron of it or .so/.dll at the end
- addition-paths (list (string)...)
 - Any additional paths you want to search for the library

Returns:
- (object) Shared object, the type depends on the implementation


