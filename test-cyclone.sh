#!/usr/bin/env bash

source scripts/init-test.sh

SCHEME="cyclone -A ."
SCHEME_LIB="cyclone -A ."
SCHEME_I="icyc -A . -s"

source scripts/test-runs-compilers.sh
