#!/bin/bash

sudo useradd -m $1
passwd $1
su $1  