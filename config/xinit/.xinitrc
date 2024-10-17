#!/bin/sh

source $HOME/.config/xinit/xinitrc

dbus-update-activation-environment --all

eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh,gpg)\
export GNOME_KEYRING_CONTROL GNOME_KEYRING_PID\
export SSH_AUTH_SOCK\
