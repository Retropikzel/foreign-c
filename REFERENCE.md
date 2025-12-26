# (foreign c) reference

Table of content

- Types
- Libraries and procedures
- c-bytevectors
- Strings
- Pass pointer by address
- Structs
- Utilities
- Endianness
- Environment variables

## Types

Types are given as symbols, for example 'i8 or 'pointer. Corresponding C type
is after the foreign c name.

- i8
    - int8\_t
- u8
    - uint8\_t
- i16
    - int16\_t
- u16
    - uint16\_t
- i32
    - int32\_t
- u32
    - uint32\_t
- i64
    - int64\_t
- u64
    - uint64\_t
- char
    - char
- uchar
    - unsigned char
- short
    - short
- ushort
    - unsigned short
- int
    - int
- uint
    - unsigned int
- long
    - long
- ulong
    - unsigned long
- float
    - float
- double
    - double
- pointer
    - void\*
- void
    - void
    - Can not be argument type, only return type


(**c-type-size** type)

Returns the size of given type.

(**c-type-align** type)

Returns the align of given type.


## Libraries and procedures

(**define-c-library** scheme-name headers object-name options)

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

### Notes

- Do not cond-expand inside the arguments, that might lead to problems on some
implementations.
- Do not store options in variables, that might lead to problems on some
implementations.
- Pass the headers using quote
    - As '(...) and not (list...)
- Pass the options using quote
    - As '(...) and not (list...)


(**define-c-procedure** scheme-name shared-object c-name return-type argument-type)

Takes a scheme-name to bind the C procedure to, shared-object where the function
is looked from, c-name of the function as symbol, return-type and argument-types.

Defines a new foreign function to be used from Scheme code.


Example:

    (define-c-library libc '("stdlib.h") libc-name '("6"))
    (define-c-procedure c-puts libc 'puts 'int '(pointer))
    (c-puts "Message brought to you by foreign-c!")


### Notes

- Pass the return-types using quote
    - As '(...) and not (list...)


## c-bytevectors

(**make-c-bytevector** size)</br>
(**make-c-bytevector** size fill)

Returns a newly allocated c-bytevector of size bytes.

If the fill argument is missing, the initial contents of the
returned c-bytevector are unspecified.

If the fill argument is present, it's value must confine to C uint8\_t values,
it specifies the initial value for the bytes of the c-bytevector.

(**c-bytevector** byte ...)</br>

Returns a newly allocated c-bytevector containing its arguments.

(**c-bytevector?** obj)

Returns #t if obj is c-bytevector, otherwise returns #f.


(**c-free** cbv)

Frees c-bytevector from memory. Behaviour using the bytevector after it's freed
is unspecified.


(**make-c-null**)

Returns a null C pointer.


(**c-null?** obj)

Returns #t if obj is a null C pointer, otherwise returns #f.


(**c-bytevector-set! cbv type offset value**)

Set value of given type on offset on bytevector bv. Offset is counted as bytes,
no matter the given type.


(**c-bytevector-ref! cbv type offset**)

Get value of given type from offset of bytevector bv. Offset is counted as bytes,


(**bytevector->c-bytevector** bv)

Returns a newly allocated c-bytevector of the bytes of bytevector.


(**c-bytevector->bytevector** cbv)

Returns a newly allocated bytevector of the bytes of c-bytevector.


(**c-bytevector->address** cbv)

Returns the address of the bytevector.


(**address->c-bytevector** adress)

Returns the bytevector in the address.


## Strings

(**string->c-utf8** str)

Returns a newly allocated (unless empty) c-bytevector that contains the
UTF-8 encoding of the given string.


(**c-utf8->string** cbv)

Returns a newly allocated string whose character sequence is
encoded by the given c-bytevector. If c-bytevector is null empty string is
returned.

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


## Structs

(**define-c-struct** name members struct-cbv (field-name field-type accessor modifier) ...)

This procedure is used to create new or access existing c structs that you
have a pointer of.

Name is the variable name that the struct c-bytevector will have. It is just
a c-bytevector like returned form make-c-bytevector.

Members is name for members variable of the struct, it's a needed for internal
purposes and ignored later on.

struct-pointer is the pointer used for the struct, if you already have a
pointer for example returned from C function then pass that. If you do not have
a pointer then pass #f.

(field-name field-type accessor modifier) is similar to how define-record-type
works, except you also need to pass in type.


Example:

(define-c-struct s
                 s-members
                 (make-c-null)
                 (field1 'int struct-field1 struct-field1!)
                 (field2 'int struct-field2 struct-field2!)
                 (field3 'pointer struct-field3 struct-field3!)
                 (field4 'int struct-field4 struct-field4!))

(struct-field1! s 1)
(struct-field2! s 2)
(struct-field3! s (make-c-bytevector 32))
(struct-field4! s 4)

(write s)
(newline)
(write s-members)
(newline)
(write (struct-field1 s))
(newline)
(write (struct-field2 s))
(newline)
(write (struct-field3 s))
(newline)
(write (struct-field4 s))
(newline)


## Utilities

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

## Endianness

(**native-endianness**)

Returns the endianness symbol associated implementation’s preferred endianness
(usually that of the underlying machine architecture).  Currently returns
either 'little or 'big.

## Environment variables

Setting environment variables like this on Windows works for this library:

    set "FOREIGN_C_LOAD_PATH=C:\Program Files (x86)/foo/bar"



### FOREIGN\_C_\_LOAD\_PATH

To add more paths to where foreign c looks for libraries set
FOREIGN\_C\_LOAD\_PATH to paths separated by ; on windows, and : on other
operating systems.

