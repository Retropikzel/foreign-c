;; What follows is a "manifest" equivalent to the command line you gave.
;; You can store it in a file that you may then pass to any 'guix' command
;; that accepts a '--manifest' (or '-m') option.

(specifications->manifest
  (list "guile"
        "racket-minimal"
        "gambit-c"
        "chicken"
        "chibi-scheme"
        "openjdk"
        "curl"
        "sdl2"
        "sdl2-image"
        "sdl2-ttf"
        "sdl2-mixer"
        "ck"
        "zig"
        "gcc-toolchain"))
