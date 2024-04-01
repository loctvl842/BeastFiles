HDMI_OUTPUT=$(xrandr --listmonitors | grep -o 'HDMI[^ ]*' | head -n 1)
EDP_OUTPUT=$(xrandr --listmonitors | grep -o 'eDP[^ ]*' | head -n 1)
