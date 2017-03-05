#!/usr/bin/env sh

set -eu

echo main
tee main.swift | exec /trusted/swift/bin/swiftc \
    -DONLINE_JUDGE -Ounchecked -gnone -j1 -o main - >&2
