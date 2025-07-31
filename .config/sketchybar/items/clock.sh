#!/usr/bin/env bash

sketchybar --add item clock right \
           --set clock \
           script="$PLUGIN_DIR/clock.sh" \
             update_freq=20 \
             label.padding_right=10 \
             icon.color=0xffffffff \


