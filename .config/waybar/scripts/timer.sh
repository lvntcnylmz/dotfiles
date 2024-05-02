#!/usr/bin/env bash

cmd="$1"

TFILE="$HOME/.config/waybar/timer"
TIME_ZONE="Europe/Istanbul"

if [ "$cmd" == "check" ]; then

    DATE_TIME_NOW=$(dateconv --zone "$TIME_ZONE" now -f "%Y-%m-%d %H:%M:%S")

    # Strip file content
    DATE_TIME_TARGET_STR=$(tr -d '\r' < "$TFILE")

    # Make an array by splitting DATE_TIME_TARGET_STR by "|"
    readarray -d "|" -t DATE_TIME_TARGET_ARR < <(printf '%s' "$DATE_TIME_TARGET_STR")

    # Fetch first element, which is timer end date
    DATE_TIME_TARGET="${DATE_TIME_TARGET_ARR[0]}"
    DATE_TIME_TARGET=$(echo "$DATE_TIME_TARGET" | tr -d '\r')

    # Fetch second element, which is a timer title
    DATE_TIME_TARGET_TITLE="${DATE_TIME_TARGET_ARR[1]}"

    if [ "$DATE_TIME_TARGET" == "READY" ]; then
        echo '{"text": "'"<big>󰔛</big>"'", "tooltip": "Timer is not active"}'

    elif [ "$DATE_TIME_TARGET" == "FINISHED" ]; then
        echo "READY" > "$TFILE"
        # zenity --info --no-wrap --text="Timer expired!"
        notify-send -i /usr/share/icons/kora/status/symbolic/timer-symbolic.svg "Timer Finished" "Your timer has finished."
        paplay /usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga
        echo '{"text": "'"<big>󰔛</big>"'"}'

    elif datetest "$DATE_TIME_TARGET" --gt "$DATE_TIME_NOW"; then
        REMAINING=$(datediff now "${DATE_TIME_TARGET}" -f '%dd %0H:%0M:%0S' --from-zone="$TIME_ZONE")

        # Remove seconds
        DATE_TIME_TARGET_SHORT="${DATE_TIME_TARGET::-3}"

        echo '{"text": "'"<big>󰔟</big> $REMAINING"'", "class": "active", "tooltip": "'"$DATE_TIME_TARGET_TITLE\n\n$DATE_TIME_TARGET_SHORT"'"}'
    else
        if [ -f "$TFILE" ]; then
            echo "FINISHED" > "$TFILE"
        else
            echo "READY" > "$TFILE"
        fi
        echo '{"text": "'"<big>󰔛</big>"'"}'
    fi

elif [ "$cmd" == "minute_dialog" ]; then

    TIMER_TARGET=$(zenity --scale --title "Set timer" --text "In x minutes:" --min-value=1 --max-value=600 --step=1 --value=10)
    if [ "$?" = 0 ] ; then
        DATE_TIME_TARGET_STR=$(dateadd --format '%Y-%m-%d %H:%M:%S' now +"${TIMER_TARGET}"m --zone "$TIME_ZONE")
        echo "$DATE_TIME_TARGET_STR|Timer" > "$TFILE"
    fi

elif [ "$cmd" == "datetime_dialog" ]; then

    TIMER_TARGET=$(zenity --forms --text="" --title="Set timer" --add-entry="Title:" --add-entry="Hours:" --add-entry="Minutes:" --add-calendar="Date" --forms-date-format="%Y-%m-%d")

    if [ "$?" = 0 ] ; then
        readarray -d "|" -t TIMEOUT_ARR < <(printf '%s' "$TIMER_TARGET")

        TITLE="${TIMEOUT_ARR[0]}"
        HOURS="${TIMEOUT_ARR[1]}"
        MINUTES="${TIMEOUT_ARR[2]}"
        DATE="${TIMEOUT_ARR[3]}"

        # Replace " with '
        TITLE=$(echo -n "$TITLE" | tr \" \')

        if [ -z "$HOURS" ] || [ -z "$MINUTES" ]; then
            zenity --error --no-wrap --text="Please enter hours and minutes!"
            exit 1
        fi

        if ((HOURS < 0 || HOURS > 23 || MINUTES < 0 || MINUTES > 59)); then
            zenity --error --no-wrap --text="Invalid hour or minute number(s)!"
            exit 1
        fi

        echo "$DATE $HOURS:$MINUTES:00|$TITLE" > "$TFILE"
    fi

elif [ "$cmd" == "stop" ]; then

    echo READY > "$TFILE"

fi
