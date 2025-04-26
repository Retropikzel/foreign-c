---
title: Portable Foreign Function Interface for R7RS Documentation
version: 0.10.0
---

# (foreign c)

(foreign c) is a C foreign function interface (FFI) library for R7RS. It is
portable in the sense that it supports multiple implementations, as opposed to
being portable by conforming to some specification.

The new readme is a work in progress.

## Implementation table

## Primitives

|                  | c-size-of    | define-c-library    | c-bytevector? | define-c-procedure  | define-c-callbck | c-bytevector-u8-ref |
|------------------|:------------:|:-------------------:|:-------------:|:-------------------:|:----------------:|:-------------------:|
| Chibi            | X            | X                   | X             | X                   |                  | X                   |
| **Chicken**      | X            | X                   | X             | X                   | X                | X                   |
| Gauche           | X            | X                   | X             | X                   |                  |                     |
| **Guile**        | X            | X                   | X             | X                   | X                | X                   |
| Kawa             | X            | X                   | X             | X                   |                  | X                   |
| **Mosh**         | X            | X                   | X             | X                   | X                | X                   |
| **Racket**       | X            | X                   | X             | X                   | X                | X                   |
| **Saggittarius** | X            | X                   | X             | X                   | X                | X                   |
| Stklos           | X            | X                   | X             | X                   |                  | X                   |
| **Ypsilon**      | X            | X                   | X             | X                   | X                | X                   |

## Test files pass

|                  | primitives.scm | addressof.scm |
|------------------|:--------------:|:-------------:|
| Chibi            |                |               |
| **Chicken**      | X              | X             |
| Gauche           |                |               |
| **Guile**        | X              | X             |
| Kawa             |                | X             |
| Mosh             | X              |               |
| Racket           | X              |               |
| **Saggittarius** | X              | X             |
| Stklos           |                | X             |
| Ypsilon          | X              |               |

