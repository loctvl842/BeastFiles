# tiled / monocle
layout=$(bspc query -T -d | jq -r .layout)
# tiled / fullscreen / floating
state=$(bspc query -n focused.local -T | jq -r .client.state)

bspc node -t tiled
bspc desktop -l tiled
# if [[ $layout == "monocle" ]]; then
#   # toggle layout (tiled / monocle)
# 	bspc desktop -l next
#   if [[ $state == "fullscreen" ]]; then
#     bspc node -t tiled
#   fi
# else
#   bspc node -t tiled
# fi
