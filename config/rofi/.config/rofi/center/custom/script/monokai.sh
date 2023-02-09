#!/bin/bash
source ~/.config/rofi/source/source.sh

terminal=$1

ALACRITTY_CONF="/home/loc/.config/alacritty/alacritty.yml"
KITTY_CONF="/home/loc/.config/kitty/kitty.conf"

function change_theme() {
  colorscheme_id=$1
  if [[ $terminal == "kitty" ]]; then
    dunstify 'loc'
    sed -i -e "0,/include\ \.\/themes\/.*/s//include .\/themes\/monokai\/monokai-pro$colorscheme_id\.conf/" $KITTY_CONF
    kill -SIGUSR1 $(pgrep kitty)
  elif [[ $terminal == "alacritty" ]]; then
    dunstify 'config monokai.sh for alacritty !!!'
    sed -i -e '0,/colors: .*/s//colors: *'$colorscheme_id'/' $ALACRITTY_CONF
  fi
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
        <<< "       $previous|"$prefix"Monokai Pro|"$prefix"Monokai Pro Classic|"$prefix"Monokai Pro (Filter Machine)|"$prefix"Monokai Pro (Filter Octagon)|"$prefix"Monokai Pro (Filter Ristretto)|"$prefix"Monokai Pro (Filter Spectrum)")"

  case "$MENU" in
      *"       $previous") nav_back;;
      *""$prefix"Monokai Pro") change_theme "";;
      *""$prefix"Monokai Pro Classic") change_theme "_classic";;
			*""$prefix"Monokai Pro (Filter Machine)") change_theme "_machine";;
			*""$prefix"Monokai Pro (Filter Octagon)") change_theme "_octagon";;
			*""$prefix"Monokai Pro (Filter Ristretto)") change_theme "_ristretto";;
			*""$prefix"Monokai Pro (Filter Spectrum)") change_theme "_spectrum";;
  esac
