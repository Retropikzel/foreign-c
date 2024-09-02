#!/usr/bin/env bash

source scripts/init-test.sh

SCHEME="gsc -v -:r7rs,search=. -ld-options -lcurl -exe"
SCHEME_LIB="gsc -v -:r7rs,search=. -obj"
SCHEME_I="gsi -:r7rs,search=."


${SCHEME_LIB} retropikzel/pffi/version/gambit.scm
${SCHEME_LIB} retropikzel/pffi/version/main.sld


source scripts/test-runs-compilers.sh
