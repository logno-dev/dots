#!/usr/bin/env sh

MEMORY_PRESSURE=$(memory_pressure | grep "System-wide memory free percentage" | awk '{print $5}' | sed 's/%//')
if [ -z "$MEMORY_PRESSURE" ]; then
    # Fallback method using vm_stat
    MEMORY_USED=$(vm_stat | grep "Pages active\|Pages inactive\|Pages speculative\|Pages wired down" | awk '{sum += $3} END {print int(sum * 4096 / 1024 / 1024)}')
    MEMORY_TOTAL=$(sysctl -n hw.memsize | awk '{print int($1 / 1024 / 1024)}')
    MEMORY_PERCENT=$(echo "scale=0; ($MEMORY_USED * 100) / $MEMORY_TOTAL" | bc)
    sketchybar --set $NAME label="RAM: ${MEMORY_PERCENT}%"
else
    MEMORY_USED=$((100 - MEMORY_PRESSURE))
    sketchybar --set $NAME label="RAM: ${MEMORY_USED}%"
fi
