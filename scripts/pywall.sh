#!/bin/bash

wallpaper="$1"

sleep 2 && wal --cols16 -i "$wallpaper" && xrdb -merge ~/.cache/wal/colors.Xresources &

sleep 3 && pkill waybar && waybar &
