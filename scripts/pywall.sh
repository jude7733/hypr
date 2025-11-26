#!/bin/bash

wallpaper="$1"

sleep 1.1 && echo -e "\nGenerating pywal colorscheme from $wallpaper" &&
  wal --cols16 -n -i "$wallpaper" && xrdb -merge ~/.cache/wal/colors.Xresources &

# sleep 3 && echo -e "\nSetting colors for ${bold}btop" && pkill btop &&
#   hyprctl dispatch exec '[workspace 4 silent] kitty --title "btop" -e "btop"' &

# sleep 4 && echo -e "\nSetting colors for ${bold}cava" &&
#   killall cava && kitty -c ~/.config/kitty/kittybg.conf --detach --class='kitty-bg' ~/.config/hypr/scripts/cava.sh &

sleep 2 && hyprctl reload

pgrep -x "waybar" >/dev/null || waybar &
