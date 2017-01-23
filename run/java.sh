#!/usr/bin/env sh

set -eu

read -r class
sudo -u invoker ejudge-execute           \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    /usr/bin/java -DONLINE_JUDGE=true -Xmx"$5"M "$class" 2>&1 |
    exec sed "s/VMSize: .*/VMSize: $(($5 * 1048576))/"
