# tiled / monocle
layout=$(bspc query -T -d | jq -r .layout)
# tiled / fullscreen
state=$(bspc query -n focused.local -T | jq -r .client.state)
if [[ $state == 'fullscreen' ]]; then
  bspc node -t tiled
  if [[ $layout == 'monocle' ]]; then
    exit 0
  fi
fi
bspc desktop -l next
