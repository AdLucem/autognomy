#!/bin/bash

echo "Installing extensions..."

# caffeine
cd ~
git clone http://github.com/eonpatapon/gnome-shell-extension-caffeine.git
cd gnome-shell-extension-caffeine
./update-locale.sh
glib-compile-schemas --strict --targetdir=caffeine@patapon.info/schemas/ caffeine@patapon.info/schemas
cp -r caffeine@patapon.info ~/.local/share/gnome-shell/extensions/
cd ~/.local/share/gnome-shell/extensions/caffeine@patapon.info

# coverflow alt-tab
cd ~
git clone https://github.com/dmo60/CoverflowAltTab.git
cd CoverflowAltTab
cp -r CoverflowAltTab@dmo60.de ~/.local/share/gnome-shell/extensions/
cd ~/.local/share/gnome-shell/extensions/CoverflowAltTab@dmo60.de

# dash to dock
cd ~
git clone https://github.com/micheleg/dash-to-dock.git
cd dash-to-dock
make
make install

# freon
cd ~
sudo apt install lm-sensors
git clone https://github.com/UshakovVasilii/gnome-shell-extension-freon.git
cd gnome-shell-extension-freon
glib-compile-schemas freon@UshakovVasilii_Github.yahoo.com/schemas/
cp -r freon@UshakovVasilii_Github.yahoo.com ~/.local/share/gnome-shell/extensions/
sudo sensors-detect

# hide top bar
sudo apt install gnome-shell-extension-autohidetopbar


