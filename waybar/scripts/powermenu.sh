#!/bin/bash

option0="󰐥 Shutdown"
option1="󰜉 Reboot"
option2="󰌾 Lock"
option3="󰍃 Logout"
option4="󰏥 Suspend"

options="$option0\n$option1\n$option2\n$option3\n$option4"

chosen="$(echo -e "$options" | fuzzel --lines 5 --dmenu)"
case $chosen in
    $option0)
        systemctl poweroff;;
    $option1)
        systemctl reboot;;
    $option2)
        swaylock-corrupter;;
    $option3)
        sudo swaymsg exit;;
	$option4)
        systemctl suspend;;
esac