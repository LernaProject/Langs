# Lerna.Langs

Compilation and run scripts for various programming languages.


## Synopsis

```sh
output=output.txt
error=error.txt
log=log.txt
tl=1000
ml=256

data="`cat attempt.src | compile/g++14.sh 2> "$log"`"
for input in ./*.in; do
    echo "$data" | run/native.sh "$input" "$output" "$error" "$tl" "$ml" > "$log"
    cmp "$output" "${input%.*}.out"
done
```


## Compiler invocation

    compile/*.sh [...]

A compilation script reads source code from `stdin` and produces file(s) for an appropriate runner.
Thus, it is ideal for piping into them, though scripts are recommended to save input to a file, for
debugging purposes, even if they can compile from a pipe.

A script can accept any number of command line arguments. Compilation errors and warnings should go
to `stderr`. A script can send any textual or binary data to `stdout`: it will be collected and
passed to a runner each time it is invoked. Message format is intentionally unspecified, which
allows having different protocols for different compilers and runners.

If a script exits with a non-zero code, the compilation is supposed to fail. In that case, data (if
any) is ignored.


## Runner invocation

    run/*.sh <input-file> <output-file> <error-file> <time-limit> <memory-limit>

A runner script reads compiler's message from `stdin` and should properly `ejudge-execute` the
program, redirecting its `stdin`, `stdout`, and `stderr` to `input-file`, `output-file`, and
`error-file`, respectively. Execution time must not exceed `time-limit` milliseconds, and memory
consumption must not exceed `memory-limit` megabytes. `ejudge-execute` outcome should go to
`stdout`. A script should not put anything to its `stderr`.

Sucessfulness of an invocation is determined entirely on the `ejudge-execute` protocol. Return code
is not taken into account.

A runner cannot be started until a compiler is finished. Thus, it is **illegal** to pipe them.
However, that doesn't seem like a much limitation, because normally a compiled program is invoked
multiple times.
