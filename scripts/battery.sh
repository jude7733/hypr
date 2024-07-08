#!/bin/sh
# Battery status check
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT1/status)
# Battery capacity check
BATTETY_LEVEL=$(cat /sys/class/power_supply/BAT1/capacity)
# Show notifications
if [$BATTERY_STATUS -eq 'Discharging' && $BATTERY_LEVEL -le 15]; then
notify-send -u critical "Battery critical!" "${BATTERY_LEVEL}%"
paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
elif [$BATTERY_STATUS -eq 'Charging' && $BATTERY_LEVEL -eq 100]; then
notify-send -u critical "Battery full!" "${BATTERY_LEVEL}%"
paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
fi 
