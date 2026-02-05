#! /bin/bash

# Array of note directories to sync
NOTE_DIRS=(
  "$HOME/notes.wiki"
  "$HOME/notes"
)

# Iterate over each directory and sync
sync_ok=true

for dir in "${NOTE_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    echo "Directory $dir does not exist, skipping..."
    continue
  fi

  echo "Syncing $dir..."
  cd "$dir" || continue

  # Check if there are any changes to commit
  if [[ -n $(git status --porcelain) ]]; then
    if ! git add -A; then
      sync_ok=false
      continue
    fi

    if ! git commit -m "$(date)"; then
      sync_ok=false
      continue
    fi

    if ! git push; then
      sync_ok=false
      continue
    fi
  else
    echo "No changes to commit in $dir"
  fi
done

if [[ "$sync_ok" == "true" ]]; then
  terminal-notifier -title "Note Sync" -message "Sync completed successfully"
else
  terminal-notifier -title "Note Sync" -message "Sync failed for one or more directories"
  exit 1
fi
