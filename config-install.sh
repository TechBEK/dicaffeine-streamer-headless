#!/bin/bash

# Crappy installer for this.  Use at your own risk

NAME=$1

if [[ $# -ne 1 ]] ; then 
 echo "Usage: $0 name"
 echo
 echo "Example: $0 name"
 echo "Name is name argument that you used in your config generation."
 exit 1;
fi

echo "This requires sudo to copy a systemd file so this starts on startup when you turn device on."

sudo apt-get -y remove dicaffeine
mkdir -p /home/pi/yuri
cp ${NAME}.xml /home/pi/yuri
sudo cp ${NAME}.service /lib/systemd/system
sudo systemctl enable ${NAME}.service

 
