#!/bin/bash

updates=$(yay -Qu | wc -l)

if [ "$updates" -gt 0 ]
then 
    echo "$updates"
    notify-send -u critical -i software-update-available-symbolic "Arch Linux" "$updates_yay Update Available"
else
    echo "0"
fi
