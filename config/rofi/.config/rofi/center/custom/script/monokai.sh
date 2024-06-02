#!/bin/bash
source ~/.config/rofi/source/source.sh

terminal=$1

ALACRITTY_CONF="$HOME/.config/alacritty/alacritty.yml"
KITTY_CONF="$HOME/.config/kitty/kitty.conf"
TMUX_CONF="$HOME/.config/tmux/tmux.conf"

function change_theme() {
  colorscheme_id=$1

  if [[ $terminal == "kitty" ]]; then
    border_hexcolor=$(grep -w color7 ~/.config/kitty/themes/monokai/monokai-pro_$colorscheme_id.conf | grep -oP 'color7 \s+\K[^ ]+')
    sed -i -e "0,/bspc\ config\ focused_border_color.*/s//bspc\ config\ focused_border_color\ '$border_hexcolor'/" ~/.config/bspwm/bspwmrc
    sed -i -e "0,/include\ \.\/themes\/.*/s//include .\/themes\/monokai\/monokai-pro_$colorscheme_id\.conf/" $KITTY_CONF
    kill -SIGUSR1 $(pgrep kitty)
    bspc wm -r
  elif [[ $terminal == "alacritty" ]]; then
    dunstify 'config monokai.sh for alacritty !!!'
    sed -i -e '0,/colors: .*/s//colors: *'$colorscheme_id'/' $ALACRITTY_CONF
  fi

  # Update tmux colorscheme
  sed -i -e '0,/set\ -g @monokai-pro-filter.*/s//set -g @monokai-pro-filter '\'$colorscheme_id\''/' $TMUX_CONF
  tmux source-file $TMUX_CONF
}

function nav_back() {
  if [[ $terminal == "kitty" ]]; then
    $CENTER_CUSTOM_SCRIPT_DIR/kitty.sh
  elif [[ $terminal == "alacritty" ]]; then
    $CENTER_CUSTOM_SCRIPT_DIR/alacritty.sh
  fi
}

MENU="$(rofi -sep "|" \
        -dmenu -i -p 'System' \
        -theme $CENTER_CUSTOM_APPEARANCE_DIR/monokai.rasi \
        <<< "$previous|"$prefix"Monokai Pro|"$prefix"Monokai Pro Classic|"$prefix"Monokai Pro (Filter Machine)|"$prefix"Monokai Pro (Filter Octagon)|"$prefix"Monokai Pro (Filter Ristretto)|"$prefix"Monokai Pro (Filter Spectrum)")"

case "$MENU" in
  *"$previous") nav_back ;;
  *""$prefix"Monokai Pro") change_theme "pro" ;;
  *""$prefix"Monokai Pro Classic") change_theme "classic" ;;
  *""$prefix"Monokai Pro (Filter Machine)") change_theme "machine" ;;
  *""$prefix"Monokai Pro (Filter Octagon)") change_theme "octagon" ;;
  *""$prefix"Monokai Pro (Filter Ristretto)") change_theme "ristretto" ;;
  *""$prefix"Monokai Pro (Filter Spectrum)") change_theme "spectrum" ;;
esac
