#!/bin/sh
# personalmail and workmail are defined in /etc/hosts with credentials in ~/.netrc
personal_mail="$(curl -sfnX "STATUS INBOX (UNSEEN)" imap://lvntcnylmz%40hotmail.com@outlook.office365.com | tr -dc "[:digit:]")"

is_int () {
    [ "$1" -ge 0 ] 2> /dev/null
}

if is_int "$PERSONAL" 
then
    count="$(echo "$personal_mail" | bc)"
    if [ "$count" -eq 0 ] 
    then
        echo " 0"
    else
        echo "$count" ; notify-send 'You have e-mail'
    fi
else
    echo " ?"
fi