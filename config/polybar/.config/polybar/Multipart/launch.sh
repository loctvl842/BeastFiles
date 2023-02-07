time=0.15
sleep $time
polybar topbar-left -r -c ~/.config/polybar/Multipart/main/config.ini &
sleep $time
polybar topbar-beast -r -c ~/.config/polybar/Multipart/main/config.ini &
sleep $time
polybar topbar-center -r -c ~/.config/polybar/Multipart/main/config.ini &
sleep $time
polybar topbar-tray -r -c ~/.config/polybar/Multipart/main/config.ini &
sleep $time
polybar topbar-right -r -c ~/.config/polybar/Multipart/main/config.ini &

if [[ $(xrandr -q | grep "HDMI-A-0 connected") ]]; then
  sleep $time
  polybar topbar-left -r -c ~/.config/polybar/Multipart/external/config.ini &
  sleep $time
  polybar topbar-tray -r -c ~/.config/polybar/Multipart/external/config.ini &
  sleep $time
  polybar topbar-center -r -c ~/.config/polybar/Multipart/external/config.ini &
  sleep $time
  polybar topbar-beast -r -c ~/.config/polybar/Multipart/external/config.ini &
  sleep $time
  polybar topbar-right -r -c ~/.config/polybar/Multipart/external/config.ini &
fi
