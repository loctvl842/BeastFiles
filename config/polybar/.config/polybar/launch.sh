# Terminate all polybar instances
killall polybar

# If all your bars have ipc enabled, you can also use 
# polybar-msg cmd quit

# Wait for polybar instances to shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 0.2; done

# Wait until the processes have been shut down

shape="Single"

# Determine the window manager
wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')

if [[ $wm == "bspwm" ]]; then
	ADDITIONAL_GAP=0
	BSPWM_CONFIG="$HOME/.config/bspwm/bspwmrc"
  EDP_OUTPUT=$(xrandr --listmonitors | grep -o 'eDP[^ ]*' | head -n 1)
  HDMI_OUTPUT=$(xrandr --listmonitors | grep -o 'HDMI[^ ]*' | head -n 1)

  if [ ! -z "$EDP_OUTPUT" ]; then
    EDP_BAR_SETTINGS="$HOME/.config/polybar/bar-settings.ini"

    bar_height=$(grep -w height $EDP_BAR_SETTINGS | grep -oP 'height = \K\w+')
    border_size=$(grep -w border-size $EDP_BAR_SETTINGS | grep -oP 'border-size = \K\w+')
    bspwm_pb=$(bspc config -m $EDP_OUTPUT bottom_padding | grep -oP '\d+')

    bspwm_pt=`expr $bar_height + $border_size + $bspwm_pb + $ADDITIONAL_GAP`
    sed -i -e "/bspc config -m \$EDP_OUTPUT top_padding/ { s/EDP_OUTPUT.*top_padding .*/EDP_OUTPUT top_padding $bspwm_pt/ }" $BSPWM_CONFIG
    bspc config -m $EDP_OUTPUT top_padding $bspwm_pt
  fi

  if [ ! -z "$HDMI_OUTPUT" ]; then
    HDMI_BAR_SETTINGS="$HOME/.config/polybar/bar-settings-external.ini"

    bar_height=$(grep -w height $HDMI_BAR_SETTINGS | grep -oP 'height = \K\w+')
    border_size=$(grep -w border-size $HDMI_BAR_SETTINGS | grep -oP 'border-size = \K\w+')
    bspwm_pb=$(bspc config -m $HDMI_OUTPUT bottom_padding | grep -oP '\d+')

    bspwm_pt=`expr $bar_height + $border_size + $bspwm_pb + $ADDITIONAL_GAP`
    sed -i -e "/bspc config -m \$HDMI_OUTPUT top_padding/ { s/HDMI_OUTPUT.*top_padding .*/HDMI_OUTPUT top_padding $bspwm_pt/ }" $BSPWM_CONFIG
    bspc config -m $HDMI_OUTPUT top_padding $bspwm_pt
  fi

fi

# launch polybar
~/.config/polybar/$shape/launch.sh

# add tray list
~/.config/polybar/tray.sh

:<< 'COMMENT'
The sample config file of bspwmrc is as follows:

```bspwmrc
bspc config -m $EDP_OUTPUT top_padding 39
bspc config -m $EDP_OUTPUT left_padding 10
bspc config -m $EDP_OUTPUT right_padding 10
bspc config -m $EDP_OUTPUT bottom_padding 10
# This is for the second monitor
bspc config -m $HDMI_OUTPUT top_padding 25
bspc config -m $HDMI_OUTPUT left_padding 8
bspc config -m $HDMI_OUTPUT right_padding 8
bspc config -m $HDMI_OUTPUT bottom_padding 8
```

This script adjusts the top padding of the BSPWM windows manager based on the configuration of connected monitors.
It reads settings from Polybar configuration files to determine the height of the bar, border size, and additional gap,
then calculates the appropriate top padding for each monitor and updates the BSPWM configuration accordingly.
...
COMMENT
