#!/usr/bin/env bash
source scripts/init-test.sh

SCHEME="wine sash.exe -c -r7 -L ."

source scripts/test-runs-dynamic.sh
