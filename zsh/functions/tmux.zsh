t() {
  if [[ -z "$1" ]]; then
    tmux
  else
    tmux new-session -s "$1"
  fi
}

ta() {
  if [[ -z "$1" ]]; then
    tmux attach
  else
    tmux attach -t "$1"
  fi
}
