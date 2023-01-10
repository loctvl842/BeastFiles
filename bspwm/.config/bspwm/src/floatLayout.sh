dunstify $1
#!/bin/bash

 # change the desktop number here
 FLOATING_DESKTOP_ID=$(bspc query -D -d '^3')

 bspc subscribe node_add | while read -a msg ; do
    desk_id=${msg[2]}
    wid=${msg[4]}
    [ "$FLOATING_DESKTOP_ID" = "$desk_id" ] && bspc node "$wid" -t floating
 done
