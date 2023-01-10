#!/bin/bash
state=$(xset -q | grep Caps | awk '{print $4}')
xdotool key Caps_Lock
if [ "$state" = "on" ]
then
  notify-send "CAPLOCK" "OFF" --icon="~/Pictures/caplock/caplock-off.png" -t 700 -a "System"
fi

if [ "$state" = "off" ]
then
  notify-send "CAPLOCK" "ON" --icon="~/Pictures/caplock/caplock-on.png" -t 700 -a "System"
fi
