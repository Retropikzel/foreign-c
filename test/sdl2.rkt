#lang r7rs
(import (scheme base)
        (scheme write)
        (scheme read)
        (retropikzel pffi v0.1.0 main))


(define sdl2 (pffi-shared-object-auto-load "SDL2" (list)))

(pffi-call sdl2 'SDL_Init 'int '((int . 32)))

(define window (pffi-call sdl2
                          'SDL_CreateWindow
                          'pointer
                          (list (cons 'pointer (pffi-string->pointer "Testing pffi"))
                                (cons 'int 1)
                                (cons 'int 1)
                                (cons 'int 400)
                                (cons 'int 400)
                                (cons 'int 4))))

(define renderer (pffi-call sdl2
                            'SDL_CreateRenderer
                            'pointer
                            (list (cons 'pointer window)
                                  (cons 'int -1)
                                  (cons 'int 2))))

(pffi-call sdl2 'SDL_RenderClear 'int (list (cons 'pointer renderer)))
(pffi-call sdl2 'SDL_RenderPresent 'int (list (cons 'pointer renderer)))

(display (pffi-call sdl2 'SDL_Delay 'void '((int . 2000))))

