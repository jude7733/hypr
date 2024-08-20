#!/bin/bash

wallpaper="$1"

sleep 2 && wal -i "$wallpaper" &

sleep 3 && pkill waybar && waybar &
