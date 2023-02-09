source ~/.config/rofi/source/source.sh

MENU="$(rofi -sep "|" \
        -dmenu -i  \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/custom.rasi \
        <<< "$close|"$prefix"Polybar|"$prefix"Terminal|"$prefix"Border")"

  case "$MENU" in
			*"$close") exit 0;;
      *""$prefix"Polybar") $CENTER_CUSTOM_SCRIPT_DIR/polybar.sh;;
      # *""$prefix"Neovim") $CENTER_CUSTOM_SCRIPT_DIR/neovim.sh;;
      *""$prefix"Terminal") $CENTER_CUSTOM_SCRIPT_DIR/terminal.sh;;
      *""$prefix"Border") $CENTER_CUSTOM_SCRIPT_DIR/border.sh;;
			# *""$prefix"Rofi") $CENTER_CUSTOM_SCRIPT_DIR/rofi.sh;;
  esac
