# theme="blurry_full"
# dir="$HOME/.config/rofi/center/launcher"

# comment these lines to disable random style
# themes=($(ls -p --hide="launcher.sh" $dir))
# theme="${themes[$(( $RANDOM % 16 ))]}"

source ~/.config/rofi/source/source.sh
rofi -no-lazy-grab -show drun -modi drun -theme $CENTER_LAUNCHER_APPEARANCE_DIR/full.rasi
