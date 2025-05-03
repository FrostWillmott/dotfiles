#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/dotfiles"}"
cd "$DOTFILES_DIR"

echo "🔄 Pulling latest changes"
git pull origin main

echo "🔗 Re-running install.sh"
./install.sh

echo "🗑️  Pruning Homebrew packages not in Brewfile"
brew bundle cleanup --global --force

echo "✅ update.sh complete!"
