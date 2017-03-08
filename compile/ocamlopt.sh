#!/usr/bin/env sh

set -eu

echo main
cat > main.ml
exec ocamlopt \
    -noassert -unsafe -w a nums.cmxa str.cmxa main.ml -o main >&2
