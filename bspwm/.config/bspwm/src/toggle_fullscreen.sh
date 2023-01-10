state=$(bspc query -n focused.local -T | jq -r .client.state)

if [[ $state != 'fullscreen' ]]; then
  bspc node -t fullscreen
else
  bspc node -t tiled
fi
