#!/usr/bin/env sh

set -eu

echo Main
cat > Main.java
exec javac -target 1.8 \
    -g:none -nowarn -cp '.;*' Main.java >&2
