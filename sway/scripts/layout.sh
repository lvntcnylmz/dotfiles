#!/usr/bin/env bash
TERM="${TERMINAL:-foot}"
POMO="${HOME}/.config/sway/pomo.sh"

swaymsg workspace 1
sleep 0.3

swaymsg exec "$TERM -e fish -c rusty-rain"
sleep 0.4
swaymsg "split h"
swaymsg exec "$TERM --app-id=btop -e fish -c btop"
sleep 0.4
swaymsg "focus left; split v"
swaymsg exec "$TERM -e fish -c pulsemixer"
sleep 0.4
swaymsg "focus up; split h"
swaymsg exec "$TERM -e fish -c cava"
sleep 0.4
swaymsg "split v"
swaymsg exec "$TERM -e fish -c bigtime"
sleep 0.4
swaymsg "focus right"
swaymsg exec "$TERM -e fish -c $POMO"
sleep 0.4
swaymsg "split h"
swaymsg exec "$TERM --app-id=kew -e fish -c kew"
sleep 0.4
swaymsg "focus up; focus left; focus up; mark swap; focus down; swap container with mark swap"
swaymsg
swaymsg '[app_id=btop] resize set height 75 ppt'
swaymsg '[app_id=kew] resize set width 65 ppt'
