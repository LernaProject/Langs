#!/usr/bin/env sh

set -eu

echo main.exe
cat > main.cs
exec mcs \
    -d:ONLINE_JUDGE -debug- -o+ -unsafe+ main.cs >&2
