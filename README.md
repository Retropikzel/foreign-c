(foreign c) is a C foreign function interface (FFI) library for R6RS and R7RS Schemes

## Documentation

See REFERENCE.md

## Supported implementations

- Chez => 10.0.0
    - R6RS
- Chibi > 0.11
    - R7RS
    - At the time only 0.11 is out so build from git
- Chicken >= 5.4.0 < 6
    - R7RS
- Gauche > 0.9.15
    - R7RS
    - At the time support is work in progress in fork or pull request https://github.com/Retropikzel/Gauche
- Guile >= 3
    - R6RS
    - R7RS
        - Has include bug, might not work on all situations
- Ikarus >= 0.0.4-rc1+
    - R6RS
- Ironscheme
    - R6RS
- Kawa >= 3.11 and Java >= 22
    - R7RS
    - Needs arguments to enable FFI
        - -J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED
        - -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED
        - -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED
        - -J--enable-native-access=ALL-UNNAMED
        - -J--enable-preview
    - All needed arguments on one line for copy pasting
        - -J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED -J--enable-native-access=ALL-UNNAMED -J--enable-preview
    - So that snow-chibi installed library is found
        - -Dkawa.import.path=/usr/local/share/kawa
        - -Dkawa.import.path=/usr/local/share/kawa/lib
- Racket >= 8.16 [cs]
    - R6RS
        - Unable to run tests as Rackets SRFI-64 implementation does not work
    - R7RS
- Sagittarius >= 0.9.13
    - R6RS
    - R7RS
- STklos > 2.10
    - R7RS
    - At the time only 2.10 is out so build from git
- Ypsilon >= 2.08
    - R6RS
    - R7RS



## Work in progress

- Cyclone
    - R7RS
- Gambit
    - R7RS
- Gerbil
    - R7RS
- Mit-Scheme
    - R7RS
- Mosh
    - R6RS
    - R7RS
- Larceny
    - R6RS
    - R7RS



## Installation


### R6RS - Akku

In your project directory run:

    akku install "(foreign c)"


### R6RS - Manual

    Dowloand the latest release or clone from git and copy directory named
    "foreign" into your project, then run:

        akku install


### R7RS - Snow-fort

[https://snow-fort.org/](https://snow-fort.org/)

snow-chibi --impls=IMPLEMENTATION install "(foreign c)"

You can test that library is found by your implementation like this:

    cp tests/hello.scm /tmp/hello.scm
    cd /tmp
    IMPLEMENTATION hello.scm



### R7RS Manual

Manual system wide installation requires snow-chibi.

Either download the latest release from
[https://git.sr.ht/~retropikzel/foreign-c/refs](https://git.sr.ht/~retropikzel/foreign-c/refs)
or git clone, tag, and copy the foreign directory to your
library directory.

Example for how to install for Gauche:

    apt-get install libffi-dev
    git clone https://git.sr.ht/~retropikzel/foreign-c
    cd foreign-c
    make SCHEME=gauche
    make SCHEME=gauche install



