# #!/bin/sh

# set class $(platerctl metadata --player=spotify --format '{{lc(status)}}')
# set icon ""

# if $class == "playing" ; then
#   set info $(playerctl metadata --player=spotify --format '{{artist}} - {{title}}')
#   if $info > 40 ; then
#     set info $(echo $info | cut -c1-40)"..."
#   fi
#   set text $info" "$icon
#   elif $class == "paused" ; then
#   set text $icon
#   elif $class == "stopped" ; then
#   set text ""
# fi

# echo -e "{\"text\":\""$text"\", \"class\":\""$class"\"}"

#!/bin/sh
player_status=$(playerctl status 2> /dev/null)
if [ "$player_status" = "Playing" ]; then
    echo "$(playerctl metadata artist) - $(playerctl metadata title)"
elif [ "$player_status" = "Paused" ]; then
    echo " $(playerctl metadata artist) - $(playerctl metadata title)"
fi