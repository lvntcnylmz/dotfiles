# #!/bin/bash

# updates_yay=$(paru -Qu --aur 2> /dev/null | wc -l)
# updates_pacman=$(checkupdates 2> /dev/null | wc -l)
# updates=$((updates_pacman + updates_yay))

# if [ "$updates" -gt 0 ]; then
#     if [ "$updates_yay" -eq 1 ]; then
#         echo "<big></big> $updates (AUR)"
#         notify-send -u normal -i software-update-available-symbolic "$updates_yay update available from AUR" "$(paru -Qu --aur)"
#     fi 
#     if [ "$updates_pacman" -eq 1 ]; then
#         echo "<big></big> $updates (pacman)"
#         notify-send -u normal -i software-update-available-symbolic "$updates_pacman update available from pacman" "$(checkupdates)"
#     fi
#     if [ "$updates_yay" -gt 1 ]; then
#         echo "<big></big> $updates (AUR)"
#         notify-send -u normal -i software-update-available-symbolic "$updates_yay updates available from AUR" "$(paru -Qu --aur)"
#     fi 
#     if [ "$updates_pacman" -gt 1 ]; then
#         echo "<big></big> $updates (pacman)"
#         notify-send -u normal -i software-update-available-symbolic "$updates_pacman updates available from pacman" "$(checkupdates)"
#     fi 
# else 
#     echo ""
# fi


#!/usr/bin/env bash

check() {
	command -v "$1" 1>/dev/null
}

notify() {
	check notify-send && {
		notify-send "$@"
		return
	}
	echo "$@"
}

stringToLen() {
	STRING="$1"
	LEN="$2"
	if [ ${#STRING} -gt "$LEN" ]; then
		echo "${STRING:0:$((LEN - 2))}.."
	else
		printf "%-20s" "$STRING"
	fi
}

check checkupdates-with-aur || {
	cat <<EOF
  {"text":"ERR","tooltip":"checkupdates-with-aur is not installed"}
EOF
	exit 1
}
IFS=$'\n'$'\r'

killall -q checkupdates-with-aur
mapfile -t updates < <(checkupdates-with-aur)

text=${#updates[@]}
# tooltip="<b>$text  updates (arch+aur) </b>\n"
tooltip+=" $(stringToLen "Package Name" 20) $(stringToLen "\tPrevious Version" 20) $(stringToLen "\tNext Version" 20)\n"
[ "$text" -eq 0 ] && text="" || text+=" <big></big>"

for i in "${updates[@]}"; do
  # shellcheck disable=2046
	update=" $(stringToLen $(echo "$i" | awk '{print $1}') 20)"
  # shellcheck disable=2046
	prev="$(stringToLen $(echo "$i" | awk '{print $2}') 20)"
  # shellcheck disable=2046
	next="$(stringToLen $(echo "$i" | awk '{print $4}') 20)" # skipping '->' string
	tooltip+="$update \t$prev \t$next\n"
done
tooltip=${tooltip::-2}

cat <<EOF
{"text":"$text", "tooltip":"$tooltip"}  
EOF