#!/bin/sh
Dir=$HOME/phone_mount/

# Make the cell directory if it doesn't exist
if [ ! -d "$Dir" ]; then
  mkdir "$Dir"
fi

# Select device
Devices=$(simple-mtpfs -l)

if [ ! -n "$Devices" ]; then
	notify-send "No devices found"
	exit
else
  Device=$(rofi -sep "\n" -dmenu -i -p "Select device:" <<< "$Devices" || notify-send "No device selected")
  Id=${Device%%:*}
  Name=${Device##*: }
	if [ ! -d "$Dir$Name" ]; then
		mkdir "$Dir$Name"
	fi
fi

if [ ! -n "$(find "$Dir$Name" -maxdepth 0 -empty)" ]; then
  fusermount -u "$Dir$Name" && notify-send "Android Mount" "Device Unmounted"
else
  go-mtpfs --device "$Id" "$Dir$Name" && notify-send "Android Mount" "Device Mounted in $Dir$Name"
fi
