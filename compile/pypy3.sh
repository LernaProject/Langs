#!/usr/bin/env sh

set -eu

echo main.py
cat > main.py
exec /trusted/pypy3/bin/pypy3 -mpy_compile \
    main.py >&2
