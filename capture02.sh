#! /bin/bash


## Usage:   # This script might fail due to insufficient permission to write file.
# cat somefile | ./script.sh -n 3
# cat somefile | ./script.sh -n x  # testing stderr


echo `printf "%q " "$0" "$@"` > /tmp/data.args
env > /tmp/data.env

# error can be found at /tmp/data.err if the real command fails
tee /tmp/data.in | `printf "%q " "/usr/bin/head" "$@"` 2>/tmp/data.err  | tee /tmp/data.out

