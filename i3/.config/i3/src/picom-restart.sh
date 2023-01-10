killall picom

while pgrep -u $UID -x picom >/dev/null; do sleep 0.2; done

picom -b
