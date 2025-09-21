(import (scheme base)
        (scheme write)
        (foreign c)
        (srfi 64))

(test-begin "Foreign-c")

(test-assert (number? (c-type-size 'int8)))
(test-assert(= (c-type-size 'int8) 1))

(test-end "Foreign-c")
