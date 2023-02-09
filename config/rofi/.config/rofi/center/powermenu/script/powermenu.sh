# theme="card_rounded"
# dir="$HOME/.config/rofi/center/powermenu"
source ~/.config/rofi/source/source.sh
wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')

# uptime=$(uptime -p | sed -e 's/up //g')

rofi_command="rofi -theme $CENTER_POWERMENU_APPEARANCE_DIR/appearance.rasi"

# Options
shutdown="󰤆"
reboot="󰜉"
lock=""
suspend=""
logout="󰍃"

# Confirmation
# confirm_exit() {
# 	rofi -dmenu\
# 		-i\
# 		-no-fixed-num-lines\
# 		-p "Are You Sure? : "\
# 		-theme $appearance/confirm.rasi
# }

confirm_exit() {
	command=$1
	command_id=$2
	rofi -sep "|" \
			-dmenu -i \
			-theme $CENTER_POWERMENU_APPEARANCE_DIR/confirm-$command_id.rasi \
			<<< "Cancel|$command"
}

# Message
# msg() {
# 	rofi -theme "$appearance/message.rasi" -e "Available Options  -  yes / y / no / n"
# }

# Variable passed to rofi
options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 2)"
case $chosen in
    $shutdown)
			ans=$(confirm_exit "Shut Down" "shutdown")
			if [[ $ans == "Shut Down" ]]; then
				# mplayer ~/.config/rofi/exit.wav
				sleep 0.1
				systemctl poweroff
			elif [[ $ans == "Cancel" ]]; then
				exit 0
			fi
			;;

    $reboot)
			ans=$(confirm_exit "Reboot" "reboot" &)
			if [[ $ans == "Reboot" ]]; then
				# mplayer ~/.config/rofi/exit.wav
				sleep 0.1
				systemctl reboot
			elif [[ $ans == "Cancel" ]]; then
				exit 0
			fi
			;;

    $lock)
			if [[ -f /usr/bin/i3lock ]]; then
				i3lock-fancy-rapid 5 3
			fi
			;;

    $suspend)
			ans=$(confirm_exit "Suspend" "suspend" &)
			if [[ $ans == "Suspend" ]]; then
				# mplayer ~/.config/rofi/exit.wav
				sleep 0.1
				systemctl suspend
			elif [[ $ans == "Cancel" ]]; then
				exit 0
			fi
			;;

    $logout)
			ans=$(confirm_exit "Log Out" "logout" &)
			if [[ $ans == "Log Out" ]]; then
				if [ $wm == "bspwm" ]; then
					# mplayer ~/.config/rofi/exit.wav
					sleep 0.1
					bspc quit
				elif [[ $wm == "i3" ]]; then
					i3-msg exit
				fi
			elif [[ $ans == "Cancel" ]]; then
				exit 0
			fi
			;;
esac
