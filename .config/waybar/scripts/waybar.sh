#!/usr/bin/env bash

while true; do
  # Update display number
  display_number=$(swaymsg -t get_outputs | grep -i name | wc -l)

  # Terminate already running instances of waybar
  pkill -x waybar

  # Wait until the processes have been shut down
  while pgrep -x waybar >/dev/null; do sleep 1; done

  # Launch waybar with the appropriate configuration based on display number
  if [[ $display_number -ge 2 ]]; then
    waybar -c ~/.config/waybar/config-main.jsonc &
  else
    waybar -c ~/.config/waybar/config-second.jsonc &
  fi

  # Sleep for 1800 seconds/30 minutes before checking again
  sleep 1800
done
