#!/bin/bash

player_status=$(playerctl -p %any status)
player_name=$(playerctl metadata --format "{{playerName}}")


if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ] ; then
    if [ "$player_name" = "spotify" ] ; then
        echo "$(playerctl metadata --format "{{ emoji(status) }} {{ artist }} - {{ title }} - {{ duration(position) }} / {{ duration(mpris:length) }}")"
    else
        echo "$(playerctl metadata --format "{{ emoji(status) }} {{ artist }} - {{ title }}")"
    fi
fi