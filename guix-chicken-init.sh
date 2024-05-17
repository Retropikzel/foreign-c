#!/usr/bin/env bash

export CHICKEN_INSTALL_REPOSITORY=${HOME}/eggs/lib/chicken/5
export CHICKEN_REPOSITORY_PATH=${CHICKEN_REPOSITORY_PATH}:${HOME}/eggs/lib/chicken/5

chicken-install -init ${HOME}/eggs/lib/chicken/5
chicken-install r7rs
