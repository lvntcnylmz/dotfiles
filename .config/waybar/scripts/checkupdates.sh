#!/bin/bash

updates=$(yay -Qu | wc -l)

if [ "$updates" -gt 0 ]
then 
    echo "$updates"
    notify-send -i software-update-available-symbolic "Arch Linux" "$updates Updated Available"
else
    echo "0"
fi
