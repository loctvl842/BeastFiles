conky -c ~/.config/conky/xfactor.conf &
if [[ $(xrandr -q | grep 'HDMI' | grep -oP 'HDMI-A-0 \K\w+') == "connected" ]]; then
  conky -c ~/.config/conky/external/xfactor-external.conf &
fi
