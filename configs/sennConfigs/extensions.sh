#!/bin/bash

echo "Installing extensions..."

# caffeine
cd ~
git clone git://github.com/eonpatapon/gnome-shell-extension-caffeine.git
cd gnome-shell-extension-caffeine
./update-locale.sh
glib-compile-schemas --strict --targetdir=caffeine@patapon.info/schemas/ caffeine@patapon.info/schemas
cp -r caffeine@patapon.info ~/.local/share/gnome-shell/extensions

# coverflow alt-tab
cd ~
git clone https://github.com/dmo60/CoverflowAltTab.git
cd CoverflowAltTab
make all

# dash to dock
cd ~
git clone https://github.com/micheleg/dash-to-dock.git
make
make install

# freon
cd ~
sudo apt install lm-sensors
git clone https://github.com/UshakovVasilii/gnome-shell-extension-freon.git
cd gnome-shell-extension-freon
glib-compile-schemas freon@UshakovVasilii_Github.yahoo.com/schemas/
mkdir -p ~/.local/share/gnome-shell/extensions
cp -r freon@UshakovVasilii_Github.yahoo.com ~/.local/share/gnome-shell/extensions/.
sudo sensors-detect

