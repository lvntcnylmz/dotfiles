#!/bin/bash

PATH_AC="$(cat /sys/class/power_supply/AC/online)"
PATH_BATTERY_BAT0="/sys/class/power_supply/BAT0"
PATH_BATTERY_BAT1="/sys/class/power_supply/BAT1"

battery_level_0=0
battery_level_1=0
battery_max_0=0
battery_max_1=0

if [ -f "$PATH_BATTERY_BAT0/energy_now" ]; then
    battery_level_0=$(cat "$PATH_BATTERY_BAT0/energy_now")
fi

if [ -f "$PATH_BATTERY_BAT0/energy_full" ]; then
    battery_max_0=$(cat "$PATH_BATTERY_BAT0/energy_full")
fi

if [ -f "$PATH_BATTERY_BAT1/energy_now" ]; then
    battery_level_1=$(cat "$PATH_BATTERY_BAT1/energy_now")
fi

if [ -f "$PATH_BATTERY_BAT1/energy_full" ]; then
    battery_max_1=$(cat "$PATH_BATTERY_BAT1/energy_full")
fi

battery_level=$(("$battery_level_0 + $battery_level_1"))
battery_max=$(("$battery_max_0 + $battery_max_1"))

battery_percent=$(("$battery_level * 100"))
battery_percent=$(("$battery_percent / $battery_max"))

if [ $battery_percent -le 10 ] && [ $PATH_AC -eq 0 ]
then 
    notify-send -u critical -i battery-level-10-symbolic "Arch Linux" "$battery_percent battery left."
fi