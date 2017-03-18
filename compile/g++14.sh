#!/usr/bin/env sh

set -eu

echo main
tee main.cpp | exec g++ -std=c++14 \
    -DONLINE_JUDGE -w -fno-asm -lm -s -O2 -march=native -mfpmath=sse -pipe -xc++ -o main - >&2
