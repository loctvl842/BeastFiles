ADDITIONAL_GAP=0
BSPWM_CONFIG='/home/loc/.config/bspwm/bspwmrc'

topPadding=$(grep 'top_padding' ~/.config/bspwm/bspwmrc | grep -oP 'top_padding \K\w+')
~/.config/polybar/launch.sh
sleep 0.1s
height=$(grep -w height ~/.config/polybar/bar-settings.ini | grep -oP 'height = \K\w+')
border_size=$(grep -w border-size ~/.config/polybar/bar-settings.ini | grep -oP 'border-size = \K\w+')

newGap=`expr $height + $border_size + $ADDITIONAL_GAP`
# sed -i -e "0,/top_padding .*/s//top_padding $newGap/" $BSPWM_CONFIG
polybar-msg cmd show
bspc config top_padding $newGap
