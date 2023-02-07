ischarging=$(upower -i $(upower -e | grep BAT) | grep --color=never -E "state|to\ full|to\ empty|percentage" | grep -oP 'state: \s+\K[^ ]+')
if [ $ischarging == 'charging' ]; then
  exit 0
fi

current_battery_percentage=$(upower -i $(upower -e | grep BAT) | grep --color=never -E percentage|xargs|cut -d' ' -f2|sed s/%//)

if [ $current_battery_percentage -le 20 ]
then
  notify-send "Battery low!" "Sạc pin dùm cái, Lộc!" --icon="~/Pictures/battery/images.png" -t 60000 -a "System"
# elif [ $current_battery_percentage -eq 100 ]
# then
#     if [ $checkNotifyFullBattery==false ]
#     then
#         notify-send "Battery full" --icon="~/Pictures/battery/batteryFull.jpeg" -t 2000 -a "System"
#         checkNotifyFullBattery=true;
#     fi
fi
