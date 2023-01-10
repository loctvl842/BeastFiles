source ~/.config/rofi/source/source.sh

function change_theme() {
  theme_id=$1
  theme_name=$2

	sed -i -e "0,/include-file = \~\/.config\/polybar\/colors.*/s//include-file = \~\/.config\/polybar\/colors\/$theme_id.ini/" \
		~/.config/polybar/theme.ini


  # dunstify -i "$DROPDOWN_CUSTOM_LOGO_DIR/polybar.png" "Polybar Theme: $theme_name" -t 2000
	# re-launch polybar
	~/.config/polybar/launch.sh
}


MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $DROPDOWN_CUSTOM_APPEARANCE_DIR/polybar-theme.rasi \
        <<< "$previous|"$prefix"Monokai|"$prefix"Monokai++|"$prefix"Vscode|"$prefix"Tokyo Night|"$prefix"Mac Color")"
  case "$MENU" in
			*"$previous") $DROPDOWN_CUSTOM_SCRIPT_DIR/polybar.sh;;
			*""$prefix"Monokai") change_theme "monokai" "Monokai";;
			*""$prefix"Monokai++") change_theme "monokai-plus" "Monokai++";;
			*""$prefix"Vscode") change_theme "vscode" "Vscode";;
			*""$prefix"Tokyo Night") change_theme "tokyo-night" "Tokyo Night";;
			*""$prefix"Mac Color") change_theme "mac-color" "Mac Color";;
  esac
