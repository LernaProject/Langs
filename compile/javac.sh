#!/usr/bin/env sh

set -eu

echo Main
cat > Main.java
exec javac \
    -cp '.;*' Main.java >&2
