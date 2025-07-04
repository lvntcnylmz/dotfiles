#!/bin/sh

if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
  swaylock --help 2>&1 | sed -e 's/swaylock/swaylock-corrupter/g' -e '/--image/d' 1>&2
else
  DISPLAYS="$(swaymsg -t get_outputs -p | grep "Output" | awk '{print $2}')"
  BASE_FILE="${TMPDIR:-/tmp/ss}"

  for display in $DISPLAYS; do
    FILE="${BASE_FILE}${display}.png"
    grim -o "$display" "$FILE"
    corrupter "$FILE" "$FILE"
    args="$args -i ${display}:${FILE}"
  done

  swaylock $args "$@"
fi
