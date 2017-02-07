#!/usr/bin/env sh

set -eu

echo main.exe # Don't be fooled, it's still an ELF.
cat > main.py
exec /trusted/py3/bin/nuitka \
    --recurse-all --lto --remove-output -j1 main.py >&2
