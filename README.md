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

binary="`cat source.txt | ./g++14.sh 2> "$log"`"
for input in ./*.in; do
    run/native.sh "$binary" "$input" "$output" "$error" "$tl" "$ml" > "$log" 2>&1
    cmp "$output" "${input%.*}.out"
done
```
