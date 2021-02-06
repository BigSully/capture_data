#! /bin/bash


## Usage: (suppose that this bash script is named script.sh )
## capture the stdin and save
# ./script.sh -a 1 -b 2 < somefile
## capture the stdin/stdout of another command, useful for debugging
# REAL_CMD=/usr/bin/head ./script.sh -n 3  < somefile

output_stdin=/tmp/cmd_stdin
output_stdout=/tmp/cmd_stdout
output=/tmp/cmd_args_env.txt


dd of=$output_stdin


# capture command name and args
for ((i=0; i<=$#; i++))
do
  printf "${!i}\n   " >> $output
done
printf "\n\n" >> $output


# capture the working directory
pwd >> $output
printf "\n\n" >> $output

# capture env
env >> $output
printf "\n\n" >> $output


# invoke the command specified by environment variables REAL_CMD with received arguments and stdin
# The quotes in "$@" is essential when there is space in any argument!!
if [ -n "$REAL_CMD" ]; then
  $REAL_CMD "$@" < $output_stdin | tee  $output_stdout
fi