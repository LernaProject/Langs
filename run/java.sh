#!/usr/bin/env sh

set -eu

sudo -u invoker ejudge-execute           \
    --stdin="$2"                         \
    --stdout="$3"                        \
    --stderr="$4"                        \
    --time-limit-millis="$5"             \
    --real-time-limit=$(($5 * 5 / 1000)) \
    /usr/bin/java -DONLINE_JUDGE=true -Xmx"$6"M "$1" | sed "s/VMSize: .*/VMSize: $(($6 * 1048576))/"
