#!/bin/sh

is_display_connected() {
  local DISPLAY_OUTPUT=$1
  local connected_status=$(xrandr -q | grep "$DISPLAY_OUTPUT" | grep -oP "$DISPLAY_OUTPUT \K\w+")
  if [[ $connected_status == "connected" ]]; then
    return 0
  else
    return 1
  fi
}
