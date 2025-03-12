#!/bin/sh
# Battery status check
BATTERY_STATUS=$(cat /sys/class/power_supply/BAT0/status)
# Battery capacity check
BATTERY_LEVEL=$(cat /sys/class/power_supply/BAT0/capacity)
# Show notifications
if [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" -le 20 ]; then
    notify-send -u critical "Battery critical!" "${BATTERY_LEVEL}%"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
elif [ "$BATTERY_STATUS" = "Discharging" ] && [ "$BATTERY_LEVEL" -le 40 ]; then
    notify-send -u normal "Time to charge!" "${BATTERY_LEVEL}%"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-information.oga
elif [ "$BATTERY_STATUS" = "Charging" ] && [ "$BATTERY_LEVEL" -eq 79 ]; then
    notify-send -u critical "Battery full!" "${BATTERY_LEVEL}%"
    paplay /usr/share/sounds/freedesktop/stereo/dialog-warning.oga
fi
