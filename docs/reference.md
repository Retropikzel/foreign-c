# Reference

# Types

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
- string
- pointer

# Procedures or macros

On some implementations these are procedures, on some macros.

The arguments are in form

- NAME - TYPE

The return value is in form

- TYPE


## pffi-shared-object-auto-load

Arguments:

- headers - (list string ...)
    - C headers of the library
    - For example (list "curl/curl.h")
- object-name - symbol
    - The name of the dynamic library file you want to load
    - Without the "lib" in front of it
    - Without the ".so" or ".dll" at the end
- additional-versions - (list string...)
    - For example (list ".0" ".1")
- additional-paths - (list string...)
    - Any additional paths you want to search for the library
    - For example (list "./mylibs")

Returns:

- object
      - Shared object, the type depends on the implementation

## pffi-shared-object-load

It is recommended to use the pffi-shared-object-auto-load instead of this
directly.

Arguments:

- headers - (list string ...)
      - Headers that need to be included
      - Example (list "curl/curl.h")
- path - string
      - The full path to the shared object you want to load, including any "lib" infront and .so/.dll at the end
      - Example "libcurl.so"

Returns:

- object
      - Shared object, the type depends on the implementation



## pffi-define

Defines new foreign procedure.

Arguments:

- scheme-name - symbol
      - The name of the procedure used on scheme side
- shared-object - object
      - The shared object
      - Use pffi-shared-object-auto-load or pffi-shared-object-load to get this
- c-name - symbol
      - The name of the C function
- return-type - symbol
      - The return type of the C function
- arguments-types - (list symbol ...)
      - The C function argument types
      - Need to be given in form (list 'type 'type)

## pffi-define-callback

Defines new callback function.

Arguments:

- scheme-name
      - The name of the function used on scheme side
- return-type - symbol
      - The return type of the callback
- arguments-types - (list symbol ...)
      - The callback function argument types
-  procedure - procedure
      - Procedure used as callback function
      - Argument count must match the argument-types count

## pffi-size-of

Get the size of type.

Arguments:

- type - symbol
      - The type you want the size of

Returns:

- number
      - The size of the given type


## pffi-pointer-allocate

Allocates a pointer of given size.

Arguments:

- size - number
      - The size of the pointer you want to allocate

Returns:

- object
      - A pointer of given size


## pffi-pointer-null

Create a null pointer.

Returns:
- object
      - Null pointer

## pffi-string->pointer

Arguments:

- string-content - string
      - The string you want to transform into pointer

Returns:

- object
      - Pointer of the given string


## pffi-pointer->string

Arguments:

- pointer - object
      - The pointer you want to transform to string

Returns:

- string
      - String from the given pointer

## pffi-pointer-free

Arguments:

- pointer - object
      - The pointer you want to free

## pffi-pointer?

Arguments:

- object - object
      - The object you want to check wether it is a pointer or not

Returns:

- boolean
      - Returns true if given object is pointer, otherwise false


## pffi-pointer-set!

Arguments:

- pointer - object
      - The pointer you want to modify
- type - symbol
      - The type of value that will be put into the pointer
- offset -number
      - The location of the value inside the pointer
      - For example: (+ (pffi-size-of 'int) (pffi-size-of 'pointer)) or 0
- value - object
    - The value to be placed into the object

## pffi-pointer-get

Arguments:

- pointer - object
    - The pointer you want to get the value from
- type - symbol
    - The type of value you want to get
    - For example: 'int
- offset - number
    - The location of the value inside the pointer
    - For example: (+ (pffi-size-of 'int) (pffi-size-of 'pointer)) or 0

Returns:

- object
    - The value in the poiner in the given offset as given type

## pffi-pointer-deref

Arguments:

- pointer
    - The pointer to dereference

Returns:

- object
    - Whatever the pointer holds
