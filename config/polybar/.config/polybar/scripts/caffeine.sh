#!/bin/bash
# This is going to act as a caffeine applet
echo "Enter time in minutes: "
read limit
((limit *= 60)) 
#echo $limit
begin=$SECONDS
#echo $begin
end=$((limit+begin))
#echo $end
tres=0
#echo $tres
while [ "$SECONDS" -lt "$end" ];do 
	tres=$((SECONDS-begin))
	((tres %= 600))
	#echo $tres
	#xdotool click 1
	if ((tres == 0)); then
		xdotool click 1 
	fi
	sleep 0.8
done
