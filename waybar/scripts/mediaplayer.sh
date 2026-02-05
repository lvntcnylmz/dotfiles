#!/bin/bash

player_status=$(playerctl status)
player_name=$(playerctl metadata --format "{{ playerName }}")

artist=$(playerctl metadata --format "{{ artist }}")
title=$(playerctl metadata --format "{{ title }}")
duration=$(playerctl metadata --format "{{ duration(position) }}--{{ duration(mpris:length) }}")

firefox_status=$(playerctl --player=firefox status)
spotify_status=$(playerctl --player=spotify status)


if [ "$player_name" == "spotify" ]; then
    echo "<span color='#0fc044'><big>󰓇</big></span> $artist - $title [$duration]"
else [ "$player_name" == "firefox" ] 
    if [ "$artist" == "" ]; then
        echo "<span color='#FF9500'><big>󰈹</big></span> $title"
    else
        echo "<span color='#FF9500'><big>󰈹</big></span> $artist"
    fi
fi