# tiled / monocle
layout=$(bspc query -T -d | jq -r .layout)
# tiled / fullscreen
state=$(bspc query -n focused.local -T | jq -r .client.state)

if [[ $layout == "monocle" ]]; then
	bspc desktop -l next
  if [[ $state == 'fullscreen' ]]; then
    bspc node -t tiled
  fi
else
  bspc node -t tiled
fi
