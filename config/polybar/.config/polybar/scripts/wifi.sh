#!/bin/sh
cmd=`nmcli radio wifi`

if [ $cmd == "enabled" ]
then
	# $cmdOff
  echo  
else
	# $cmdOn
  echo 睊
fi
