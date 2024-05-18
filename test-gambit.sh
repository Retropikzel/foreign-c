#!/usr/bin/env bash

source scripts/init-test.sh

VERSION=v0-1-0


SCHEME="gsc -:r7rs,search=."
SCHEME_I="gsi -:r7rs,search=."


${SCHEME} -obj retropikzel/pffi/${VERSION}/gambit.scm
${SCHEME} -obj retropikzel/pffi/${VERSION}/main.sld
${SCHEME_I} ./test/import.scm
${SCHEME} -o ./tmp/import ./test/import.scm
./tmp/import
