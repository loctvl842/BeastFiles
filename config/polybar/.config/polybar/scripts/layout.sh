layout=$(bspc query -T -d | jq -r .layout)
if [[ $layout == "tiled" ]]; then
	echo ""
else
	echo ""
fi
