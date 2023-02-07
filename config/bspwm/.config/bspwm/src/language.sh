EN_ibus="BambooUs::Candy"
VN_ibus="Bamboo::Candy"
lang=`ibus engine`

# check=false
# export $check
# if [ $check == false ]
# then
#   open_ibus_daemon=true
#   ibus-daemon
#   ibus engine $EN_ibus
# fi

if [ $lang = $EN_ibus ]
then
  ibus engine $VN_ibus
	killall dunst
  dunstify "Viet Nam" --icon="~/Pictures/flags/vietnam.png" -t 700 -a "System"
elif [ $lang = $VN_ibus ]
then
  ibus engine $EN_ibus
	killall dunst
  dunstify "English" --icon="~/Pictures/flags/america.png" -t 700 -a "System"
fi
