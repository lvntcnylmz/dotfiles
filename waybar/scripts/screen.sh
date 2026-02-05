#!/bin/bash

# Define the Waybar configuration file
waybar_config_file="$HOME/.config/waybar/config.jsonc"

# Check if an external screen is connected
external_screen_connected=$(swaymsg -t get_outputs | jq 'map(select(.name != "eDP-1")) | length')

if [ "$external_screen_connected" -gt 0 ]; then
  # External screen is connected, modify the Waybar config to show on external screen
  sed -i 's/\("output": "eDP-1"\)/"output": "DP-3"/g' "$waybar_config_file"
else
  # No external screen, modify the Waybar config to show on the laptop screen
  sed -i 's/\("output": "DP-3"\)/"output": "eDP-1"/g' "$waybar_config_file"
fi

# Restart Waybar to apply the changes
pkill -x waybar
waybar &

echo "Waybar configuration updated based on external screen connectivity."
