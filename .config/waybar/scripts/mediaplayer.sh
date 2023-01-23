#!/bin/bash

player_status=$(playerctl --player=spotify,firefox status)
player_name=$(playerctl metadata --format "{{ playerName }}")
spotify_title=$(playerctl -p spotify metadata --format "<big></big> {{ artist }} - {{ title }} [{{ duration(position) }} / {{ duration(mpris:length) }}]")
firefox_title=$(playerctl metadata --format "<big></big> {{ artist }} - {{ title }}")
firefox_status=$(playerctl --player=firefox status)

if [ "$player_status" = "Playing" ] || [ "$player_status" = "Paused" ]; then
    if [ "$player_name" = "spotify" ] || [ "$firefox_status" = "Paused" ]; then
        echo "$spotify_title"
    else
        echo "$firefox_title"
    fi
fi