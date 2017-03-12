#!/usr/bin/env sh

set -eu

echo main
cat > main.pas
exec fpc \
    -dONLINE_JUDGE -XS -O3 -omain main.pas >&2
