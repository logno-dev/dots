#!/bin/bash

[ -z "$NAME" ] && exit 1

# Get focused window info: ID | App | Title
LINE=$(aerospace list-windows --focused)

if [ -z "$LINE" ]; then
  sketchybar --set "$NAME" label="No Active Window"
  exit 0
fi

# Parse app and title
APP=$(echo "$LINE" | cut -d'|' -f2 | sed 's/^ *//;s/ *$//')
TITLE=$(echo "$LINE" | cut -d'|' -f3 | sed 's/^ *//;s/ *$//')

# Format: App: Title
FULL="$APP: $TITLE"

# Truncate to 60 characters
FULL=$(echo "$FULL" | cut -c1-60)

sketchybar --set "$NAME" label="$FULL"
