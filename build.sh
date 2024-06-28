#!/usr/bin/env sh

[[ -d "build" ]] && rm -rf build    || exit 1
clear;cmake -GNinja -Bbuild -H. &&  \
            cd build                || exit 1

clear;cmake --build .               || exit 1