#!/usr/bin/env sh

set -eu

echo main.jar
cat > Main.kt
exec /trusted/kotlin/bin/kotlinc -jvm-target 1.8 \
    -nowarn -include-runtime -d main.jar Main.kt >&2
