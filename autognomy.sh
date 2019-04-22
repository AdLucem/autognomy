#!/bin/bash


if [ "$#" -ne 1 ]; then
    echo "Usage: ./autognomy.sh PATH_TO_JSON_FILE"
else
    echo $1 | stack exec autognomy-exe
fi 
