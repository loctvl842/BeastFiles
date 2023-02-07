declare a cmds=('cbatticon -u 1 -i standard -l 20 -o "brillo -S 20"' 'nm-applet' 'blueman-applet' 'pa-applet' 'mictray')


for (( i = 0; i < ${#cmds[@]} ; i++ )); do
    process=$(echo ${cmds[$i - 0]} | cut -d' ' -f1)
  eval "killall $process"
done

interval=0.75

sleep $interval
for (( i = 0; i < ${#cmds[@]} ; i++ )); do
    # Run each command in cmdsay 
    process=$(echo ${cmds[$i - 1]} | cut -d' ' -f1)
    preProcess=$(pgrep -x $process > /dev/null && echo "Process found" || echo "Process not found")
    sleep $interval
    if [ $i == 0 ] || [[ $preProcess == "Process found" ]]; then
      eval "${cmds[$i]} &"
      echo "Executed ${cmds[$i]}"
    fi
done
