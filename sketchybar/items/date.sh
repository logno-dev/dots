#!/bin/bash

# Add date item
sketchybar --add item date right \
  --set date \
    update_freq=60 \
    script="$PLUGIN_DIR/date.sh" \
    icon= \

