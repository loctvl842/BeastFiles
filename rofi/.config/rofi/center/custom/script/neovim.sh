source ~/.config/rofi/source/source.sh

function change_theme() {
  colorscheme_id=$1
  colorscheme_name=$2
  sed -i -e '0,/colorscheme .*/s//colorscheme = "'$colorscheme_id'"/' ~/.config/nvim/lua/setup/colorscheme.lua 
  dunstify -i "$CENTER_CUSTOM_LOGO_DIR/neovim.png" "Colorscheme: $colorscheme_name" -t 2000
}

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/neovim.rasi \
        <<< "$previous|"$prefix"Monokai|"$prefix"Monokai++|"$prefix"Vscode|"$prefix"Light|"$prefix"Tokyo Night")"
  case "$MENU" in
			*"$previous") $CENTER_CUSTOM_SCRIPT_DIR/custom.sh;;
      *""$prefix"Monokai") change_theme "monokai" "Monokai";;
      *""$prefix"Monokai++") change_theme "monokai-plus" "Monokai++";;
      *""$prefix"Vscode") change_theme "vscode" "Vscode";;
      *""$prefix"Light") change_theme "light" "Light";;
      *""$prefix"Tokyo Night") change_theme "tokyo-night" "Tokyo Night";;
  esac
