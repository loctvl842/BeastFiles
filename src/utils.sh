#!/bin/sh

# Function to check if a display is connected
# - Arguments:
#  - $1: The display output name (e.g. HDMI-1, eDP-1, etc.)
# - Returns:
#  - 0 if the display is connected
#  - 1 if the display is disconnected
is_display_connected() {
  local DISPLAY_OUTPUT=$1
  local connected_status=$(xrandr -q | grep "$DISPLAY_OUTPUT" | grep -oP "$DISPLAY_OUTPUT \K\w+")
  if [[ $connected_status == "connected" ]]; then
    return 0
  else
    return 1
  fi
}
