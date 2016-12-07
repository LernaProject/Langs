#!/usr/bin/env sh

# This script is for testing purpose only!

set -eu

# Mimic ejudge-execute protocol, but do not measure anything and do not restrict permissions.
cat <<EOF
task_Start: execv(1): `realpath "$1"` 0<$2 1>$3 2>$4
Status: OK
CPUTime: 0
RealTime: 0
VMSize: 0
EOF
exec "`realpath "$1"`" < "$2" > "$3" 2> "$4"
