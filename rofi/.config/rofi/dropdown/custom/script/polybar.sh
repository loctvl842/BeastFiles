source ~/.config/rofi/source/source.sh

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $DROPDOWN_CUSTOM_APPEARANCE_DIR/polybar.rasi \
        <<< "$previous|Shape|Theme")"
  case "$MENU" in
		*"$previous") $DROPDOWN_CUSTOM_SCRIPT_DIR/custom.sh;;
		*""$prefix"Shape") $DROPDOWN_CUSTOM_SCRIPT_DIR/polybar-shape.sh;;
		*""$prefix"Theme") $DROPDOWN_CUSTOM_SCRIPT_DIR/polybar-theme.sh;;
  esac
