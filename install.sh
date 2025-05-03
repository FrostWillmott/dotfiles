#!/usr/bin/env bash
set -euo pipefail

DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/dotfiles"}"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
VSCODE_SRC="$DOTFILES_DIR/vscode"
VSCODE_DEST="$HOME/Library/Application Support/Code/User"

echo "📁 Backing up existing dotfiles → $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 1) Core dotfiles
for f in .zshrc .zprofile .gitconfig; do
  src="$DOTFILES_DIR/$f"
  dest="$HOME/$f"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$BACKUP_DIR/"
  fi
  ln -sf "$src" "$dest"
  echo "  ↪ Linked $f"
done

# 2) VS Code user settings & keybindings
echo "🔧 Linking VS Code user configs"
mkdir -p "$VSCODE_DEST"
for cfg in user_settings.json keybindings.json; do
  src="$VSCODE_SRC/$cfg"
  dst="$VSCODE_DEST/${cfg#user_}"    # map user_settings.json → settings.json
  if [ -e "$dst" ] && [ ! -L "$dst" ]; then
    mv "$dst" "$BACKUP_DIR/$(basename "$dst").backup"
  fi
  ln -sf "$src" "$dst"
  echo "  ↪ Linked VS Code $(basename "$dst")"
done

# 3) VS Code snippets
echo "🔧 Linking VS Code snippets/"
if [ -e "$VSCODE_DEST/snippets" ] && [ ! -L "$VSCODE_DEST/snippets" ]; then
  mv "$VSCODE_DEST/snippets" "$BACKUP_DIR/snippets.backup"
fi
ln -sf "$VSCODE_SRC/snippets" "$VSCODE_DEST/snippets"

# 4) Homebrew management
if command -v brew &>/dev/null; then
  echo "🍺 brew bundle install"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  echo "🧹 brew autoremove && brew cleanup"
  brew autoremove
  brew cleanup
else
  echo "⚠️  Homebrew not found; please install it first"
fi

# 5) VS Code extensions
if command -v code &>/dev/null && [ -f "$VSCODE_SRC/vscode_extensions.txt" ]; then
  echo "📦 Installing VS Code extensions"
  while IFS= read -r ext; do
    code --install-extension "$ext" || true
  done <"$VSCODE_SRC/vscode_extensions.txt"
fi

echo "✅ install.sh complete!"
