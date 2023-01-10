I3_CONFIG='/home/loc/.config/i3/config'
ADDITIONAL_GAP=5

theme=$(grep -w theme ~/.config/i3/config | grep -oP 'theme \K\w+')
height=$(grep -w height ~/.config/polybar/$theme/bar-settings.ini | grep -oP 'height = \K\w+')

newGap=`expr $height + $ADDITIONAL_GAP`

sed -i -e "0,/gaps top .*/s//gaps top 35/" ~/.config/i3/config
i3-msg restart
