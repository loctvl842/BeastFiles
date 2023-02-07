source ~/.config/rofi/source/source.sh

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/polybar.rasi \
        <<< "$previous|"$prefix"Shape|"$prefix"Theme")"
  case "$MENU" in
		*"$previous") $CENTER_CUSTOM_SCRIPT_DIR/custom.sh;;
		*""$prefix"Shape") $CENTER_CUSTOM_SCRIPT_DIR/polybar-shape.sh;;
		*""$prefix"Theme") $CENTER_CUSTOM_SCRIPT_DIR/polybar-theme.sh;;
  esac
