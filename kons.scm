(package
  (name (foreign c))
;  (owner "retropikzel")
  (version "0.16.3")
  (license "LGPL-3.0-or-later")
  (description "Portable C foreign function interface for R7RS Scheme")
  (keywords scheme r7rs ffi c foreign-interface)
  (authors "Retropikzel")
  (site "https://codeberg.org/foreign-c/foreign-c")
  (repo "https://codeberg.org/foreign-c/foreign-c")
  (docs "REFERENCE.md")
  (readme "README.md")
  (dialects r7rs)
  (source-path ".")
  (discover-libraries #f)
  (libraries
    ((r7rs (foreign c))))
  (main #f))

(dependencies)

(dev-dependencies)

(overrides)
