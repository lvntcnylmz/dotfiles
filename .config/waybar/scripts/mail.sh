#!/usr/bin/env bash

text=$(curl -s "https://wttr.in/$1?format=%c+%f+%m")

if [[ $? == 0 ]]
then
    text=$(echo "$text" | sed -E "s/\s+/ /g")
    tooltip=$(curl -s "https://wttr.in/$1?format=%l:+%C+%c+%t+%w+%m")
    if [[ $? == 0 ]]
    then
        tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
        echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
        exit
    fi
fi

echo "{\"text\":\"Service Unavailable\", \"tooltip\":\"Service Unavailable\"}"