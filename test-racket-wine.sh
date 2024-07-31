#!/usr/bin/env bash
source scripts/init-test.sh

export WINEPATH=$(winepath ${HOME}/.wine/drive_c/Program\ Files/Racket)
SCHEME="wine64 racket.exe -I r7rs --make -S . --script"

source scripts/test-runs-dynamic.sh
