# Portable Foreign Function Interface for R7RS schemes

For documentation see
[Wiki](https://codeberg.org/r7rs-pffi/pffi/wiki/Documentation)

For bugs you can use the
[Bugs](https://codeberg.org/r7rs-pffi/pffi/projects/9101)

## Supports

- [Sagittarius](https://bitbucket.org/ktakashi/sagittarius-scheme/wiki/Home)
- [Guile](https://www.gnu.org/software/guile/)
- [Kawa](https://www.gnu.org/software/kawa/index.html)
  - Needs atleast java 21
  - Needs jvm flags
    - java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar FILENAME.scm

## Support is work in progress

- [Racket](https://racket-lang.org/)
- [STKlos](https://stklos.net/)
- [Cyclone](https://justinethier.github.io/cyclone/)
- [Chicken](https://www.call-cc.org/)

## Support is waiting for the implementation

- [LIPS](https://lips.js.org/)
  - Waiting for implementation to have cond-expand and library support
  - Will only work on nodejs


## Hacking

main.sld is the real main which is copied to other suffixes like .scm and .rkt.

