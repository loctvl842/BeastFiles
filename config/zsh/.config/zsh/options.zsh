#!/bin/bash

# Detect operating system
if [[ "$(uname)" == "Darwin" ]]; then
  OS="macos"
elif [[ -f "/etc/arch-release" ]]; then
  OS="arch"
else
  echo "Unsupported operating system. This script is designed for Arch Linux and macOS."
  exit 1
fi

# Configure keyboard settings for Linux/X11
set_linux_keyboard() {
  # Check if X is running
  if [ "$DISPLAY" ]; then
    xset r rate 240 60
    echo "Set keyboard repeat rate using xset"

    # Check window manager
    if command -v wmctrl >/dev/null 2>&1; then
      wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')
      if [[ $wm = "bspwm" ]]; then
        setxkbmap -option caps:escape
        echo "Set Caps Lock to Escape for bspwm"
      fi
    else
      echo "wmctrl not found, skipping window manager check"
    fi
  else
    echo "X display not detected, skipping X11 keyboard settings"
  fi
}

# Configure keyboard settings for macOS
set_macos_keyboard() {
  # Set key repeat rate and delay
  defaults write NSGlobalDomain KeyRepeat -int 2
  defaults write NSGlobalDomain InitialKeyRepeat -int 15
  # echo "Configured keyboard repeat rate for macOS"
}

# Apply settings based on detected OS
if [[ "$OS" == "macos" ]]; then
  set_macos_keyboard
elif [[ "$OS" == "arch" ]]; then
  set_linux_keyboard
fi
