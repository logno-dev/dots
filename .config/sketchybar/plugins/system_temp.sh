#!/usr/bin/env sh

# Try to get CPU temperature using powermetrics (requires sudo setup) or sensors
if command -v osx-cpu-temp >/dev/null 2>&1; then
    TEMP=$(osx-cpu-temp | sed 's/°C//')
    sketchybar --set $NAME label="${TEMP}°C"
elif command -v istats >/dev/null 2>&1; then
    TEMP=$(istats cpu temp --value-only | sed 's/°C//')
    sketchybar --set $NAME label="${TEMP}°C"
else
    # Fallback - show that temp monitoring needs setup
    sketchybar --set $NAME label="N/A"
fi