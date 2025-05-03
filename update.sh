#!/usr/bin/env bash
set -euo pipefail

# Determine the dotfiles directory:
if [ -n "${DOTFILES_DIR:-}" ]; then
  repo_dir="$DOTFILES_DIR"
else
  # Resolve the script's parent directory
  repo_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" &>/dev/null && pwd)"
fi

echo "🔄 Updating dotfiles in $repo_dir"
cd "$repo_dir"

# Pull latest changes
git pull origin main

# Re-run install script
echo "🔗 Re-running install.sh"
./install.sh

echo "✅ update.sh complete!"
