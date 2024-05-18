# Portable Foreign Function Interface for R7RS schemes

For documentation see
[Wiki](https://codeberg.org/r7rs-pffi/pffi/wiki/Documentation)

For bugs you can use the
[Bugs](https://codeberg.org/r7rs-pffi/pffi/projects/9101)

## All tests pass

- [Sagittarius](https://bitbucket.org/ktakashi/sagittarius-scheme/wiki/Home)
- [Guile](https://www.gnu.org/software/guile/)
- [Kawa](https://www.gnu.org/software/kawa/index.html)
  - Needs atleast java 21
  - Needs jvm flags
    - java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar FILENAME.scm
- [Racket](https://racket-lang.org/)
- [Chicken](https://www.call-cc.org/)

## Not all tests pass

- [STKlos](https://stklos.net/)
- [Cyclone](https://justinethier.github.io/cyclone/)
- [Gambit](https://gambitscheme.org)

## Waiting for the implementation

- [LIPS](https://lips.js.org/)
  - Waiting for implementation to have cond-expand and library support
  - Will only work on nodejs

## Not supported

- [Chibi](https://synthcode.com/scheme/chibi)
  - FFI requires C code
- [MIT-Scheme](https://www.gnu.org/software/mit-scheme/)
  - FF requires C code
- [tr7](https://gitlab.com/jobol/tr7)
  - FFI requires C code
- [Gauche](https://practical-scheme.net/gauche/)
  - FFI requires C code


## Hacking

main.sld is the real main which is copied to main.scm

## Documentation

On some implementations these are procedures, on some macros.

### pffi-shared-object-auto-load

Arguments:

- object-name (symbol)
  - The name of the dynamic library file you want to load without the "lib" in fron of it or .so/.dll at the end
- addition-paths (list (string)...)
  - Any additional paths you want to search for the library

Returns:

- (object) Shared object, the type depends on the implementation

### pffi-shared-object-load

It is recommended to use the pffi-shared-object-auto-load instead of this
directly.

Arguments:

  - headers (list (string) ...) Headers that need to be included
    - Example (list "curl/curl.h")
  - path (string) The full path to the shared object you want to load, including any "lib" infront and .so/.dll at the end
    - Example "libcurl.so"

Returns:

- (object) Shared object, the type depends on the implementation



