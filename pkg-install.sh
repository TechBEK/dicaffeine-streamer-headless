#!/bin/bash

[[ $(id -u) == 0 ]] || echo "Must be root to run script - use sudo" && exit 1

echo "Installing dicaffeine repo info"
wget -O - http://dicaffeine.com/repository/dicaffeine.key | sudo apt-key add -
echo "deb https://dicaffeine.com/repository/ buster main non-free" | sudo tee -a /etc/apt/sources.list.d/dicaffeine.list
sudo apt update

echo "Installing yuri2 for headless run. (For license, you'll need to install dicaffine, run it, buy license, install license, then uninstall it or it'll break multi-device things.)"

sudo apt-get -y install yuri2_ndi libcap2-bin

CONFIG=/boot/config.txt

echo "Enabling Raspberry GL output."
sed $CONFIG -i -e "s/^dtoverlay=vc4-kms-v3d/#dtoverlay=vc4-kms-v3d/g"
sed $CONFIG -i -e "s/^#dtoverlay=vc4-fkms-v3d/dtoverlay=vc4-fkms-v3d/g"
if ! sed -n "/\[pi4\]/,/\[/ !p" $CONFIG | grep -q "^dtoverlay=vc4-fkms-v3d" ; then
	printf "[all]\ndtoverlay=vc4-fkms-v3d\n" >> $CONFIG
fi

echo "Disabling Raspberry composition manager."
raspi-config nonint do_xcompmgr 0

 
