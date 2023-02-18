percentage=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "percentage" | grep -Eo '\<[0-9]+\>')
killall dunst
dunstify 'Battery' $percentage%
