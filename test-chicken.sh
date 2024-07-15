#!/usr/bin/env bash

source scripts/init-test.sh

CHICKEN_REPOSITORY_PATH=${PWD}/retropikzel/r7rs-pffi/version
SCHEME="csc -X r7rs -R r7rs -L -lcurl"
SCHEME_LIB="csc -X r7rs -R r7rs -s -J"
SCHEME_I="csi -R r7rs"

cp retropikzel/r7rs-pffi/version/chicken.scm retropikzel.r7rs-pffi.version.chicken.scm
cp retropikzel/r7rs-pffi/version/main.scm retropikzel.r7rs-pffi.version.main.scm
${SCHEME_LIB} retropikzel.r7rs-pffi.version.chicken.scm
${SCHEME_LIB} retropikzel.r7rs-pffi.version.main.scm

source scripts/test-runs-compilers.sh
