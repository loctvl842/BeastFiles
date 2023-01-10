sed -i -e '0,/$visible .*/s//$visible true/' ~/.config/i3/config
theme=$(grep -w theme ~/.config/i3/config | grep -oP 'theme \K\w+')
~/.config/polybar/$theme/launch.sh
