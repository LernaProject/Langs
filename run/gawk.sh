#!/usr/bin/env sh

set -eu

read -r file
exec sudo -u invoker ejudge-execute      \
    --secure-exec --security-violation   \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    --memory-limit                       \
    --max-vm-size="$5"M                  \
    --max-stack-size="$5"M               \
    /usr/bin/gawk -vONLINE_JUDGE=1 -OE "$file" 2>&1
