#!/usr/bin/env sh

set -eu

echo main
cat > main.d
exec ldmd2 \
    -version=OnlineJudge -release -boundscheck=off -O -inline -mcpu=native main -ofmain >&2
