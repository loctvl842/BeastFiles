time=0.15
sleep $time
polybar topbar-single -r -c ~/.config/polybar/Single/main/config.ini &
if [[ $(xrandr -q | grep "HDMI-1 connected") ]]; then
  sleep $time
  polybar topbar-single -r -c ~/.config/polybar/Single/external/config-external.ini &
fi
