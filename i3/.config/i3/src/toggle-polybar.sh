ADDITIONAL_GAP=5
I3_CONFIG='/home/loc/.config/i3/config'

gapsTop=$(grep 'gaps top' ~/.config/i3/config | grep -oP 'top \K\w+')
theme=$(grep -w theme ~/.config/i3/config | grep -oP 'theme \K\w+')
height=$(grep -w height ~/.config/polybar/$theme/bar-settings.ini | grep -oP 'height = \K\w+')

if [ $gapsTop -gt 0 ]
then
  sed -i -e '0,/gaps top .*/s//gaps top 0/' $I3_CONFIG
  polybar-msg cmd hide
  i3-msg reload
  xdotool click 1
else
  newGap=`expr $height + $ADDITIONAL_GAP`
  sed -i -e "0,/gaps top .*/s//gaps top $newGap/" $I3_CONFIG
  polybar-msg cmd show
  i3-msg reload
  xdotool click 1
fi
