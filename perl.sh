#!/usr/bin/env sh

set -eu

echo main.pl
tee main.pl | exec sudo -u invoker ejudge-execute \
    --time-limit-millis=250 \
    --real-time-limit=1     \
    --memory-limit          \
    --max-vm-size=64M       \
    --max-stack-size=64M    \
    --secure-exec           \
    --security-violation    \
    /usr/bin/perl -c - 1>&2
