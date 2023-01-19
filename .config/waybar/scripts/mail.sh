#!/bin/bash

# Server and mail adress are defined with credentials in ~/.netrc
SERVER="$(head -1 ~/.netrc | awk '{print $2}')"
INBOX=$(curl --netrc -X "STATUS INBOX (UNSEEN)" imaps://$SERVER/INBOX | tr -d -c "[:digit:]")

if [ $INBOX ] && [ $INBOX -gt 0 ] ; then
    if [ $INBOX -eq 1 ] ; then
        echo "<span foreground='#99de1e'><big></big> $INBOX</span>"
        notify-send -i mail-unread-symbolic "Thunderbird" "You have an unread e-mail."
    else
        echo "<span foreground='#99de1e'><big></big> $INBOX</span>" 
        notify-send -i mail-unread-symbolic "Thunderbird" "You have $INBOX unread e-mail."
    fi
fi