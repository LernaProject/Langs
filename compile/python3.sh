#!/usr/bin/env sh

set -eu

echo main.py
cat > main.py
exec /opt/py3venv/bin/python3 \
    -mpy_compile main.py 1>&2
