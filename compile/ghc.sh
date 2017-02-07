#!/usr/bin/env sh

set -eu

echo main
cat > main.hs
exec ghc \
    -cpp -DONLINE_JUDGE=1 -O2 -H128m main >&2
