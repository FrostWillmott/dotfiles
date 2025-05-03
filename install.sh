#!/usr/bin/env bash
set -euo pipefail

# Directories
DOTFILES_DIR="${DOTFILES_DIR:-"$HOME/dotfiles"}"
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"

echo "📁 Backing up existing dotfiles to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# Files to symlink
FILES=(
  ".zshrc"
  ".zprofile"
  ".gitconfig"
  "user_settings.json"
)

# Backup & symlink
for file in "${FILES[@]}"; do
  src="$DOTFILES_DIR/$file"
  dest="$HOME/$file"

  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    echo "  ↪ Moving $dest to backup"
    mv "$dest" "$BACKUP_DIR/"
  fi

  echo "  ↪ Linking $src → $dest"
  ln -sf "$src" "$dest"
done

# Homebrew package install & cleanup
if command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew packages"
  brew bundle --file="$DOTFILES_DIR/Brewfile"

  echo "🧹 Removing unused Homebrew dependencies"
  brew autoremove

  echo "🧹 Cleaning up Homebrew cache and old kegs"
  brew cleanup
else
  echo "⚠️  Homebrew not found – please install it first"
fi

# VS Code settings
VSCODE_SETTINGS_SRC="$DOTFILES_DIR/user_settings.json"
VSCODE_SETTINGS_DEST="$HOME/Library/Application Support/Code/User/settings.json"

echo "🔧 Linking VS Code settings"
mkdir -p "$(dirname "$VSCODE_SETTINGS_DEST")"
if [ -e "$VSCODE_SETTINGS_DEST" ] && [ ! -L "$VSCODE_SETTINGS_DEST" ]; then
  mv "$VSCODE_SETTINGS_DEST" "$BACKUP_DIR/settings.json.backup"
fi
ln -sf "$VSCODE_SETTINGS_SRC" "$VSCODE_SETTINGS_DEST"

# VS Code extensions (if present)
EXT_FILE="$DOTFILES_DIR/vscode_extensions.txt"
if command -v code &>/dev/null && [ -f "$EXT_FILE" ]; then
  echo "📦 Installing VS Code extensions"
  while IFS= read -r ext; do
    code --install-extension "$ext" || true
  done <"$EXT_FILE"
fi

echo "✅ install.sh complete!"
