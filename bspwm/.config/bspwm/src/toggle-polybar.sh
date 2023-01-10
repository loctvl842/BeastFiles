ADDITIONAL_GAP=0
BSPWM_CONFIG="$HOME/.config/bspwm/bspwmrc"

topPadding=$(grep 'top_padding' ~/.config/bspwm/bspwmrc | grep -oP 'top_padding \K\w+')
height=$(grep -w height ~/.config/polybar/bar-settings.ini | grep -oP 'height = \K\w+')
border_size=$(grep -w border-size ~/.config/polybar/bar-settings.ini | grep -oP 'border-size = \K\w+')
bspwm_pb=$(grep -w bottom_padding ~/.config/bspwm/bspwmrc | grep -oP 'bottom_padding \K\w+')

if [ $topPadding -gt 0 ]
then
  sed -i -e '0,/top_padding .*/s//top_padding 0/' $BSPWM_CONFIG
  polybar-msg cmd hide
  bspc config top_padding 0
else
	newGap=`expr $height + $border_size + $bspwm_pb + $ADDITIONAL_GAP`
  sed -i -e "0,/top_padding .*/s//top_padding $newGap/" $BSPWM_CONFIG
  polybar-msg cmd show
  bspc config top_padding $newGap
fi
