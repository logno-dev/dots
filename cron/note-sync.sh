#! /bin/bash

# Array of note directories to sync
NOTE_DIRS=(
  "$HOME/notes.wiki"
  "$HOME/notes"
)

# Iterate over each directory and sync
sync_ok=true
LOG_FILE="$HOME/Library/Logs/note-sync.log"

log() {
  local message="$1"
  printf "%s %s\n" "$(date '+%Y-%m-%d %H:%M:%S')" "$message" | tee -a "$LOG_FILE"
}

log "Note sync started"

for dir in "${NOTE_DIRS[@]}"; do
  if [[ ! -d "$dir" ]]; then
    log "Directory $dir does not exist, skipping..."
    continue
  fi

  log "Syncing $dir..."
  cd "$dir" || continue

  # Check if there are any changes to commit
  if [[ -n $(git status --porcelain) ]]; then
    if ! output=$(git add -A 2>&1); then
      log "git add failed in $dir: $output"
      sync_ok=false
      continue
    fi

    if ! output=$(git commit -m "$(date)" 2>&1); then
      log "git commit failed in $dir: $output"
      sync_ok=false
      continue
    fi

    if ! output=$(git push 2>&1); then
      log "git push failed in $dir: $output"
      sync_ok=false
      continue
    fi
  else
    log "No changes to commit in $dir"
  fi
done

if [[ "$sync_ok" == "true" ]]; then
  log "Note sync completed successfully"
else
  log "Note sync failed for one or more directories"
  exit 1
fi
