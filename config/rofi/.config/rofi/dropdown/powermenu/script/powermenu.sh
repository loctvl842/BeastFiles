source ~/.config/rofi/source/source.sh

wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')

rofi_command="rofi -theme $DROPDOWN_POWERMENU_APPEARANCE_DIR/appearance.rasi"

shutdown="  Shut Down"
reboot="  Restart"
lock="  Lock Screen"
suspend="  Suspend"
logout="  Log Out"

options="$shutdown\n$reboot\n$lock\n$suspend\n$logout"

confirm_exit() {
	command=$1
	command_id=$2
	rofi -sep "|" \
			-dmenu -i \
			-theme $CENTER_POWERMENU_APPEARANCE_DIR/confirm-$command_id.rasi \
			<<< "Cancel|$command"
}


chosen="$(echo -e "$options" | $rofi_command -p "$uptime" -dmenu -selected-row 2)"

case $chosen in
    $shutdown)
			ans=$(confirm_exit "Shut Down" "shutdown")
			if [[ $ans == "Shut Down" ]]; then
				mplayer ~/.config/rofi/exit.wav
				sleep 0.1
				systemctl poweroff
			elif [[ $ans == "Cancel" ]]; then
				exit 0
			fi
			;;

    $reboot)
			ans=$(confirm_exit "Reboot" "reboot" &)
			if [[ $ans == "Reboot" ]]; then
				mplayer ~/.config/rofi/exit.wav
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
				mplayer ~/.config/rofi/exit.wav
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
					mplayer ~/.config/rofi/exit.wav
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

# MENU="$(rofi -sep "|" \
#   -dmenu -i -p 'System' \
#   -theme $DROPDOWN_POWERMENU_APPEARANCE_DIR/appearance.rasi \
#   <<< "   Shutdown|   Reboot|   Lockscreen|   Suspend|   Logout")"
# # MENU="$(rofi -sep "|" -dmenu -i -p 'System' -width 10 -hide-scrollbar -line-padding 4 -padding 20 -lines 4 <<< " Lock| Logout| Reboot| Shutdown")"
#   case "$MENU" in
#       *Shutdown) systemctl poweroff;;
#       *Reboot) systemctl reboot;;
#       *Lockscreen) i3lock-fancy-rapid 5 3 ;;
#       *Suspend) systemctl suspend;;
#       *Logout) i3-msg exit || bspc quit;;
#   esac
