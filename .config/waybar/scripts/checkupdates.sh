#!/bin/bash

updates_yay=$(yay -Qu --aur 2> /dev/null | wc -l)
updates_pacman=$(checkupdates 2> /dev/null | wc -l)

updates=$((updates_pacman + updates_yay))

if [ "$updates" -gt 0 ]
then 
    echo "$updates"
    notify-send -u normal -i software-update-available-symbolic "Arch Linux" "$updates Update/s Available"
else
    echo "0"
fi