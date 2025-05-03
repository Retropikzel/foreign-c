---
title: foreign-c a portable foreign function interface for R7RS
version: 0.10.0
---

# foreign-c

foreign-c is a C foreign function interface (FFI) library for R7RS. It is
portable in the sense that it supports multiple implementations, as opposed to
being portable by conforming to some specification.

[Issue tracker](https://sr.ht/~retropikzel/foreign-c/trackers)

[Maling lists](https://sr.ht/~retropikzel/foreign-c/lists)

- [Installation](#installation)
- [Documentation](#documentation)
    - [Types](#types)
    - [Primitives](#primitives)
    - [c-bytevector](#c-bytevector)
    - [Environment variables](#environment-variables)


## Implementation support tables

### Primitives 1

|                  | c-size-of    | c-bytevector-u8-set! |c-bytevector-u8-ref | define-c-library    | c-bytevector? | define-c-procedure  |
|------------------|:------------:|:--------------------:|:------------------:|:-------------------:|:-------------:|:-------------------:|
| **Chibi**        | X            | X                    |X                   | X                   | X             | X                   |
| **Chicken**      | X            | X                    |X                   | X                   | X             | X                   |
| **Gauche**       | X            | X                    |X                   | X                   | X             | X                   |
| **Guile**        | X            | X                    |X                   | X                   | X             | X                   |
| **Kawa**         | X            | X                    |X                   | X                   | X             | X                   |
| **Mosh**         | X            | X                    |X                   | X                   | X             | X                   |
| **Racket**       | X            | X                    |X                   | X                   | X             | X                   |
| **Saggittarius** | X            | X                    |X                   | X                   | X             | X                   |
| **Stklos**       | X            | X                    |X                   | X                   | X             | X                   |
| **Ypsilon**      | X            | X                    |X                   | X                   | X             | X                   |

### Primitives 2

|                  | define-c-callback |
|------------------|:-----------------:|
| Chibi            |                   |
| **Chicken**      | X                 |
| Gauche           |                   |
| **Guile**        | X                 |
| Kawa             |                   |
| **Mosh**         | X                 |
| **Racket**       | X                 |
| **Saggittarius** | X                 |
| Stklos           |                   |
| **Ypsilon**      | X                 |

### Test files pass

|                  | primitives.scm | addressof.scm | callback.scm |
|------------------|:--------------:|:-------------:|-------------:|
| Chibi            | X              | X             |              |
| **Chicken**      | X              | X             | X            |
| Gauche           | X              | X             |              |
| **Guile**        | X              | X             | X            |
| Kawa             | X              | X             |              |
| Mosh             | X              | X             |              |
| Racket           | X              |               |              |
| **Saggittarius** | X              | X             | X            |
| Stklos           | X              | X             |              |
| Ypsilon          | X              | X             |              |

### Installation

Either download the latest release from
[https://git.sr.ht/~retropikzel/foreign-c/refs](https://git.sr.ht/~retropikzel/foreign-c/refs) or git clone
, preferably with a tag, and copy the "foreign" directory to your library
directory.

As an example assuming you have a project and your libraries live in directory
called snow in it:

    git clone https://git.sr.ht/~retropikzel/foreign-c --branch LATEST_VERSION
    mkdir -p snow
    cp -r foreign-c/foreign snow/
    make -C snow/foreign/c <SCHEME_IMPLEMENTATION_NAME>

With most implementations the make command does not compile anything. When that
is the case it will say "Nothing to build on SCHEME\_IMPLEMENTATION\_NAME."

## Documentation

### Types

Types are given as symbols, for example 'int8 or 'pointer.

- int8
- uint8
- int16
- uint16
- int32
- uint32
- int64
- uint64
- char
- unsigned-char
- short
- unsigned-short
- int
- unsigned-int
- long
- unsigned-long
- float
- double
- pointer
- callback
    - Callback function

### Primitives

(**c-type-size** _type_)

Returns the size of given C type.

(**define-c-library** _scheme-name_ _headers_ _object-name_ _options_)

Takes a scheme-name to bind the library to, list of C headers as
strings, shared-object name and options.

The C header strings should not contain "<" or ">", they are added
automatically.

The name of the shared object should not contain suffix like .so or .dll.
Nor should it contain any prefix like "lib".

The options are:

- additional-versions
    - Search for additional versions of shared object, given shared object "c"
    and additional versions "6" "7" on linux the files "libc", "libc.6",
    "libc.7" are searched for.
    - Can be either numbers or strings
- additional-paths
    - Give additional paths to search shared objects from

Example:

    (cond-expand
      (windows (define-c-library libc-stdlib
                                    '("stdlib.h")
                                    "ucrtbase"
                                    '((additional-versions ("0" "6"))
                                      (additiona-paths (".")))))
      (else (define-c-library libc-stdlib
                                 (list "stdlib.h")
                                 "c"
                                 '((additional-versions ("0" "6"))
                                   (additiona-paths ("."))))))

#### Notes

- Do not cond-expand inside the arguments, that might lead to problems on some
implementations.
- Do not store options in variables, that might lead to problems on some
implementations.
- Do pass the headers using quote
    - As '(... and not (list...
- Do pass the options using quote
    - As '(... and not (list...
define-c-procedure
define-c-callback
c-bytevector?
c-bytevector-u8-set!
c-bytevector-u8-ref
c-bytevector-pointer-set!
c-bytevector-pointer-ref


### c-bytevector
make-c-bytevector
make-c-null
c-null?
c-free
native-endianness
c-bytevector-s8-set!
c-bytevector-s8-ref
c-bytevector-s16-set!
c-bytevector-s16-ref
c-bytevector-s16-native-set!
c-bytevector-s16-native-ref
c-bytevector-u16-set!
c-bytevector-u16-ref
c-bytevector-u16-native-set!
c-bytevector-u16-native-ref
c-bytevector-s32-set!
c-bytevector-s32-ref
c-bytevector-s32-native-set!
c-bytevector-s32-native-ref
c-bytevector-u32-set!
c-bytevector-u32-ref
c-bytevector-u32-native-set!
c-bytevector-u32-native-ref
c-bytevector-s64-set!
c-bytevector-s64-ref
c-bytevector-s64-native-set!
c-bytevector-s64-native-ref
c-bytevector-u64-set!
c-bytevector-u64-ref
c-bytevector-u64-native-set!
c-bytevector-u64-native-ref
c-bytevector-sint-set!
c-bytevector-sint-ref
c-bytevector-uint-set!
c-bytevector-uint-ref
c-bytevector-ieee-single-set!
c-bytevector-ieee-single-native-set!
c-bytevector-ieee-single-ref
c-bytevector-ieee-single-native-ref
c-bytevector-ieee-double-set!
c-bytevector-ieee-double-native-set!
c-bytevector-ieee-double-ref
c-bytevector-ieee-double-native-ref
bytevector->c-bytevector
c-bytevector->bytevector
call-with-address-of

string->c-utf8
c-utf8->string

### Environment variables

Setting environment variables like this on Windows works for this library:

    set "PFFI_LOAD_PATH=C:\Program Files (x86)/foo/bar"

#### PFFI\_LOAD\_PATH

To add more paths to where pffi looks for libraries set PFFI\_LOAD\_PATH to
paths separated by ; on windows, and : on other operating systems.

