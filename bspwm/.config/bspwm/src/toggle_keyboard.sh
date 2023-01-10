#!/bin/bash

Icon="$HOME/Pictures/keyboard/enable_keyboard.png"
Icoff="$HOME/Pictures/keyboard/disable_keyboard.png"
fconfig=".keyboard" 
# id of internal keyboard
id=$(xinput | grep "AT Translated Set 2 keyboard" | grep -oP '(?<=id=)[0-9]*')

if [ ! -f $fconfig ]; then
  echo "Creating config file"
  echo "enabled" > $fconfig
  var="enabled"
else
  read -r var< $fconfig
  echo "keyboard is : $var"
fi

if [ "$var" = "disabled" ]; then
  killall dunst
  dunstify -i $Icon "Enabling keyboard..." \ "ON - Keyboard connected !";
  echo "enable keyboard..."
  xinput enable $id
  echo "enabled" > $fconfig
elif [ "$var" = "enabled" ]; then
  killall dunst
  dunstify -i $Icoff "Disabling Keyboard" \ "OFF - Keyboard disconnected";
  echo "disable keyboard"
  xinput disable $id
  echo 'disabled' > $fconfig
fi
