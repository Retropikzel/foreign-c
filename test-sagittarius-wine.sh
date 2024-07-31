#!/usr/bin/env bash
source scripts/init-test.sh

export WINEPATH=$(winepath ${HOME}/.wine/drive_c/Program\ Files/Sagittarius)
SCHEME="wine64 sash.exe -c -r7 -L ."

source scripts/test-runs-dynamic.sh
