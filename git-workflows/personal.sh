#!/bin/bash

# set up git credentials on personal PC
git config --global credential.helper store

git add .
git commit -m "random commit to store credentials"
git push -u origin master
