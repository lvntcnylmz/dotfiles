#!/usr/bin/env bash

checkupdates-with-aur() {
	checkupdates &
	pacman -Qm | aur vercmp &
	wait
}

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
  {"text":"<span color='#f7768e' font-size='x-large'></span>","tooltip":"pacman-contrib or aurutils is not installed"}
EOF
	exit 1
}
IFS=$'\n'$'\r'

killall -q checkupdates-with-aur
mapfile -t updates < <(checkupdates-with-aur)

text=${#updates[@]}

tooltip+=" $(stringToLen "Package Name" 20) $(stringToLen "\tPrevious Version" 20) $(stringToLen "\tNext Version" 20)\n"
[ "$text" -eq 0 ] && text="" || text="<sup>$text</sup>"

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

if [ "${#updates[@]}" -gt 0 ]; then
	notify-send -u normal -i software-update-available-symbolic "${#updates[@]} update(s) available" "${updates[*]}"
fi

cat <<EOF
{"text":"$text", "tooltip":"$tooltip"}  
EOF
