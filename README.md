# Lerna.Langs

Compilation and run scripts for various programming languages.

This repository is a part of [Lerna](https://github.com/SoVictor/Lerna) project.


## Synopsis

```sh
output=output.txt
error=error.txt
log=log.txt
tl=1000
ml=256

data="`cat attempt.src | ./g++14.sh 2> "$log"`"
for input in ./*.in; do
    echo "$data" | run/native.sh "$input" "$output" "$error" "$tl" "$ml" > "$log"
    cmp "$output" "${input%.*}.out"
done
```
