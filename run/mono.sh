#!/usr/bin/env sh

set -eu

read -r exe
export MONO_GC_PARAMS=max-heap-size="$5"m
sudo -u invoker ejudge-execute           \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    /usr/bin/mono "$exe" 2>&1 |
    exec sed "s/VMSize: .*/VMSize: $(($5 * 1048576))/"
