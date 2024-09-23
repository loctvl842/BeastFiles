# setopt autocd extendedglob nomatch menucomplete
# setopt interactive_comments
# stty stop undef		# Disable ctrl-s to freeze terminal.
#
# setxkbmap -option caps:escape
set_xset_rate() {
  # Check if X is running
  if [ "$DISPLAY" ]; then
    xset r rate 240 60
  fi
}

# Run the function after startx or after re-plugging the keyboard
set_xset_rate

wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')
if [[ $wm = "bspwm" ]]; then
  setxkbmap -option caps:escape
fi
