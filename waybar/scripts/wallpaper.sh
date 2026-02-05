#!/bin/bash

DIR=$HOME/Pictures/Wallpaper
PICS=($(ls ${DIR}))

RANDOMPICS=${PICS[ $RANDOM % ${#PICS[@]} ]}

if [[ $(pidof swww) ]]; then
  pkill swww
fi

notify-send -i ${DIR}/${RANDOMPICS} "Wallpaper Changed" ${RANDOMPICS}
#swww img ${DIR}/${RANDOMPICS} --transition-type random --transition-duration 2
swww img ${DIR}/${RANDOMPICS} --transition-type random --transition-fps 60 --transition-duration 3.0 --transition-bezier 0.65,0,0.35,1 --transition-step 255