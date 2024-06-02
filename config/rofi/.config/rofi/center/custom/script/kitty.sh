#!/bin/bash
source ~/.config/rofi/source/source.sh

KITTY_CONF="/home/loc/.config/kitty/kitty.conf"

function change_theme() {
  colorscheme_id=$1
  # border_hexcolor=#ffffff
  # sed -i -e '0,/colors: .*/s//colors: *'$colorscheme_id'/' $ALACRITTY_CONF
  # sed -i -e "0,/bspc\ config\ focused_border_color.*/s//bspc\ config\ focused_border_color\ '$border_hexcolor'/" ~/.config/bspwm/bspwmrc
  sed -i -e "0,/include\ \.\/themes\/.*/s//include .\/themes\/$colorscheme_id\.conf/" $KITTY_CONF
  bspc wm -r &
  kill -SIGUSR1 $(pgrep kitty)
}

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/kitty.rasi \
        <<< "$previous|"$prefix"Monokai|"$prefix"Dracula|"$prefix"Gruvbox|"$prefix"One Dark|"$prefix"Palenight")"

case "$MENU" in
  *"$previous") $CENTER_CUSTOM_SCRIPT_DIR/terminal.sh ;;
  *""$prefix"Monokai") $CENTER_CUSTOM_SCRIPT_DIR/monokai.sh "kitty" ;;
  *""$prefix"Dracula") change_theme "dracula" ;;
  *""$prefix"Gruvbox") change_theme "gruvbox" ;;
  *""$prefix"One Dark") change_theme "one-dark" ;;
  *""$prefix"Palenight") change_theme "palenight" ;;
esac
