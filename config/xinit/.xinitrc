#!/bin/sh


xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto
xrandr --dpi 96
source $HOME/.config/xinit/xinitrc
