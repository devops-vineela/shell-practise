#!/bin/bash
echo "variables passed to the script: $@"
echo "no.of variables passed to the script:$#"
echo "script name: $0"
echo "home directory of the user who is running this script: $HOME"
echo "user name who is running this script: $USER"
echo "PID of this current script: $$"
echo "present working directory: $PWD"
echo " previous command response is $?"
sleep 10 &
echo "PID of last command running in background: $!"