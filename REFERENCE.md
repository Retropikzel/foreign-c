# (foreign c) reference

Table of content

- Types
- c-bytevectors
- C libraries
- C procedures
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
- 'void
    - void
    - Can not be argument type, only return type

(**c-type-size** type)

Returns the size of given type. If type is array then returns size of the
arrays type.

(**c-type-align** type)

Returns the align of given type.

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


### C Procedures

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

### c-bytevectors

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


(**c-free** cbv)

Frees c-bytevector from memory. Behaviour using the bytevector after it's freed
is unspecified.


(**c-bytevector-null**)

Returns a null C pointer. On some implementations #f is null pointer, this
behaviour should not be used or counted on.


(**c-bytevector-null?** obj)

Returns #t if obj is a null C pointer, otherwise returns #f. On some
implementations #f is null pointer, this behaviour should not be used or counted on.


(**c-bytevector-set!** cbv type offset/member value)

Set value of given type on offset on bytevector bv. Offset is counted as bytes,
no matter the given type except when type is array or struct. If type is array,
then offset is 


(**c-bytevector-ref!** cbv type offset/member)

Get value of given type from offset of bytevector bv. Offset is counted as bytes,


(**bytevector->c-bytevector** bv)

Returns a newly allocated c-bytevector of the bytes of bytevector.


(**c-bytevector->bytevector** cbv)

Returns a newly allocated bytevector of the bytes of c-bytevector.


(**c-bytevector->integer** cbv [offset])

Returns the address of the bytevector as integer. If offset is given it is
added to the the returned integer. Offset must be an integer.


(**integer->c-bytevector** adress)

Returns the bytevector in the integer address.


### Strings

(**string->c-bytevector** str)

Returns a newly allocated (unless empty) c-bytevector that contains the
UTF-8 encoding of the given string.


(**c-bytevector->string** cbv)

Returns a newly allocated string whose character sequence is
encoded by the given c-bytevector. If c-bytevector is null empty string is
returned.

### Pass pointer by address

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

### Environment variables

Setting environment variables like this on Windows works for this library:

    set "FOREIGN_C_LOAD_PATH=C:\Program Files (x86)/foo/bar"



#### FOREIGN\_C_\_LOAD\_PATH

To add more paths to where foreign c looks for libraries set
FOREIGN\_C\_LOAD\_PATH to paths separated by ; on windows, and : on other
operating systems.


