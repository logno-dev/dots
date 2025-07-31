sketchybar --add item window.title left \
  --set window.title \
    script="$PLUGIN_DIR/window_title.sh" \
    update_freq=1 \
    icon.drawing=off \
    label.font="Menlo:Bold:12.0" \
    label.color=0xffffffff

sketchybar --add event aerospace_window_change
sketchybar --subscribe window.title aerospace_window_change

