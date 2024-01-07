#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/Pictures/Wallpaper"

# Get a list of all image files in the directory
wallpapers=($WALLPAPER_DIR/*)

while true; do
	# Select a random wallpaper from the list
	random_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"

	# Set the wallpaper using swaymsg command
	swaymsg output "*" bg "$random_wallpaper" fill

	# Sleep for 30 minutes (1800 seconds) before changing the wallpaper again
	sleep 1800
done
