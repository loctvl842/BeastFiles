state=$(bspc query -n focused.local -T | jq -r .client.state)
old_state=$(bspc query -n focused.local -T | jq -r .client.lastState)

if [[ $state != 'fullscreen' ]]; then
  bspc node -t fullscreen
else
  bspc node -t $old_state
fi
