#!/bin/bash
set -e
failure(){
    echo "Error occurred at line $1 while executing: $2"
}
trap 'failure "${LINE_NO}" "${BASH_COMMAND}"' ERR
movies=(court bahubali pushpa)
echoooo "${moviessss[0]}"
echo "all movies are: ${movies[@]}"