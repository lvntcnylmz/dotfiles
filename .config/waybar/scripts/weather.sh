#!/usr/bin/env bash

for i in {1..5}
do
    text=$(curl -s "https://wttr.in/$1?format=1")

    if [[ $? == 0 ]]
    then
        text=$(echo "$text" | sed -E "s/\s+/ /g")
        tooltip="$(curl -s "https://wttr.in/$1?format=%l:+%C+%c+"Actual:"+%t+"Feels:"+%f+%w+%m+%h")\n"
        tooltip+="$(curl -s "https://wttr.in/$2?format=%l:+%C+%c+"Actual:"+%t+"Feels:"+%f+%w+%m+%h")"
        if [[ $? == 0 ]]
        then
            tooltip=$(echo "$tooltip" | sed -E "s/\s+/ /g")
            echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
            exit
        fi
    fi
    sleep 2
done

echo "{\"text\":\"Service Unavailable\", \"tooltip\":\"Service Unavailable\"}"