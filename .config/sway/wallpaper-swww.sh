#!/bin/bash

DIR=$HOME/Pictures/Wallpaper
PICS=($(ls ${DIR}))

# if [[ $(pidof swww) ]]; then
#   pkill swww
# fi

while true; do
  RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

  notify-send -i ${DIR}/${RANDOMPICS} "Wallpaper Changed" ${RANDOMPICS}

  swww img ${DIR}/${RANDOMPICS} --transition-type random --transition-duration 3.0

  sleep 1800
done