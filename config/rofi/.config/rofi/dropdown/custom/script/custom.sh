source ~/.config/rofi/source/source.sh

MENU="$(rofi -sep "|" \
        -dmenu -i  \
        -theme $DROPDOWN_CUSTOM_APPEARANCE_DIR/custom.rasi \
        <<< "Polybar|Neovim|Terminal|Border|Rofi")"

  case "$MENU" in
      *"Polybar") $DROPDOWN_CUSTOM_SCRIPT_DIR/polybar.sh;;
      *"Neovim") $DROPDOWN_CUSTOM_SCRIPT_DIR/neovim.sh;;
      *"Terminal") $DROPDOWN_CUSTOM_SCRIPT_DIR/terminal.sh;;
      *"Border") $DROPDOWN_CUSTOM_SCRIPT_DIR/border.sh;;
			*"Rofi") $DROPDOWN_CUSTOM_SCRIPT_DIR/rofi.sh;;
  esac
