#!/bin/bash

# Get the current active Wi-Fi connection name
wifi_name=$(nmcli -t -f NAME,DEVICE con show --active | grep ":wlp" | cut -d ':' -f 1)

# Check if a Wi-Fi connection was found
if [ -z "$wifi_name" ]; then
  echo "No active Wi-Fi connection found."
  exit 1
fi

if [ "$1" == "cloudflare" ]; then
  sudo nmcli con mod "$wifi_name" ipv4.dns "1.1.1.1 1.0.0.1"
  sudo nmcli con up "$wifi_name"
  echo "Switched to Cloudflare DNS"
elif [ "$1" == "default" ]; then
  sudo nmcli con mod "$wifi_name" ipv4.dns ""
  sudo nmcli con up "$wifi_name"
  echo "Switched back to default DNS"
else
  echo "Usage: dns-switcher {cloudflare|default}"
fi
