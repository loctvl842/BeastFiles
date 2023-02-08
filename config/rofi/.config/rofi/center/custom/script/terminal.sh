source ~/.config/rofi/source/source.sh

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/terminal.rasi \
        <<< "$previous|"$prefix"Alacritty|"$prefix"Kitty")"

  case "$MENU" in
			*"$previous") $CENTER_CUSTOM_SCRIPT_DIR/custom.sh;;
      *""$prefix"Alacritty") $CENTER_CUSTOM_SCRIPT_DIR/alacritty.sh;;
			*""$prefix"Kitty") $CENTER_CUSTOM_SCRIPT_DIR/kitty.sh;;
  esac
