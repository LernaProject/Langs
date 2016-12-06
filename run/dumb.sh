#!/usr/bin/env sh

# This script is for testing purpose only!

set -eu

# Mimic ejudge-execute protocol, but do not measure anything and do not restrict permissions.
echo "task_Start: execv(1): ./$1 < $2 > $3 2> $4"
echo Status: OK
echo CPUTime: 0
echo RealTime: 0
echo VMSize: 0
# Any shell expression is allowed in place of $1.
exec ./$1 < "$2" > "$3" 2> "$4"
