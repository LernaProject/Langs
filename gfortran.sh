#!/usr/bin/env sh

set -eu

echo main
cat > main.f90
exec gfortran \
    -DONLINE_JUDGE -O2 -o main main.f90 1>&2
