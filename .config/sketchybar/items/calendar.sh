#!/usr/bin/env sh

sketchybar --add item     calendar right               \
           --set calendar icon=cal                     \
                          icon.color=$BLACK            \
                          icon.font="$FONT:Regular:12.0" \
                          icon.padding_left=5          \
                          icon.padding_right=5         \
                          icon.drawing=off             \
                          label.color=$BLACK           \
                          label.padding_left=5         \
                          label.padding_right=5        \
                          background.color=0xffb8c0e0  \
                          background.height=16         \
                          background.corner_radius=11
