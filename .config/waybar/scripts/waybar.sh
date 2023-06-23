#!/usr/bin/env sh

# Terminate already running instances
killall -q waybar

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Launch main
waybar