#!/usr/bin/env bash

for testfile in ./test-*.sh
do
    if [[ ! "${testfile}" = "./test-all.sh" ]];
    then
        bash "${testfile}"
    fi
done
