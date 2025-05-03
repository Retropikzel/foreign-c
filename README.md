---
title: (foreign c) a portable foreign function interface for R7RS
version: 0.10.0
---

# (foreign c)

(foreign c) is a C foreign function interface (FFI) library for R7RS. It is
portable in the sense that it supports multiple implementations, as opposed to
being portable by conforming to some specification.

The new readme is a work in progress.

## Implementation table

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


## Documentation

### Primitives

(**c-type-size** _type_)

Returns the size of given C type.

(define-c-library)
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
