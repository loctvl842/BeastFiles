EN_ibus="BambooUs::Candy"
VN_ibus="Bamboo::Candy"
lang=`ibus engine`

if [[ $lang = $EN_ibus ]]
then
  ibus engine $VN_ibus
  killall dunst
  dunstify "Viet Nam" --icon="~/.local/bin/dunst_icons/flags/vietnam.png" -t 700 -a "System"
elif [[ $lang = $VN_ibus ]]
then
  ibus engine $EN_ibus
  killall dunst
  dunstify "English" --icon="~/.local/bin/dunst_icons/flags/america.png" -t 700 -a "System"
# Default is English
else
  ibus engine $EN_ibus
  killall dunst
  dunstify "English" --icon="~/.local/bin/dunst_icons/flags/america.png" -t 700 -a "System"
fi
