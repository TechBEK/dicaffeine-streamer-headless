#!/bin/bash

# This is horrible bash scripting that does not do things for you automatically.  One day 
# I may make this with more error checking, but today is not that day.

AUDIO=$1
VIDEO=$2
DESC=$3
FILE=$4

# Stolen from: https://stackoverflow.com/questions/2427995/bash-no-arguments-warning-and-case-decisions
# And then slightly modified. Thanks!

if [[ $# -ne 4 ]] ; then 
 echo "Usage: $0 AUDIO VIDEO NDI-Desc output-filename"
 echo
 echo "Example: $0 plughw:CARD=MS2109,DEV=0 /dev/video0 \"random description here\" stream1 "
 echo "Don't use # in the description."
 exit 1;
fi

sed -e "s#_CHANGEME_AUDIO_#$1#g" -e "s#_CHANGEME_VIDEO_#$2#g" -e "s#_CHANGEME_NAME_#$3#g" capture-usb.xml.template > $4.xml
sed -e "s#_CHANGME_FILE_#$4.xml#g" -e "s#_CHANGEME_NAME_#$3#g" yuri2.service.template > $4.service 

echo "Written to $4.xml and $4.service (systemd)"
 

