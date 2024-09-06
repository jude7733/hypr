#!/bin/bash

wallpaper="$1"

sleep 1 && echo -e "\nGenerating ${bold}pywal colorscheme from $wallpaper" &&
wal --cols16 -i "$wallpaper" && xrdb -merge ~/.cache/wal/colors.Xresources &

sleep 2 && echo -e "\nSetting colors for ${bold}btop" &&
yes | cp -v ~/.cache/wal/colors-btop.theme ~/.config/btop/themes && pkill btop && 
hyprctl dispatch exec '[workspace 4 silent] kitty --title "btop" -e "btop"' &

sleep 3 && echo -e "\nSetting colors for ${bold}waybar" &&
pkill waybar && waybar &

sleep 3 && echo -e "\nSetting colors for ${bold}cava" &&
killall cava && kitty -c ~/.config/kitty/kittybg.conf --detach --class='kitty-bg' ~/.config/hypr/scripts/cava.sh &

sleep 4 && echo -e "\nSetting colors for ${bold}swaync" &&
killall swaync && swaync &
