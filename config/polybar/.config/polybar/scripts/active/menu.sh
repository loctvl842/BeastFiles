rofi=$(pgrep -x rofi >/dev/null && echo "Process found" || echo "Process not found")

if [[ $rofi == "Process found" ]]; then
	sed -i -e '0,/label-background\ =.*/s//label-background\ =\ \#FF0000/' ~/.config/polybar/Single-colorful/config.ini
else
	# sed -i -e '0,/label-backgroun# d\ =.*/s//label-background\ =\ \""/' ~/.config/polybar/modules/menu.ini
fi
