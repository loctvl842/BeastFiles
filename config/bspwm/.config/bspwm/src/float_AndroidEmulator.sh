#!/bin/bash

wid=$1
title=$(xtitle "$wid")

if [[ "$title" = "Emulator - "* ]]; then
  echo state=floating
fi

