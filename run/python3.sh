#!/usr/bin/env sh

set -eu

read -r file
exec sudo -u invoker ejudge-execute      \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    --memory-limit                       \
    --max-vm-size="$5"M                  \
    --max-stack-size="$5"M               \
    /trusted/py3/bin/python3 "$file" 2>&1
