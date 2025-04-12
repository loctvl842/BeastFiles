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
  echo "Configured keyboard repeat rate for macOS"

  # Check if Karabiner-Elements is installed for caps to escape mapping
  if [ -d "/Applications/Karabiner-Elements.app" ]; then
    KARABINER_CONFIG="$HOME/.config/karabiner/karabiner.json"

    # Create directory if it doesn't exist
    mkdir -p "$HOME/.config/karabiner"

    # Initialize config if it doesn't exist
    if [ ! -f "$KARABINER_CONFIG" ]; then
      echo '{
        "global": {
          "check_for_updates_on_startup": true,
          "show_in_menu_bar": true,
          "show_profile_name_in_menu_bar": false
        },
        "profiles": [
          {
            "name": "Default profile",
            "selected": true,
            "simple_modifications": [
              {
                "from": { "key_code": "caps_lock" },
                "to": { "key_code": "escape" }
              }
            ]
          }
        ]
      }' > "$KARABINER_CONFIG"
      echo "Configured Caps Lock to Escape using Karabiner-Elements"
    else
      echo "Karabiner-Elements configuration already exists."
      echo "Please check if Caps Lock to Escape mapping is already configured."
    fi
  else
    echo "Karabiner-Elements is not installed."
    echo "Please install it from https://karabiner-elements.pqrs.org/ to remap Caps Lock to Escape."
  fi
}

# Apply settings based on detected OS
if [[ "$OS" == "macos" ]]; then
  echo "macOS detected, applying macOS keyboard settings..."
  set_macos_keyboard
elif [[ "$OS" == "arch" ]]; then
  echo "Arch Linux detected, applying X11 keyboard settings..."
  set_linux_keyboard
fi

echo "Keyboard configuration complete."
