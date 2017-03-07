#!/usr/bin/env sh

set -eu

echo main
cat > main.ml
exec ocamlopt \
    -noassert -unsafe -w a main.ml -o main >&2
