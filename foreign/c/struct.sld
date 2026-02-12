(define-library
  (foreign c struct)
  (import (scheme base)
          (foreign c))
  (export define-c-struct)
  (include "struct.scm"))
