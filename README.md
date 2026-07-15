(foreign c) is a C foreign function interface (FFI) library for R6RS and R7RS Schemes



## Documentation

See REFERENCE.md



## Tests

[Jenkins](https://jenkins.scheme.org/job/foreign_c/job/foreign-c/)



## Roadmap

Things that are done should not change anymore. But note that (foreign c) is
still pre 1.0.0 so it's not 100% sure.

- Done
    - Loading C libraries
    - Calling C functions
    - Basic pointer handling
    - C pointer to string and back conversions
    - Passing pointers by address
- In Progress
    - Handling array and struct pointers more ergonomically
- Todo
    - Callbacks
    - Type definitions



## Supported implementations

R6RS is supported trough akku and akku-r7rs.

- Chez => 10.0.0
    - R6RS
- Chibi > 0.11
    - R7RS
- Chicken >= 6.0.0
    - R7RS
- Ikarus >= 0.0.4-rc1+
    - R6RS
- Ironscheme
    - R6RS
- Kawa >= 3.11 and Java >= 24
    - R7RS
    - Needs arguments to enable FFI
        - -J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED
        - -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED
        - -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED
        - -J--enable-native-access=ALL-UNNAMED
    - All needed arguments on one line for copy pasting
        - -J--add-exports=java.base/jdk.internal.foreign.abi=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign.layout=ALL-UNNAMED -J--add-exports=java.base/jdk.internal.foreign=ALL-UNNAMED -J--enable-native-access=ALL-UNNAMED
    - So that snow-chibi installed library is found
        - -Dkawa.import.path=/usr/local/share/kawa/lib/*.sld
- Mosh
    - R7RS
- Racket >= 8.16 [cs]
    - R7RS
- Sagittarius >= 0.9.13
    - R6RS
    - R7RS
- STklos >= 26.0
    - R7RS
- Ypsilon >= 2.08
    - R7RS



## Work in progress

- Capyscheme
    - R6RS
    - R7RS
- Cyclone
    - R7RS
- Gambit
    - R7RS
- Gauche
    - R7RS
- Gerbil
    - R7RS
- Guile
    - R6RS
    - R7RS
- Mit-Scheme
    - R7RS
- Mosh
    - R6RS
- Racket
    - R6RS
        - Unable to run tests as it cant find SRFI-64
- Larceny
    - R6RS
    - R7RS
- Ypsilon
    - R6RS
        - Problems with akku-r7rs



### Native dependencies

- Chibi
    - libffi




## Installation


### R6RS - Akku

In your project directory run:

    akku install "(foreign c)"


### R6RS - Manual

    Download the latest release or clone from git and copy directory named
    "foreign" into your project, then run:

        akku install


### R7RS - Snow-fort

[https://snow-fort.org/](https://snow-fort.org/)

snow-chibi --impls=IMPLEMENTATION install "(foreign c)"

### R7RS installing manually

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



### Adding support for new implementation

- Make the library files foreign/c/YOURSCHEME-primitives.scm
- Include it in cond expand in foreign/c.sld

#### Implementation specific code

SCHEME-primitives.scm **must** implement:

- shared-object-load
- define-c-procedure
- c-u8-ref
- c-u8-set!
- c-pointer-ref
- c-pointer-set!
- c-null
- c-null?

YOURSCHEME-primitives.scm **optionally** can implement:

- define-c-callback

If there is no support for callbacks then this stub must be there:


    (define-syntax define-c-callback
      (syntax-rules ()
        ((_ scheme-name return-type argument-types procedure)
         (define scheme-name
           (error "define-c-callback not yet supported on YOURSCHEME")))))


Run tests with:

    make SCHEME=YOURSCHEME test-r6rs

or

    make SCHEME=YOURSCHEME test-r6rs
