#!/usr/bin/env bash

set -eu
set -o pipefail

VERSION=$(cat VERSION)

for testfile in ./test-*.sh
do
    if [[ ! "${testfile}" = "./test-all.sh" ]];
    then
        bash "${testfile}"
    fi
done
