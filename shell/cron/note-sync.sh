#! /bin/bash

cd ~/notes.wiki

# Check if there are any changes to commit
if [[ -n $(git status --porcelain) ]]; then
  git add -A
  git commit -m "$(date)"
  git push
else
  echo "No changes to commit"
fi


