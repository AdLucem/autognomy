#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./aesthetic.sh PATH_TO_JSON_FILE"
else
    echo $1 | stack exec hashtag-aesthetic
fi 
