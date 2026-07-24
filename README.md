(foreign c) is a C foreign function interface (FFI) library for R6RS and R7RS Schemes


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

## Documentation

Table of contents

- Types
- c-bytevectors
- C libraries
- C procedures
- Callbacks
- Strings
- Pass pointer by address
- C Arrays
- C Structs
- Environment variables



## Types

Types are given as symbols, for example 'i8 or 'pointer. Corresponding C type
is after the foreign c name.

- 'i8
    - int8\_t
- 'u8
    - uint8\_t
- 'i16
    - int16\_t
- 'u16
    - uint16\_t
- 'i32
    - int32\_t
- 'u32
    - uint32\_t
- 'i64
    - int64\_t
- 'u64
    - uint64\_t
- 'char
    - char
- 'uchar
    - unsigned char
- 'short
    - short
- 'ushort
    - unsigned short
- 'int
    - int
- 'uint
    - unsigned int
- 'long
    - long
- 'ulong
    - unsigned long
- 'float
    - float
- 'double
    - double
- 'pointer
    - void\*
- 'array
    - void\*
- 'struct
    - void\*
- 'callback
- 'void
    - void
    - Can not be argument type, only return type


(**c-type-size** type)

Returns the size of given type. If type is array then returns size of the
arrays type.


(**c-type-size+** type ...)

Adds given types together and returns the sum.

(c-type-size\* type n)

Multiples given type n times.


(**c-type-size-** type ...)

Subtracts given types from eachother and returns the result.


(**c-type-align** type)

Returns the align of given type.


(**c-type-align+** type ...)

Adds given types together and returns the sum.


(**c-type-align-** type ...)

Subtracts given types from eachother and returns the result.


## c-bytevectors


(**make-c-bytevector** size)</br>
(**make-c-bytevector** size fill)

Returns a newly allocated c-bytevector of size bytes.

If the fill argument is missing, the initial contents of the
returned c-bytevector are unspecified.

If the fill argument is present, it's value must confine to C uint8\_t values,
it specifies the initial value for the bytes of the c-bytevector.

If allocation fails, error is signaled.


(**c-bytevector** byte ...)</br>

Returns a newly allocated c-bytevector containing its arguments.


(**c-bytevector?** obj)

Returns #t if obj is c-bytevector, otherwise returns #f.


(**c-bytevector-free** cbv ...)

Frees given c-bytevectors from memory. Behaviour using the bytevector after
it's freed is unspecified.


(**c-bytevector-null**)

Returns a null C pointer. On some implementations #f is null pointer, this
behaviour should not be used or counted on.


(**c-bytevector-null?** obj)

Returns #t if obj is a null C pointer, otherwise returns #f. On some
implementations #f is null pointer, this behaviour should not be used or counted on.


(**c-bytevector-set!** cbv type offset/member value)

Set value of given type on offset on bytevector bv. Offset is counted as bytes,
for regular types. When type is c-array-type or c-struct-type.

If type is C array, then offset is multiplied by the size of arrays type.


(**c-bytevector-ref** cbv type offset/member)

Get value of given type from offset of bytevector bv. Offset is counted as bytes,
for regular types. When type is c-array-type or c-struct-type.

If type is C array, then offset is multiplied by the size of arrays type.

If type is C struct, and symbol is passed in offset/member it is taken as
member name and value is returned of members type.

If type is C struct, and number is passed in offset/member it is taken as
offset and pointer is returned pointing to the offset.


(**bytevector->c-bytevector** bv)

Returns a newly allocated c-bytevector of the bytes of bytevector.


(**c-bytevector->bytevector** cbv)

Returns a newly allocated bytevector of the bytes of c-bytevector.


(**c-bytevector->integer** cbv [offset])

Returns the address of the bytevector as integer. If offset is given it is
added to the the returned integer. Offset must be an integer.


(**integer->c-bytevector** adress)

Returns the bytevector in the integer address.



## C Libraries


(**define-c-library** scheme-name headers object-name options)

Takes a scheme-name to bind the library to, list of C headers as
strings, shared-object name or #f and options. If shared-object name
is given as #f then platforms C library is used.

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

Examples:

    (define-c-library libc (list "stdio.h") #f '())

    (define-c-library libcurl
                      (list "curl/curl.h")
                      "curl"
                      '((additional-versions ("" "0" "6"))
                        (additional-paths ("."))))

#### Notes

- Do not cond-expand inside the arguments, that might lead to problems on some
implementations.
- Do not store options in variables, that might lead to problems on some
implementations.
- Pass the headers using quote
    - As '(...) and not (list ...)
- Pass the options using quote
    - As '(...) and not (list ...)



## C Procedures


(**define-c-procedure** scheme-name shared-object c-name return-type argument-types)

Takes a scheme-name to bind the C procedure to, shared-object where the function
is looked from, c-name of the function as symbol, return-type and argument-types.

Defines a new foreign function to be used from Scheme code.


Example:

    (define-c-library libc '("stdlib.h") #f '())
    (define-c-procedure c-puts libc 'puts 'int '(pointer))
    (c-puts "Message brought to you by foreign-c!")


#### Notes

- Pass the argument-types using quote
    - As '(...) and not (list ...)


## Callbacks


(**define-c-callback** scheme-name return-type argument-types procedure)

Takes scheme-name to bind the Scheme procedure to, return-type, argument-types and procedure as in place lambda.

Defines a new Sceme function to be used as callback to C code.

For example see tests/callback.scm


## Strings


(**string->c-bytevector** str)

Returns a newly allocated (unless empty) c-bytevector that contains the
UTF-8 encoding of the given string.


(**with-string->c-bytevector** str thunk)

Calls thunk with newly allocated c-bytevector that contains the UTF-8 encoding
of the given string and frees it after thunk finishes.


(**c-bytevector->string** cbv)

Returns a newly allocated string whose character sequence is
encoded by the given c-bytevector. If c-bytevector is null empty string is
returned.


**null-byte**

Null byte (\0) you can use in strings.



## Pass pointer by address


(**call-with-address-of** cbv thunk)

Calls thunk with address c-bytevector of c-bytevector.

Since the support for calling C functions taking pointer address arguments,
ones prefixed with & in C, varies, some additional ceremony is needed on
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



## C Arrays


(**define-c-array-type** name type)

Creates a new C array type that can be used when accessing c-bytevectors.
*name* is the name of the type and *type* is the type of arrays items.


Example:

    (define-c-array-type i8-array 'i8)
    (define ar1 (make-c-bytevector (* (c-type-size i8-array) 10)))
    (c-bytevector-set! ar1 i8-array 5 25) ; Set the 5th item of array to 25
    (write (c-bytevector-ref ar1 i8-array 5))
    > 25



## C Structs


(**define-c-struct-type** name members)

Creates a new C struct type that can be used when accessing c-bytevectors.
*name* is the name of the type and *members* is a list of member names and types.

Example:

    (define-c-struct-type color '((r i8) (g i8) (b i8) (a i8)))

    (define green (make-c-bytevector (c-type-size color)))
    (c-bytevector-set! green color 'r 1)
    (c-bytevector-set! green color 'g 2)
    (c-bytevector-set! green color 'b 3)
    (c-bytevector-set! green color 'a 4)

    (display (c-bytevector-ref green color 'g))
    > 2

#### Notes
- Do not cond-expand inside the arguments, that might lead to problems on some
implementations.
- Do not store member names or types in variables, that might lead to problems
on some implementations.
- Pass the members using quote
    - As '(...) and not (list ...)



(**c-struct->alist** cbv type)

cbv must be c-bytevector holding the C struct data. type must be C struct type
previously defined by define-c-struct-type. Returns an association list
containing as cars the member names and values as cdrs.


## Environment variables

Setting environment variables like this on Windows works for this library:

    set "FOREIGN_C_LOAD_PATH=C:\Program Files (x86)/foo/bar"



### FOREIGN\_C_\_LOAD\_PATH

To add more paths to where foreign c looks for libraries set
FOREIGN\_C\_LOAD\_PATH to paths separated by ; on windows, and : on other
operating systems.




