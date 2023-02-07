EN_ibus="xkb:us::eng"
VN_ibus="Bamboo"
lang=`ibus engine`

if [ $lang = $EN_ibus ]
then
  ibus engine $VN_ibus
  notify-send "Ibus" "Vietnamese" --icon="~/Pictures/flags/vietnam.png" -t 700 -a "System"
fi

if [ $lang = $VN_ibus ]
then
  ibus engine $EN_ibus
  notify-send "Ibus" "English" --icon="~/Pictures/flags/america.png" -t 700 -a "System"
fi
