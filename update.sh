#!/usr/bin/env bash
set -euo pipefail

cd "${DOTFILES_DIR:-"$HOME/dotfiles"}"

echo "🔄 git pull"
git pull origin main

echo "🔗 re-running install.sh"
./install.sh

echo "✅ update.sh complete!"
