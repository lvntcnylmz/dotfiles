#!/bin/bash

updates_yay=$(yay -Qu --aur 2> /dev/null | wc -l)
updates_pacman=$(checkupdates 2> /dev/null | wc -l)
updates=$((updates_pacman + updates_yay))

if [ "$updates" -gt 0 ]; then
    if [ "$updates_yay" -eq 1 ]; then
        echo "<big></big> $updates"
        notify-send -u normal -i software-update-available-symbolic "$updates_yay update available from AUR" "$(yay -Qu --aur)"
    fi 
    if [ "$updates_pacman" -eq 1 ]; then
        echo "<big></big> $updates"
        notify-send -u normal -i software-update-available-symbolic "$updates_pacman update available from pacman" "$(checkupdates)"
    fi
    if [ "$updates_yay" -gt 1 ]; then
        echo "<big></big> $updates"
        notify-send -u normal -i software-update-available-symbolic "$updates_yay updates available from AUR" "$(yay -Qu --aur)"
    fi 
    if [ "$updates_pacman" -gt 1 ]; then
        echo "<big></big> $updates"
        notify-send -u normal -i software-update-available-symbolic "$updates_pacman updates available from pacman" "$(checkupdates)"
    fi 
fi