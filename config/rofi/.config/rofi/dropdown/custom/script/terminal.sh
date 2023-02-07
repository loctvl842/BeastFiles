source ~/.config/rofi/source/source.sh

ALACRITTY_CONF="/home/loc/.config/alacritty/alacritty.yml"
KITTY_CONF="/home/loc/.config/kitty/kitty.conf"

function change_theme() {
  colorscheme_id=$1
  colorscheme_name=$2
  sed -i -e '0,/colors: .*/s//colors: *'$colorscheme_id'/' $ALACRITTY_CONF
	sed -i -e "0,/include\ \.\/themes\/.*/s//include .\/themes\/$colorscheme_id\.conf/" $KITTY_CONF
  dunstify -i "$DROPDOWN_CUSTOM_LOGO_DIR/terminal.png" "Alacritty: $colorscheme_name" -t 2000
}

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $DROPDOWN_CUSTOM_APPEARANCE_DIR/terminal.rasi \
        <<< "$previous|"$prefix"Monokai|"$prefix"Monokai++|"$prefix"Tokyo Night|"$prefix"Vscode Dark|"$prefix"One Dark|"$prefix"Gruvbox|"$prefix"Dracula|"$prefix"Palenight|"$prefix"Tokyo Night Storm")"

  case "$MENU" in
			*"$previous") $DROPDOWN_CUSTOM_SCRIPT_DIR/custom.sh;;
      *""$prefix"Monokai") change_theme "monokai" "Monokai";;
			*""$prefix"Monokai++") change_theme "monokai-plus" "Monokai++";;
			*""$prefix"Tokyo Night") change_theme "tokyo-night" "Tokyo Night";;
			*""$prefix"Vscode Dark") change_theme "vscode-dark" "Vscode Dark";;
      *""$prefix"One Dark") change_theme "one-dark" "One Dark";;
      *""$prefix"Gruvbox") change_theme "gruvbox" "Gruvbox";;
      *""$prefix"Dracula") change_theme "dracula" "Dracula";;
      *""$prefix"Palenight") change_theme "palenight" "Palenight";;
      *""$prefix"Tokyo Night Storm") change_theme "tokyo-night-storm" "Tokyo Night Storm";;
  esac
