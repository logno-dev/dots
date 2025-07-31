#!/bin/bash

visible=$(sketchybar --query date.popup.line0 | grep '"drawing": "on"')

if [ -z "$visible" ]; then
  for i in {0..7}; do
    sketchybar --set "date.popup.line$i" drawing=on
  done
else
  for i in {0..7}; do
    sketchybar --set "date.popup.line$i" drawing=off
  done
fi

