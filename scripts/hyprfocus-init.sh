#!/usr/bin/env bash
# Reload hyprpm plugins and tune hyprfocus animation timings
hyprpm reload -n
sleep 0.5
hyprctl eval "hl.animation({ leaf = 'hyprfocusIn', enabled = true, speed = 1.4, bezier = 'quickSnap' }); hl.animation({ leaf = 'hyprfocusOut', enabled = true, speed = 1.0, bezier = 'quickSnap' })"

