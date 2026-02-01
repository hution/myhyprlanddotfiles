#!/bin/bash

# Waybar power menu script
choice=$(echo -e "Shutdown\nSuspend" | wofi --dmenu --prompt "Power Menu" --width 200 --height 150)

case "$choice" in
    "Shutdown")
        shutdown now
        ;;
    "Suspend")
        systemctl suspend
        ;;
esac
