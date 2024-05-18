#!/usr/bin/env bash
source scripts/init-test.sh

SCHEME="racket -I r7rs --make -S . --script"

source scripts/test-runs-dynamic.sh
