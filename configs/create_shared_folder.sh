#!/bin/bash

# create shared folder
sudo mkdir -p /home/shared
sudo setfacl -m default:other:rwX -R /home/shared
sudo setfacl -m other:rwX -R /home/shared

# create shared steam folder
sudo mkdir -p /home/shared/steam
sudo setfacl -m default:other:rwX -R /home/shared/steam
sudo setfacl -m other:rwX -R /home/shared/steam

