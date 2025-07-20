# foreign-c

foreign-c is a C foreign function interface (FFI) library for R7RS Schemes. It
is portable in the sense that it supports multiple implementations.

[Issue tracker](https://sr.ht/~retropikzel/foreign-c/trackers)

[Maling lists](https://sr.ht/~retropikzel/foreign-c/lists)

[Jenkins](https://jenkins.scheme.org/job/retropikzel/job/foreign-c/)

- [Installation](#installation)
- [Documentation](#documentation)
    - [Types](#types)
    - [Primitives 1](#primitives-1)
        - c-type-size
        - define-c-library
        - define-c-procedure
        - c-bytevector?
        - c-bytevector-u8-set!
        - c-bytevector-u8-ref
        - c-bytevector-pointer-set!
        - c-bytevector-pointer-ref
    - [Primitives 2](#primitives-2)
        - define-c-callback
    - [c-bytevector](#c-bytevector)
        - make-c-null
        - c-null?
        - c-free
        - make-c-bytevector
        - call-with-address-of
        - native-endianness
        - c-bytevector-s8-set!
        - c-bytevector-s8-ref
        - c-bytevector-s16-set!
        - c-bytevector-s16-ref
        - c-bytevector-s16-native-set!
        - c-bytevector-s16-native-ref
        - c-bytevector-u16-set!
        - c-bytevector-u16-ref
        - c-bytevector-u16-native-set!
        - c-bytevector-u16-native-ref
        - c-bytevector-s32-set!
        - c-bytevector-s32-ref
        - c-bytevector-s32-native-set!
        - c-bytevector-s32-native-ref
        - c-bytevector-u32-set!
        - c-bytevector-u32-ref
        - c-bytevector-u32-native-set!
        - c-bytevector-u32-native-ref
        - c-bytevector-s64-set!
        - c-bytevector-s64-ref
        - c-bytevector-s64-native-set!
        - c-bytevector-s64-native-ref
        - c-bytevector-u64-set!
        - c-bytevector-u64-ref
        - c-bytevector-u64-native-set!
        - c-bytevector-u64-native-ref
        - c-bytevector-sint-set!
        - c-bytevector-sint-ref
        - c-bytevector-uint-set!
        - c-bytevector-uint-ref
        - c-bytevector-ieee-single-set!
        - c-bytevector-ieee-single-native-set!
        - c-bytevector-ieee-single-ref
        - c-bytevector-ieee-single-native-ref
        - c-bytevector-ieee-double-set!
        - c-bytevector-ieee-double-native-set!
        - c-bytevector-ieee-double-ref
        - c-bytevector-ieee-double-native-ref
        - bytevector-\>c-bytevector
        - c-bytevector-\>bytevector
        - string-\>c-utf8
        - c-utf8-\>string
    - [Environment variables](#environment-variables)


## Implementation support tables

*NOTE* Implementation missing from this table does not mean it will not be
supported. Either the work on it has not started yet or support for missing
implementations is so unfinished that they are not listed here.

Required versions:

- Chibi > 0.11
    - At the time only 0.11 is out so build from git
- Chicken >= 5.4.0 < 6
- Gauche >= 0.9.15
    - Does not yet work with snow-chibi install
- Guile >= 3
    - Does not yet work with snow-chibi install
    - Has include bug, might not work on all situations
- Kawa >= 3.11 and Java >= 22
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
- Mosh >= 0.2.9-rc1
- Racket >= 8.16 [cs]
- Sagittarius >= 0.9.13
- STklos > 2.10
    - At the time only 2.10 is out so build from git


### Primitives 1 table


|                  | c-type-size  | c-bytevector-u8-set! |c-bytevector-u8-ref | define-c-library    | c-bytevector? | define-c-procedure  |
|------------------|:------------:|:--------------------:|:------------------:|:-------------------:|:-------------:|:-------------------:|
| **Chibi**        | X            | X                    |X                   | X                   | X             | X                   |
| **Chicken**      | X            | X                    |X                   | X                   | X             | X                   |
| **Gauche**       | X            | X                    |X                   | X                   | X             | X                   |
| **Guile**        | X            | X                    |X                   | X                   | X             | X                   |
| **Kawa**         | X            | X                    |X                   | X                   | X             | X                   |
| **Mosh**         | X            | X                    |X                   | X                   | X             | X                   |
| **Racket**       | X            | X                    |X                   | X                   | X             | X                   |
| **Sagittarius**  | X            | X                    |X                   | X                   | X             | X                   |
| **STklos**       | X            | X                    |X                   | X                   | X             | X                   |
| **Ypsilon**      | X            | X                    |X                   | X                   | X             | X                   |


### Primitives 2 table


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
| STklos           |                   |
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
| STklos           | X              | X             |              |
| Ypsilon          | X              | X             |              |


## Installation

### Snow-fort

Not yet installable with snow-fort:

- Gauche
- Guile

[https://snow-fort.org/](https://snow-fort.org/)

snow-chibi --impls=IMPLEMENTATION install "(foreign c)"

You can test that library is found by your implementation like this:

    cp tests/hello.scm /tmp/hello.scm
    cd /tmp
    IMPLEMENTATION hello.scm

### Manual

Either download the latest release from
[https://git.sr.ht/~retropikzel/foreign-c/refs](https://git.sr.ht/~retropikzel/foreign-c/refs)
or git clone, tag, and copy the _foreign_ directory to your
library directory.

Example assuming libraries in directory _snow_:

    git clone https://git.sr.ht/~retropikzel/foreign-c --branch LATEST_VERSION
    cd foreign-c
    make SCHEME_IMPLEMENTATION_NAME
    cd ..
    mkdir -p snow
    cp -r foreign-c/foreign snow/

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
    - c-bytevector on Scheme side
- callback
    - Callback function
- void
    - Can not be argument type, only return type

### Primitives 1

(**c-type-size** _type_)

Returns the size of given C type.

(**define-c-library** _scheme-name_ _headers_ _object-name_ _options_)

Takes a scheme-name to bind the library to, list of C headers as
strings, shared-object name and options.

The C header strings should not contain "<" or ">", they are added
automatically.

The name of the shared object should not contain suffix like .so or .dll.
Nor should it contain any prefix like "lib".

Options:

- additional-versions
    - Search for additional versions of shared object, given shared object "c"
    and additional versions "6" "7" on linux the files "libc", "libc.6",
    "libc.7" are searched for.
    - Can be either numbers or strings
- additional-paths
    - Give additional paths to search shared objects from

Example:

    (define-c-library libc
                      (list "stdlib.h")
                      libc-name
                      '((additional-versions ("" "0" "6"))
                        (additional-paths ("."))))

#### Notes

- Do not cond-expand inside the arguments, that might lead to problems on some
implementations.
- Do not store options in variables, that might lead to problems on some
implementations.
- Pass the headers using quote
    - As '(...) and not (list...)
- Pass the options using quote
    - As '(...) and not (list...)

(**define-c-procedure** _scheme-name_ _shared-object_ _c-name_ _return-type_
_argument-type_)

Takes a scheme-name to bind the C procedure to, shared-object where the function
is looked from, c-name of the function as symbol, return-type and argument-types.

Defines a new foreign function to be used from Scheme code.


Example:

    (define-c-library libc '("stdlib.h") libc-name '("6"))
    (define-c-procedure c-puts libc 'puts 'int '(pointer))
    (c-puts "Message brought to you by foreign-c!")

#### Notes

- Pass the return-types using quote
    - As '(...) and not (list...)

(**c-bytevector?** _obj_)

Returns **#t** if _obj_ is c-bytevector, otherwise returns **#f**.

(**c-bytevector-u8-set!** _c-bytevector_ _k_ _byte_)

If K is not a valid index of c-bytevector the behaviour is undefined.

Stores the byte in element k of c-bytevector.

(**c-bytevector-u8-ref** _c-bytevector_ _k_)

If K is not a valid index of c-bytevector the behaviour is undefined.

Returns the byte at index k of c-bytevector.

(**c-bytevector-pointer-set!** _c-bytevector_ _k_ _pointer_)

If K is not a valid index of c-bytevector the behaviour is undefined.

Stores the pointer(which is also c-bytevector) in element k of c-bytevector.

(**c-bytevector-pointer-ref**  _c-bytevector_ _k_ _pointer_)

If K is not a valid index of c-bytevector the behaviour is undefined.

Returns the pointer(which is also c-bytevector) at index k of c-bytevector.

### Primitives 2
(**define-c-callback** _scheme-name_ _return-type_ _argument-types_ _procedure_)

Takes scheme-name to bind the Scheme procedure to, return-type, argument-types
and procedure as in place lambda.

Defines a new Sceme function to be used as callback to C code.

Example:

    ; Load the shared library
    (define-c-library libc-stdlib '("stdlib.h") libc-name '("" "6"))

    ; Define C function that takes a callback
    (define-c-procedure qsort libc-stdlib 'qsort 'void '(pointer int int callback))

    ; Define our callback
    (define-c-callback compare
                          'int
                          '(pointer pointer)
                          (lambda (pointer-a pointer-b)
                            (let ((a (c-bytevector-sint-get pointer-a (native-endianness) 0))
                                  (b (c-bytevector-sint-get pointer-b (native-endianness) 0)))
                              (cond ((> a b) 1)
                                    ((= a b) 0)
                                    ((< a b) -1)))))

    ; Create new array of ints to be sorted
    (define array (make-c-bytevector (* (c-type-size 'int) 3)))
    (c-bytevector-s32-native-set! array (* (c-type-size 'int) 0) 3)
    (c-bytevector-s32-native-set! array (* (c-type-size 'int) 1) 2)
    (c-bytevector-s32-native-set! array (* (c-type-size 'int) 2) 1)

    (display array)
    (newline)
    ;> (3 2 1)

    ; Sort the array
    (qsort array 3 (c-type-size 'int) compare)

    (display array)
    (newline)
    ;> (1 2 3)

### c-bytevector

Foreign-c c-bytevector interface is copied from R6RS bytevectors, with some
added functionality for C null pointers and manual memory management.

(**make-c-null**)

Returns a null C pointer.

(**c-null?** _obj_)

Returns **#t** if _obj_ is a null C pointer, otherwise returns **#f**.

(**c-free** _c-bytevector_)

Frees _c-bytevector_ from memory.

(**call-with-address-of** _c-bytevector_ _thunk_)

Calls _thunk_ with address pointer of _c-bytevector_.

Since the support for calling C functions taking pointer address arguments,
ones prefixrd with & in C, varies, some additional ceremony is needed on
the Scheme side.

Example:

Calling from C:

    //void func(int** i);
    func(&i);

Calling from Scheme:

    (define cbv (make-bytevector (c-type-size 'int)))
    (call-with-address-of
     cbv
     (lambda (address)
      (func address)))
    ; Use cbv here

The passed c-bytevector, in example named cbv, should only be used **after**
call to call-with-addres-of ends.

(**bytevector->c-bytevector** _bytevector_)

Returns a newly allocated c-bytevector of the bytes of _bytevector_.

(**c-bytevector->bytevector**)

Returns a newly allocated bytevector of the bytes of _c-bytevector_.

(**native-endianness**)

Returns the endianness symbol associated implementation’s preferred endianness
(usually that of the underlying machine architecture).  This may be any
\<endianness symbol\>, including a symbol other than big and little.

(**make-c-bytevector** _k_)</br>
(**make-c-bytevector** _k_ _fill_)

Returns a newly allocated c-bytevector of _k_ bytes.

If the _fill_ argument is missing, the initial contents of the
returned c-bytevector are unspecified.

If the _fill_ argument is present, it's value must confine to C uint8_t values
, it specifies the initial value for the bytes of the c-bytevector


(**c-bytevector-s8-set!** _c-bytevector_ _k_ _byte_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Stores the _byte_ in element _k_ of _c-bytevector_.

(**c-bytevector-s8-ref** _c-bytevector_ _k_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Returns the byte at index _k_ of _c-bytevector_.

(**c-bytevector-char-set!** _c-bytevector_ _k_ _char_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Stores the _char_ in element _k_ of _c-bytevector_.

(**c-bytevector-char-ref** _c-bytevector_ _k_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Returns the char at index _k_ of _c-bytevector_.

(**c-bytevector-uchar-set!** _c-bytevector_ _k_ _char_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Stores the unsigned _char_ in element _k_ of _c-bytevector_.

(**c-bytevector-uchar-ref** _c-bytevector_ _k_)

If _k_ is not a valid index of c-bytevector the behaviour is undefined.

Returns the unsigned char at index _k_ of _c-bytevector_.

(**c-bytevector-uint-ref** _c-bytevector_ _k_ _endianness_ _size_)</br>
(**c-bytevector-sint-ref** _c-bytevector_ _k_ _endianness_ _size_)</br>
(**c-bytevector-uint-set!** _c-bytevector_ _k_ _n_ _endianness_ _size_)</br>
(**c-bytevector-sint-set!** _c-bytevector_ _k_ _n_ _endianness_ _size_)

Size must be a positive exact integer object. If _k_,...,_k_ + _size_ − 1 is
not valid indices of c-bytevector the behavior is unspecified.

The c-bytevector-uint-ref procedure retrieves the exact integer object
corresponding to the unsigned representation of size _size_ and specified by
_endianness_ at indices _k_,...,_k_ + _size_ − 1.

The c-bytevector-sint-ref procedure retrieves the exact integer object
corresponding to the two’s-complement representation of size _size_ and
specified by _endianness_ at indices _k_,...,_k_ + _size_ − 1.  For
c-bytevector-uint-set!, _n_ must be an exact integer object in the interval
{0,...,256^_size_ − 1}.

The c-bytevector-uint-set! procedure stores the unsigned representation of
size _size_ and specified by _endianness_ into c-bytevector at indices
_k_,...,_k_ + size − 1.

The . . . -set! procedures return unspecified values.

Examples:

    (define cbv (make-c-bytevector (c-type-size 'int)))
    (c-bytevector-sint-set! cbv 0 100 (native-endianness) (c-type-size 'int))
    (c-bytevector-sint-ref cbv 0 (native-endianness) (c-type-size 'int))
    > 100


(**c-bytevector-u16-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-s16-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-u16-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-s16-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-u16-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-s16-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-u16-native-set!** _c-bytevector_ _k_ _n_)</br>
(**c-bytevector-s16-native-set!** _c-bytevector_ _k_ _n_)

_K_ must be a valid index of _c-bytevector_ ; so must _k_ + 1.  For
c-bytevector-u16-set! and c-bytevector-u16-native-set!, _n_ must be an exact
integer object in the interval {0,...,216 − 1}. For c-bytevector-s16-set! and
c-bytevector-s16-native-set!, _n_ must be an exact integer object in the
interval {−215,...,215 − 1}.

These retrieve and set two-byte representations of numbers at indices _k_ and
_k_ + 1, according to the endianness specified by _endianness_. The procedures
with u16 in their names deal with the unsigned representation; those with s16
in their names deal with the two’s-complement representation.

The procedures with native in their names employ the native endianness, and
work only at aligned indices: _k_ must be a multiple of 2.

The ...-set!  procedures return unspecified values.

(**c-bytevector-u32-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-s32-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-u32-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-s32-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-u32-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-s32-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-u32-native-set!** _c-bytevector_ _k_ _n_)</br>
(**c-bytevector-s32-native-set!** _c-bytevector_ _k_ _n_)

_K_,...,_k_ + 3 must be valid indices of bytevector.  For c-bytevector-u32-set!
and bytevector-u32-native-set!, _n_ must be an exact integer object in the
interval {0,...,232 − 1}. For bytevector-s32-set! and
bytevector-s32-native-set!, _n_ must be an exact integer object in the
interval {−231,...,232 − 1}.

These retrieve and set four-byte representations of numbers at indices
_k_,...,_k_ + 3, according to the endianness specified by _endianness_.
The procedures with u32 in their names deal with the unsigned representation;
those with s32 with the two’s-complement representation.

The procedures with native in their names employ the native endianness, and
work only at aligned indices: _k_ must be a multiple of 4.

The ...-set!  procedures return unspecified values.

(**c-bytevector-u64-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-s64-ref** _c-bytevector_ _k_ _endianness_)</br>
(**c-bytevector-u64-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-s64-native-ref** _c-bytevector_ _k_)</br>
(**c-bytevector-u64-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-s64-set!** _c-bytevector_ _k_ _n_ _endianness_)</br>
(**c-bytevector-u64-native-set!** _c-bytevector_ _k_ _n_)</br>
(**c-bytevector-s64-native-set!** _c-bytevector_ _k_ _n_)

_K_,...,_k_ + 7 must be valid indices of _c-bytevector_.  For
c-bytevector-u64-set! and c-bytevector-u64-native-set!, _n_ must be an exact
integer object in the interval {0,...,264 − 1}. For c-bytevector-s64-set! and
c-bytevector-s64-native-set!, _n_ must be an exact integer object in the
interval {−263,...,264 − 1}.

These retrieve and set eight-byte representations of numbers at indices
_k_,...,_k_ + 7, according to the endianness specified by _endianness_. The
procedures with u64 in their names deal with the unsigned representation; those
with s64 with the two’s-complement representation.

The procedures with native in their names employ the native endianness, and
work only at aligned indices: _k_ must be a multiple of 8.

The ...-set! procedures return unspecified values.

(**c-bytevector-ieee-single-native-ref**)</br>
(**c-bytevector-ieee-single-ref**)</br>

_K_,...,_k_ + 3 must be valid indices of _c-bytevector_. For
c-bytevector-ieee-single-native-ref, _k_ must be a multiple of 4.

These procedures return the inexact real number object that best represents the
IEEE-754 single-precision number represented by the four bytes beginning at
index _k_.

(**c-bytevector-ieee-double-native-ref**)</br>
(**c-bytevector-ieee-double-ref**)

_K_,...,_k_ + 7 must be valid indices of _c-bytevector_. For
c-bytevector-ieee-double-native-ref, _k_ must be a multiple of 8.

These procedures return the inexact real number object that best represents the
IEEE-754 double-precision number represented by the eight bytes beginning at
index _k_.

(**c-bytevector-ieee-single-native-set!**)</br>
(**c-bytevector-ieee-single-set!**)

_K_,...,_k_ + 3 must be valid indices of _c-bytevector_. For
c-bytevector-ieee-single-native-set!, _k_ must be a multiple of 4.

These procedures store an IEEE-754 single-precision representation of x into
elements _k_ through _k_ + 3 of bytevector, and return unspecified values.

(**c-bytevector-ieee-double-native-set!**)</br>
(**c-bytevector-ieee-double-set!**)

_K_,...,_k_ + 7 must be valid indices of bytevector. For
c-bytevector-ieee-double-native-set!, _k_ must be a multiple of 8.

These procedures store an IEEE-754 double-precision representation of x into
elements _k_ through _k_ + 7 of bytevector, andreturn unspecified values.


(**string->c-utf8** _string_)

Returns a newly allocated (unless empty) c-bytevector that contains the
UTF-8 encoding of the given string.

(**c-utf8->string** _c-bytevector_)

Returns a newly allocated (unless empty) string whose character sequence is
encoded by the given c-bytevector.

### Utilities

**libc-name**

Name of the C standard library on the current operating system. Supported OS:

- Windows
- Linux
- Haiku

See foreign/c/libc.scm to see which headers are included and what shared
libraries are loaded.

Example:

    (define-c-library libc '("stdlib.h") libc-name '("" "6"))
    (define-c-procedure c-puts libc 'puts 'int '(pointer))
    (c-puts "Message brought to you by foreign-c!")

### Environment variables

Setting environment variables like this on Windows works for this library:

    set "FOREIGN_C_LOAD_PATH=C:\Program Files (x86)/foo/bar"

#### FOREIGN\_C_\_LOAD\_PATH

To add more paths to where foreign c looks for libraries set
FOREIGN\_C\_LOAD\_PATH to paths separated by ; on windows, and : on other
operating systems.

