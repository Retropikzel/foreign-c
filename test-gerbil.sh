#!/usr/bin/env bash

source scripts/init-test.sh

SCHEME="gxc -prelude :scheme/r7rs -exe"
SCHEME_LIB="gxc -prelude :scheme/r7rs"
SCHEME_I="gxi --lang r7rs"

source scripts/test-runs-compilers.sh
