# # tiled / monocle
# layout=$(bspc query -T -d | jq -r .layout)
# # tiled / fullscreen / floating
# state=$(bspc query -n focused.local -T | jq -r .client.state)
old_state=$(bspc query -n focused.local -T | jq -r .client.lastState)

bspc desktop -l next
bspc node -t tiled
