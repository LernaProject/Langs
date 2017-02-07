#!/usr/bin/env sh

set -eu

echo main
tee main.rs | exec rustc \
    --cfg online_judge -O -o main - >&2
