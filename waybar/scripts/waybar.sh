#!/bin/bash
# Wait until Sway is ready
# until swaymsg -t get_outputs &>/dev/null; do sleep 0.5; done
#
# # Function to (re)start Waybar based on connected displays
# restart_waybar() {
#   # Kill existing Waybar
#   pkill -x waybar
#   while pgrep -x waybar >/dev/null; do sleep 0.5; done
#
#   # Count active outputs
#   DISPLAY_NUMBER=$(swaymsg -t get_outputs | jq -r '.[] | select(.active) | .name' | wc -l)
#
#   # Launch appropriate config
#   if [[ $DISPLAY_NUMBER -ge 2 ]]; then
#     notify-send -u normal -i settings "External monitor detected." "Loading external config."
#     waybar -c "$HOME/.config/waybar/config-main.jsonc"
#   else
#     notify-send -u normal -i settings "Only laptop screen detected." "Loading laptop config."
#     waybar -c "$HOME/.config/waybar/config-second.jsonc"
#   fi
# }
#
# # Initial launch
# restart_waybar
#
# # Listen for output changes and restart Waybar accordingly
# swaymsg -t subscribe '["output"]' | while read -r _; do
#   restart_waybar
# done

# Check for an existing process
if pgrep -x "waybar" >/dev/null; then
  killall waybar
fi
