#!/usr/bin/env bash

source scripts/init-test.sh

SCHEME="csc -X r7rs -R r7rs -L -lcurl"
SCHEME_LIB="csc -X r7rs -R r7rs -sJ"
SCHEME_I="csi -R r7rs"

cp retropikzel/pffi/${VERSION}/main.sld retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.main.scm
cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel/pffi/${VERSION}/retropikzel.pffi.${VERSION}.chicken.scm
cp retropikzel/pffi/${VERSION}/main.sld retropikzel.pffi.${VERSION}.main.scm
cp retropikzel/pffi/${VERSION}/chicken.scm retropikzel.pffi.${VERSION}.chicken.scm
${SCHEME_LIB} retropikzel.pffi.${VERSION}.chicken.scm
${SCHEME_LIB} retropikzel.pffi.${VERSION}.main.scm

source scripts/test-runs-compilers.sh
