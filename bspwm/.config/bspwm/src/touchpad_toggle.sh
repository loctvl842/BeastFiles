#!/bin/bash

declare -i ID
ID=`xinput list | grep -Eio '(touchpad|glidepoint)\s*id\=[0-9]{1,2}' | grep -Eo '[0-9]{1,2}'`
declare -i STATE
STATE=`xinput list-props $ID | grep 'Device Enabled' | awk '{print $4}'`
if [ $STATE -eq 1 ]
then
  xinput disable $ID
  # echo "Touchpad disabled."
  # notify-send -a 'Touchpad' 'Disabled' -i input-touchpad
  killall dunst
  dunstify "Disabled" --icon="~/Pictures/touchpad/touchpad.png" -t 700
else
  xinput enable $ID
  # echo "Touchpad enabled."
  # notify-send -a 'Touchpad' 'Enabled' -i input-touchpad
  killall dunst
  dunstify "Enabled" --icon="~/Pictures/touchpad/touchpad.png" -t 700
fi
