#!/usr/bin/env sh

set -eu

echo main.py
cat > main.py
exec /trusted/py3/bin/python3 -mpy_compile \
    main.py >&2
