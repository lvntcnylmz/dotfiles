#!/usr/bin/env bash

location1="Luleburgaz"
location2="Istanbul"

for i in {1..5}
do
    text=$(curl -s "https://wttr.in/$location1?format=1")

    if [[ $? == 0 ]]
    then
        text=$(echo "$text" | sed -E "s/\s+/ /g")
        tooltip="$(curl -s "https://wttr.in/$location1?format=%l:+%C+%c+"Actual:"+%t+"Feels:"+%f+%w+%m+%h")\n"
        tooltip+="$(curl -s "https://wttr.in/$location2%20%20?format=%l:+%C+%c+"Actual:"+%t+"Feels:"+%f+%w+%m+%h")"
        if [[ $? == 0 ]]
        then
            tooltip=$(echo "$tooltip")
            echo "{\"text\":\"$text\", \"tooltip\":\"$tooltip\"}"
            exit
        fi
    fi
    sleep 2
done

echo "{\"text\":\"Service Unavailable\", \"tooltip\":\"Service Unavailable\"}"
