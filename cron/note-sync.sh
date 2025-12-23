#! /bin/bash

# Array of note directories to sync
NOTE_DIRS=(
  "$HOME/notes.wiki"
  "$HOME/notes"
)

# Iterate over each directory and sync
for dir in "${NOTE_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "Directory $dir does not exist, skipping..."
    continue
  fi

  echo "Syncing $dir..."
  cd "$dir" || continue

  # Check if there are any changes to commit
  if [[ -n $(git status --porcelain) ]]; then
    git add -A
    git commit -m "$(date)"
    git push
  else
    echo "No changes to commit in $dir"
  fi
done
