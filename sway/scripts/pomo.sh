#!/usr/bin/env bash
# pomodoro.sh — KISS TUI Pomodoro

FOCUS=25
SHORT=5
LONG=15

RED='\033[0;31m'
GRN='\033[0;32m'
YLW='\033[0;33m'
CYN='\033[0;36m'
BLD='\033[1m'
RST='\033[0m'

session=0
mode="FOCUS"
mins=$FOCUS

beep() { printf '\a'; }

notify() {
  local title="$1" msg="$2"
  if command -v osascript &>/dev/null; then
    osascript -e "display notification \"$msg\" with title \"$title\"" 2>/dev/null &
  elif command -v notify-send &>/dev/null; then
    notify-send "$title" "$msg" 2>/dev/null &
  elif command -v termux-notification &>/dev/null; then
    termux-notification --title "$title" --content "$msg" 2>/dev/null &
  fi
}

draw() {
  local m=$1 s=$2 elapsed=$3 total=$4 status=$5
  local color label
  case $mode in
  FOCUS)
    color=$GRN
    label="FOCUS"
    ;;
  SHORT_BREAK)
    color=$CYN
    label="SHORT BREAK"
    ;;
  LONG_BREAK)
    color=$YLW
    label="LONG BREAK"
    ;;
  esac

  local filled=$((session % 4 == 0 ? 4 : session % 4))
  local dots=""
  for i in 1 2 3 4; do
    [ $i -le $filled ] && dots+="●" || dots+="○"
    [ $i -lt 4 ] && dots+=" "
  done

  local gauge_width=24
  local filled_w=$((elapsed * gauge_width / (total > 0 ? total : 1)))
  local gauge="" i=0
  while [ $i -lt $filled_w ]; do
    gauge+="█"
    i=$((i + 1))
  done
  while [ $i -lt $gauge_width ]; do
    gauge+="░"
    i=$((i + 1))
  done
  local pct=$((elapsed * 100 / (total > 0 ? total : 1)))

  local time_str
  printf -v time_str "%02d:%02d" "$m" "$s"
  local spaces=$((gauge_width - ${#pct} - 6))
  [ $spaces -lt 1 ] && spaces=1
  local pad
  printf -v pad "%${spaces}s" ""

  local hint
  case $status in
  waiting) hint="${YLW}space${RST} start   ${CYN}s${RST} skip   ${RED}q${RST} quit" ;;
  paused) hint="${YLW}space${RST} resume  ${CYN}s${RST} skip   ${RED}q${RST} quit" ;;
  *) hint="${YLW}space${RST} pause   ${CYN}s${RST} skip   ${RED}q${RST} quit" ;;
  esac

  printf "\033[H\033[2J"
  echo ""
  printf "  ${BLD}${color}▶ POMODORO${RST}\n"
  echo ""
  printf "  Mode     : ${color}${label}${RST}\n"
  printf "  Session  : %02d  [%s]\n" "$session" "$dots"
  echo ""
  printf "  ${BLD}${color}%s${RST}%s%d%%\n" "$time_str" "$pad" "$pct"
  printf "  ${color}%s${RST}\n" "$gauge"
  echo ""
  printf "  %b\n" "$hint"
}

readkey() {
  local key
  IFS= read -r -s -n 1 -t 1 key 2>/dev/null
  printf '%s' "$key"
}

# returns 0=done, 1=skipped
run_timer() {
  local total=$((mins * 60))
  local elapsed=0
  local paused=true

  while true; do
    local remaining=$((total - elapsed))
    local m=$((remaining / 60))
    local s=$((remaining % 60))

    local status
    if $paused; then
      [ $elapsed -eq 0 ] && status="waiting" || status="paused"
    else
      status="running"
    fi

    draw "$m" "$s" "$elapsed" "$total" "$status"

    local key
    key=$(readkey)

    case "$key" in
    q | Q)
      stty "$STTY_SAVE"
      tput cnorm
      printf "\n"
      exit 0
      ;;
    s | S)
      return 1
      ;;
    $' ')
      $paused && paused=false || paused=true
      continue
      ;;
    esac

    $paused && continue

    elapsed=$((elapsed + 1))
    [ $elapsed -ge $total ] && break
  done

  beep
  case $mode in
  FOCUS) notify "Pomodoro" "Focus done! Take a break." ;;
  SHORT_BREAK) notify "Pomodoro" "Break over. Back to work!" ;;
  LONG_BREAK) notify "Pomodoro" "Long break done. Let's go!" ;;
  esac
  return 0
}

STTY_SAVE=$(stty -g)
trap 'stty "$STTY_SAVE"; tput cnorm; printf "\n"; exit 0' INT TERM
stty -echo -icanon
tput civis

while true; do
  session=$((session + 1))
  mode="FOCUS"
  mins=$FOCUS
  run_timer

  if ((session % 4 == 0)); then
    mode="LONG_BREAK"
    mins=$LONG
  else
    mode="SHORT_BREAK"
    mins=$SHORT
  fi
  run_timer
done
