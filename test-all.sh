#!/usr/bin/env bash

set -eu
set -o pipefail

for testfile in ./test-*.sh
do
    if [[ ! "${testfile}" = "./test-all.sh" ]];
    then
        bash "${testfile}"
    fi
done
