#!/usr/bin/env sh

set -eu

read -r jar
sudo -u invoker ejudge-execute           \
    --stdin="$1"                         \
    --stdout="$2"                        \
    --stderr="$3"                        \
    --time-limit-millis="$4"             \
    --real-time-limit=$(($4 * 5 / 1000)) \
    /usr/bin/java               \
        -DONLINE_JUDGE          \
        -Djava.security.manager \
        -Djava.security.policy=/trusted/java/jre/lib/security/lerna.policy \
        -Xmx"$5"M -Xss"$5"M     \
        -jar "$jar" 2>&1 |
    exec sed "s/VMSize: .*/VMSize: $(($5 * 1048576))/"
