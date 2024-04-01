#!/bin/bash

source $HOME/BeastFiles/src/main.sh

# Read and parse JSON file
json_data=$(cat config.json)

# Merge eDP and default configurations
eDP_config=$(jq '.kitty.eDP as $eDP | .kitty.default as $default | reduce ($eDP + $default | to_entries[]) as $entry ({}; if $entry.value | type == "object" then .[$entry.key] += $entry.value else .[$entry.key] = $entry.value end) | {eDP: .}' <<< "$json_data")
HDMI_config=$(jq '.kitty.HDMI as $HDMI | .kitty.default as $default | reduce ($HDMI + $default | to_entries[]) as $entry ({}; if $entry.value | type == "object" then .[$entry.key] += $entry.value else .[$entry.key] = $entry.value end) | {eDP: .}' <<< "$json_data")

if is_display_connected $HDMI_OUTPUT; then
  echo "$json_data" | jq -r '.kitty.HDMI | to_entries[] | .key + ":" + (.value | tostring)' | while IFS=: read -r key value; do
    # Run sed command for each key-value pair
    sed -i "s/$key .*/$key $value/" ~/.config/kitty/kitty.conf
  done
else
  echo "$json_data" | jq -r '.kitty.eDP | to_entries[] | .key + ":" + (.value | tostring)' | while IFS=: read -r key value; do
    # Run sed command for each key-value pair
    sed -i "s/$key .*/$key $value/" ~/.config/kitty/kitty.conf
  done
fi

# Reload kitty
kill -SIGUSR1 $(pgrep kitty)
