# pffi test


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


### pffi-shared-object-auto-load

Arguments:
- object-name (symbol)


