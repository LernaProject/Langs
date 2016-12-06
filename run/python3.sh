#!/usr/bin/env sh

set -eu

exec sudo -u invoker ejudge-execute      \
    --stdin="$2"                         \
    --stdout="$3"                        \
    --stderr="$4"                        \
    --time-limit-millis="$5"             \
    --real-time-limit=$(($5 * 5 / 1000)) \
    --memory-limit                       \
    --max-vm-size="$6"M                  \
    --max-stack-size="$6"M               \
    /opt/py3venv/bin/python3 "$1"
