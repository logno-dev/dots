#!/usr/bin/env sh

CPU_USAGE=$(top -l 1 | grep "CPU usage" | awk '{print $3}' | sed 's/%//')

sketchybar --set $NAME label="CPU: ${CPU_USAGE}%"
