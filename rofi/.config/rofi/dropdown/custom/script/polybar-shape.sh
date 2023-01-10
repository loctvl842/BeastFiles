source ~/.config/rofi/source/source.sh

function change_theme() {
  shape_id=$1
  shape_name=$2
	sed -i -e "0,/shape=.*/s//shape=\"$shape_id\"/" \
		~/.config/polybar/launch.sh

	if [[ $shape_id == "Single" ]]; then
		sed -i -e "0,/radius = .*/s//radius = 0/" ~/.config/polybar/bar-settings.ini
	elif [[ $shape_id == "Multipart" ]]; then
		sed -i -e "0,/radius = .*/s//radius = 15/" ~/.config/polybar/bar-settings.ini
	fi

  # dunstify -i "$DROPDOWN_CUSTOM_LOGO_DIR/polybar.png" "Polybar Shape: $shape_name" -t 2000
	# re-launch polybar
	~/.config/polybar/launch.sh
}


MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $DROPDOWN_CUSTOM_APPEARANCE_DIR/polybar-shape.rasi \
        <<< "$previous|"$prefix"Multipart|"$prefix"Single")"
  case "$MENU" in
			*"$previous") $DROPDOWN_CUSTOM_SCRIPT_DIR/polybar.sh;;
			*""$prefix"Multipart") change_theme "Multipart" "Multipart";;
			*""$prefix"Single") change_theme "Single" "Single";;
  esac
