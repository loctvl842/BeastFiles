#!/bin/bash

function send_notification() {
	volume=$(pamixer --get-volume)
  level=0
  if [ $volume -gt 0 -a $volume -lt 33 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.config/dunst/icons/volume-woman.png" "Volume: ${volume}%" -t 2000
  elif [ $volume -gt 33 -a $volume -lt 66 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.config/dunst/icons/volume-woman.png" "Volume: ${volume}%" -t 2000
  elif [ $volume -gt 66 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.config/dunst/icons/volume-woman.png" "Volume: ${volume}%" -t 2000
  else
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.config/dunst/icons/volume-woman.png" "Volume: ${volume}%" -t 2000
  fi
}

function notify() {
	command=$1
	echo $command
	volume=$(pamixer --get-volume)
	dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.config/dunst/icons/volume-$command.png" "Volume: ${volume}%" -t 2000
}

case $1 in
up)
	# Set the volume on (if it was muted)
	pamixer -u
	pamixer -i 1 --allow-boost
	notify "up"
	# send_notification $1
	;;
down)
	pamixer -u
	pamixer -d 1 --allow-boost
	notify "down"
	# send_notification $1
	;;
mute)
	pamixer -m
	notify "mute"
	# pamixer -t
	# if $(pamixer --get-mute); then
	# 	dunstify -i volume-mute -a "changevolume" -t 2000 -r 9993 -u low "Muted"
	# else
	# 	send_notification up
	# fi
	# ;;
esac
