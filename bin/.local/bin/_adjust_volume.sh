#!/bin/bash

function send_notification() {
  volume=$(pactl list sinks | awk '$1=="Volume:" {gsub(/[%]/, "", $5); print $5}')
  level=0
  if [ $volume -gt 0 -a $volume -lt 33 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.local/bin/dunst_icons/volume/volume-woman.png" "Volume: ${volume}%" -t 2000
  elif [ $volume -gt 33 -a $volume -lt 66 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.local/bin/dunst_icons/volume/volume-woman.png" "Volume: ${volume}%" -t 2000
  elif [ $volume -gt 66 ]
  then
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.local/bin/dunst_icons/volume/volume-woman.png" "Volume: ${volume}%" -t 2000
  else
    dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.local/bin/dunst_icons/volume/volume-woman.png" "Volume: ${volume}%" -t 2000
  fi
}

function notify() {
  command=$1

  # Get device name of the default sink
  device_name=$(pactl list sinks | grep 'analog-stereo' | awk '/Name:/ {print $2}')

  # Get the volume of all sinks
  # volume=$(pactl list sinks | awk '$1=="Volume:" {gsub(/[%]/, "", $5); print $5}')

  # Get the volume by device name
  volume=$(pactl list sinks | awk -v device="$device_name" '/Name:/ && $0 ~ device {flag=1; next} flag && $1=="Volume:" {gsub(/[%]/, "", $5); print $5; exit}')

  dunstify -a "changevolume" -u low -r "9993" -h int:value:"$volume" -i "~/.local/bin/dunst_icons/volume/volume-$command.png" "Volume: ${volume}%" -t 2000
}

case $1 in
up)
  # Set the volume on (if it was muted)
  # pamixer -u
  # pamixer -i 1 --allow-boost
  pactl set-sink-volume @DEFAULT_SINK@ +1%
  notify "up"
  # send_notification $1
  ;;
down)
  # pamixer -u
  # pamixer -d 1 --allow-boost
  pactl set-sink-volume @DEFAULT_SINK@ -1%
  notify "down"
  # send_notification $1
  ;;
mute)
  pactl set-sink-mute @DEFAULT_SINK@ toggle
  notify "mute"
esac
