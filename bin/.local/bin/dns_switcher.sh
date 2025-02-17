#!/bin/bash

# Get the current active Wi-Fi connection name
wifi_name=$(nmcli -t -f NAME,DEVICE con show --active | grep ":wlp" | cut -d ':' -f 1)

# Check if a Wi-Fi connection was found
if [ -z "$wifi_name" ]; then
  echo "No active Wi-Fi connection found."
  exit 1
fi

# Function to switch DNS
switch_dns() {
  sudo nmcli con mod "$wifi_name" ipv4.ignore-auto-dns yes
  sudo nmcli con mod "$wifi_name" ipv4.dns "$1"
  sudo nmcli con up "$wifi_name"
  echo "Switched to $2 DNS"
}

# Handle user input
case "$1" in
  cloudflare)
    switch_dns "1.1.1.1 1.0.0.1" "Cloudflare"
    ;;
  google)
    switch_dns "8.8.8.8 8.8.4.4" "Google"
    ;;
  default)
    sudo nmcli con mod "$wifi_name" ipv4.ignore-auto-dns no
    sudo nmcli con mod "$wifi_name" ipv4.dns ""
    sudo nmcli con up "$wifi_name"
    echo "Switched back to default DNS"
    ;;
  *)
    echo "Usage: dns-switcher {cloudflare|google|default}"
    exit 1
    ;;
esac

# Display current DNS settings
echo "Current DNS servers:"
nmcli dev show | grep DNS
