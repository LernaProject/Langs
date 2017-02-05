#!/usr/bin/env sh

set -eu

read -r file
export PYPY_GC_MAX="$5"MB
sudo -u invoker ejudge-execute           \
    --secure-exec --security-violation   \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    /trusted/pypy3/bin/pypy3 "$file" 2>&1 |
    exec sed "s/VMSize: .*/VMSize: $(($5 * 1048576))/"
