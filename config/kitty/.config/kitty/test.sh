#!/bin/bash

# Read the config file
config=$(cat config.json)

# Extract eDP and default configurations
eDP_config=$(echo "$config" | jq -r '.kitty.eDP | to_entries[] | "\(.key)=\(.value)"')
default_config=$(echo "$config" | jq -r '.kitty.default | to_entries[] | "\(.key)=\(.value)"')

# Merge eDP and default configurations
merged_config="$eDP_config"$'\n'"$default_config"

# Print the merged configuration values
echo "Merged configuration:"
echo "$merged_config"

