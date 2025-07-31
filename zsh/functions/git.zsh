ginit() {
  # Check if required arguments are provided
  if [[ -z "$2" ]]; then
    echo "Usage: ginit <repo-name> [--public|--private]"
    return 1
  fi

  local visibility=${2:-"--public"}
  local repo_name=$1
  
  # Create GitHub repository
  echo "Creating GitHub repository..."
  if ! gh repo create "$repo_name" "$visibility"; then
    echo "Failed to create GitHub repository"
    return 1
  fi

  # Initialize git repository
  echo "Initializing git repository..."
  git init
  
  # Ensure we're on main branch
  git branch -M main

  # Handle .gitignore
  if [[ ! -f .gitignore ]]; then
    echo "No .gitignore found. Creating one..."
    
    # Option 1: Create from GitHub template (requires internet)
    # Uncomment the language you want, or modify as needed
    # curl -sL https://www.gitignore.io/api/node > .gitignore
    # curl -sL https://www.gitignore.io/api/python > .gitignore
    # curl -sL https://www.gitignore.io/api/macos,linux,windows,visualstudiocode > .gitignore
    
    # Option 2: Basic template (always works)
    cat > .gitignore << 'EOF'
# OS generated files
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db

# Editor files
.vscode/
.idea/
*.swp
*.swo
*~

# Logs
logs
*.log
npm-debug.log*
yarn-debug.log*
yarn-error.log*

# Dependencies
node_modules/
.pnp
.pnp.js

# Environment variables
.env
.env.local
.env.development.local
.env.test.local
.env.production.local

# Build outputs
dist/
build/
out/
EOF
    echo "Created basic .gitignore file"
  else
    echo ".gitignore already exists"
  fi

  # Add remote origin
  echo "Adding remote origin..."
  git remote add origin "git@github.com:logno-dev/$repo_name.git"

  # Stage all files
  echo "Staging files..."
  git add -A

  # Create initial commit
  echo "Creating initial commit..."
  git commit -m "initial commit"

  # Push to GitHub
  echo "Pushing to GitHub..."
  if git push -u origin main; then
    echo "✅ Repository successfully created and pushed to GitHub!"
    echo "🔗 https://github.com/logno-dev/$repo_name"
  else
    echo "❌ Failed to push to GitHub"
    return 1
  fi
}

gitall() {
  git add -A
  git commit -m "$(date)"
  git push
}
