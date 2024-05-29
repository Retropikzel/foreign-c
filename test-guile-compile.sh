#!/usr/bin/env bash
source scripts/init-test.sh

SCHEME="guile --fresh-auto-compile --r7rs -L ."

source scripts/test-runs-dynamic.sh
