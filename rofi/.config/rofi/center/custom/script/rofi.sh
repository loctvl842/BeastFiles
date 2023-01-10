source ~/.config/rofi/source/source.sh

function change_theme() {
  colorscheme_id=$1
  colorscheme_name=$2
	hexColor=$(grep -w title ~/.config/rofi/themes/$colorscheme_id.rasi | grep -oP 'title: #\K\w+')
	# rofi
	sed -i -e "0,/@import.*/s//@import \".\/$colorscheme_id.rasi\"/" ~/.config/rofi/themes/theme.rasi
	# border
	sed -i -e "0,/bspc\ config\ focused_border_color.*/s//bspc\ config\ focused_border_color\ '#$hexColor'/" ~/.config/bspwm/bspwmrc
	# polybar
	sed -i -e "0,/include-file = \~\/.config\/polybar\/colors.*/s//include-file = \~\/.config\/polybar\/colors\/$colorscheme_id.ini/" \
		~/.config/polybar/theme.ini

	# sleep 0.1 so that current terminal won't freeze
	sleep 0.1
	~/.config/polybar/launch.sh
	sleep 0.1
	bspc wm -r &
}

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/rofi.rasi \
        <<< "$previous|"$prefix"Monokai|"$prefix"Monokai++|"$prefix"Vscode|"$prefix"Tokyo Night|"$prefix"Mac Color")"
  case "$MENU" in
			*"$previous") $CENTER_CUSTOM_SCRIPT_DIR/custom.sh;;
      *""$prefix"Monokai") change_theme "monokai" "Monokai";;
      *""$prefix"Monokai++") change_theme "monokai-plus" "Monokai++";;
      *""$prefix"Vscode") change_theme "vscode" "Vscode";;
      *""$prefix"Tokyo Night") change_theme "tokyo-night" "Tokyo Night";;
      *""$prefix"Mac Color") change_theme "mac-color" "Mac Color";;
  esac
