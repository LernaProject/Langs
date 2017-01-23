#!/usr/bin/env sh

set -eu

echo main
cat > main.d
exec ldmd2 \
    -version=OnlineJudge -release -boundscheck=off -O -inline main 1>&2
