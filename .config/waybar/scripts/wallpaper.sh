#!/bin/bash

RANDOM_WP=$(ls ~/Pictures/Wallpaper/ | shuf -n 1)
NEW_WP="~/Pictures/Wallpaper/"$RANDOM_WP
swaymsg -s $SWAYSOCK output eDP-1 bg $NEW_WP fill
swaymsg -s $SWAYSOCK output DP-3 bg $NEW_WP fill