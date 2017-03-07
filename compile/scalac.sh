#!/usr/bin/env sh

set -eu

echo Main
cat > Main.scala
exec scalac -target:jvm-1.8 \
    -optimize -g:none -nowarn Main.scala >&2
