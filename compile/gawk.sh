#!/usr/bin/env sh

set -eu

echo main.awk
tee main.awk | exec gawk \
    -e'BEGIN { exit 0 } END { exit 0 }' -f- >&2
