#!/usr/bin/env sh

set -eu

echo main.jar
cat > Main.scala
scalac -target:jvm-1.8 \
    -optimize -g:none -nowarn Main.scala >&2
# Bundling a jarfile and executing it with `java -jar` gives better startup time.
cat <<'EOF' > Manifest.mf
Main-Class: Main
Class-Path: /usr/share/java/scala-library.jar
EOF
exec jar cfm main.jar Manifest.mf . >&2
