#!/bin/bash

if_exists () {
        exists=`which $1`
        if [ -z "$exists" ]
        then
                echo "$1 installing..."
                sudo apt install $1
        else
                echo "$1 already installed"
        fi
}

# wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | sudo apt-key add -
# echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
# sudo apt update
if_exists sublime-text
if_exists virtualenv
if_exists chrome-gnome-shell
if_exists nodejs
