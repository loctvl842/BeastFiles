#!/bin/bash

# `brillo` does the same thing to `light`
# but `brillo` decrease the percentage of brightness exactly linear
# https://konradstrack.ninja/blog/changing-screen-brightness-in-accordance-with-human-perception/

function send_notification() {
	brightness=$(brillo -G | cut -d '.' -f 1)
  if [ $brightness -gt 20 -a $brightness -lt 50 ]
  then
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/sharingan1.png" "Brightness: $brightness%" -t 2000
  elif [ $brightness -ge 50 -a $brightness -lt 60 ]
  then
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/sharingan2.png" "Brightness: $brightness%" -t 2000
  elif [ $brightness -ge 60 -a $brightness -lt 85 ]
  then
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/sharingan3.png" "Brightness: $brightness%" -t 2000
  elif [ $brightness -ge 85 -a $brightness -lt 95 ]
  then
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/sharingan.png" "Brightness: $brightness%" -t 2000
  elif [ $brightness -ge 95 ]
  then
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/rinnegan.png" "Brightness: $brightness%" -t 2000
  else
    dunstify -a "changebrightness" -u low -r 9991 -h int:value:"$brightness" -i "~/.local/bin/dunst_icons/brightness/byakugan.png" "Brightness: $brightness%" -t 2000
  fi
}

case $1 in
up)
  brillo -A 1
	send_notification $1
	;;
down)
	brillo -U 1
	send_notification $1
	;;
esac
