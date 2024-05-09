# Portable Foreign Function Interface for R7RS schemes

Currently supported implementations
- [Sagittarius](https://bitbucket.org/ktakashi/sagittarius-scheme/wiki/Home)
- [Guile](https://www.gnu.org/software/guile/)
- [Kawa](https://www.gnu.org/software/kawa/index.html)
  - Needs atleast java 21
  - Needs jvm flags
    - java --add-exports java.base/jdk.internal.foreign.abi=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign.layout=ALL-UNNAMED --add-exports java.base/jdk.internal.foreign=ALL-UNNAMED --enable-native-access=ALL-UNNAMED --enable-preview -jar kawa.jar FILENAME.scm

For documentation see
[Wiki](https://codeberg.org/r7rs-pffi/pffi/wiki/Documentation)

For bugs you can use the
[Bugs](https://codeberg.org/r7rs-pffi/pffi/projects/9101)
