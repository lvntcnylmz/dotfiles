#!/bin/bash

player_status=$(playerctl --player=spotify,firefox status)
player_name=$(playerctl metadata --format "{{ playerName }}")
song=$(playerctl metadata --format "{{ artist }}\n{{ title }}\n{{ album }}")

firefox_status=$(playerctl --player=firefox status)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]
then
    if [ "$player_name" = "spotify" ] || [ "$firefox_status" = "Paused" ]
    then
        echo "$(playerctl -p spotify metadata --format "{{ emoji(status) }} {{ artist }} - {{ title }} - {{ duration(position) }} / {{ duration(mpris:length) }}")"
    else
        echo "$(playerctl metadata --format "{{ emoji(status) }} {{ artist }} - {{ title }}")"
    fi
fi