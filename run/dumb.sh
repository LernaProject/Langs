#!/usr/bin/env sh

# This script is for testing purpose only!

set -eu

read -r binary
# Mimic ejudge-execute protocol, but do not measure anything and do not restrict permissions.
cat <<EOF
task_Start: execv(1): `realpath "$binary"` 0<$1 1>$2 2>$3
Status: OK
CPUTime: 0
RealTime: 0
VMSize: 0
EOF
exec "`realpath "$binary"`" < "$1" > "$2" 2> "$3"
