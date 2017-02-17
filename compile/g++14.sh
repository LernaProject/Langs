#!/usr/bin/env sh

set -eu

echo main
tee main.cpp | exec g++ -std=c++14 \
    -DONLINE_JUDGE -w -fno-asm -ffloat-store -lm -s -O2 -xc++ -o main - >&2
