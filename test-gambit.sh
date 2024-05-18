#!/usr/bin/env bash

source scripts/init-test.sh

SCHEME="gsc -v -:r7rs,search=. -ld-options -lcurl -exe"
SCHEME_LIB="gsc -v -:r7rs,search=. -obj"
SCHEME_I="gsi -:r7rs,search=."


${SCHEME_LIB} retropikzel/pffi/${VERSION}/gambit.scm
${SCHEME_LIB} retropikzel/pffi/${VERSION}/main.sld


source scripts/test-runs-compilers.sh
