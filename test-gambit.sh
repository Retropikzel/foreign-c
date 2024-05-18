#!/usr/bin/env bash
set -eu

make clean
make tmp

VERSION=v0-1-0


GAMBIT="gsc -:r7rs,search=."
GAMBIT_I="gsi -:r7rs,search=."


${GAMBIT} -obj retropikzel/pffi/${VERSION}/gambit.scm
${GAMBIT} -obj retropikzel/pffi/${VERSION}/main.sld
${GAMBIT_I} ./test/import.scm
${GAMBIT} -o ./tmp/import ./test/import.scm
./tmp/import
