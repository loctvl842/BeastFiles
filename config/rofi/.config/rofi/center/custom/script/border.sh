source ~/.config/rofi/source/source.sh
getHexColor() {
	rofi -dmenu\
		-i\
		-no-fixed-num-lines\
		-p "Input hex color: "\
		-theme $CENTER_CUSTOM_APPEARANCE_DIR/border.rasi
}
hexColor=$(getHexColor &)
validCharacter="0123456789abcdef"

if [[ ${#hexColor} == 0 ]]; then
	exit 0
fi

if [[ ${#hexColor} != 7 ]]; then
	dunstify -i "$CENTER_CUSTOM_LOGO_DIR/error.png" "$hexColor is not a hex color" -t 5000
	exit 0
fi

for (( i = 1; i < ${#hexColor}; i++ ))
do
	char=${hexColor:$i:1}
	if [[ ! ${validCharacter[*]} =~ $char ]]; then
		dunstify -i "$CENTER_CUSTOM_LOGO_DIR/error.png" "$hexColor is not a hex color" -t 5000
		exit 0
	fi
done

sed -i -e "0,/bspc\ config\ focused_border_color.*/s//bspc\ config\ focused_border_color\ '$hexColor'/" ~/.config/bspwm/bspwmrc
bspc wm -r

