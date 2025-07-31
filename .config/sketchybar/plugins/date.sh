#!/bin/bash

[ -z "$NAME" ] && exit 1

DATE=$(date "+%m/%d")
sketchybar --set "$NAME" label="$DATE"

