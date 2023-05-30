# setopt autocd extendedglob nomatch menucomplete
# setopt interactive_comments
# stty stop undef		# Disable ctrl-s to freeze terminal.
#
xset r rate 240 60

wm=$(wmctrl -m | grep Name | grep -oP ': \K\w+')
if [[ $wm = "bspwm" ]]; then
  setxkbmap -option caps:escape
fi
