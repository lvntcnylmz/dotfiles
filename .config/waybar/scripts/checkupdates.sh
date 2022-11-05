#!/bin/bash

updates_yay=$(yay -Qu --aur 2> /dev/null | wc -l)
updates_pacman=$(checkupdates 2> /dev/null | wc -l)
updates=$((updates_pacman + updates_yay))

if [ "$updates" -gt 0 ]; then
    if [ "$updates_yay" -eq 1 ]; then
        echo "<span foreground='#ff6600'><big></big> $updates</span>"
        notify-send -u normal -i software-update-available-symbolic "Arch Linux" "$updates_yay update available from AUR"
    fi 
    if [ "$updates_pacman" -eq 1 ]; then
        echo "<span foreground='#ff6600'><big></big> $updates</span>"
        notify-send -u normal -i software-update-available-symbolic "Arch Linux" "$updates_pacman update available from pacman"
    fi
    if [ "$updates_yay" -gt 1 ]; then
        echo "<span foreground='#ff6600'><big></big> $updates</span>"
        notify-send -u normal -i software-update-available-symbolic "Arch Linux" "$updates_yay updates available from AUR"
    fi 
    if [ "$updates_pacman" -gt 1 ]; then
        echo "<span foreground='#ff6600'><big></big> $updates</span>"
        notify-send -u normal -i software-update-available-symbolic "Arch Linux" "$updates_pacman updates available from pacman"
    fi 
else
    echo "<big></big> 0"
fi