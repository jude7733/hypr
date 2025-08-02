#!/bin/bash

# Screenshot options
options="Region\nWindow\nOutput"

# Show menu
choice=$(echo -e "$options" | wofi --dmenu --prompt "Screenshot:")

case $choice in
"Region")
  mode="region"
  ;;
"Window")
  mode="window"
  ;;
"Output")
  mode="output"
  ;;
*)
  exit 0
  ;;
esac

# Take screenshot
hyprshot -m "$mode"
sleep 2

# Get file and share logic (same as above)
screenshot_dir="$HOME/Pictures/Screenshots"
file=$(ls -t "$screenshot_dir" 2>/dev/null | head -n1)

if [ -n "$file" ]; then
  # Ask if user wants to share
  share_choice=$(echo -e "Yes\nNo" | wofi --dmenu --prompt "Share screenshot?")

  if [ "$share_choice" = "Yes" ]; then
    device=$(kdeconnect-cli --list-available --name-only 2>/dev/null | grep -v "This device" | head -n1)

    if [ -n "$device" ]; then
      kdeconnect-cli -n "$device" --share "$screenshot_dir/$file"
      notify-send "Screenshot shared" "Sent to $device"
    else
      notify-send "KDE Connect" "No devices available"
    fi
  fi
fi
