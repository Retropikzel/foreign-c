(define-library
  (test-util)
  (import (scheme base)
          (scheme write)
          (scheme process-context))
  (export print-header debug assert)
  (include "test-util.scm"))
