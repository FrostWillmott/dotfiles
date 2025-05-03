#!/usr/bin/env bash
set -euo pipefail

# 0) Determine the repo root (where this script lives or via DOTFILES_DIR env)
if [ -n "${DOTFILES_DIR:-}" ]; then
  repo_dir="$DOTFILES_DIR"
else
  # Resolve the directory containing this script
  script_path="${BASH_SOURCE[0]}"
  repo_dir="$(cd "$(dirname "$script_path")" &>/dev/null && pwd)"
fi
export DOTFILES_DIR="$repo_dir"

# 1) Prepare backup
BACKUP_DIR="$HOME/dotfiles_backup_$(date +%Y%m%d_%H%M%S)"
echo "📁 Backing up existing dotfiles → $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

# 2) Symlink core dotfiles
for f in .zshrc .zprofile .gitconfig; do
  src="$DOTFILES_DIR/$f"
  dest="$HOME/$f"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$BACKUP_DIR/"
  fi
  ln -sf "$src" "$dest"
  echo "  ↪ Linked $f"
done

# 3) Symlink VS Code user configurations
VSCODE_SRC="$DOTFILES_DIR/vscode"
VSCODE_DEST="$HOME/Library/Application Support/Code/User"
echo "🔧 Linking VS Code user configs"
mkdir -p "$VSCODE_DEST"
# Map user_settings.json → settings.json, keep keybindings.json
for cfg in user_settings.json keybindings.json; do
  src="$VSCODE_SRC/$cfg"
  dst_name="${cfg#user_}"  # strip 'user_' prefix
  dest="$VSCODE_DEST/$dst_name"
  if [ -e "$dest" ] && [ ! -L "$dest" ]; then
    mv "$dest" "$BACKUP_DIR/${dst_name}.backup"
  fi
  ln -sf "$src" "$dest"
  echo "  ↪ Linked VS Code $dst_name"
done
# Snippets directory
snippet_src="$VSCODE_SRC/snippets"
snippet_dest="$VSCODE_DEST/snippets"
if [ -e "$snippet_dest" ] && [ ! -L "$snippet_dest" ]; then
  mv "$snippet_dest" "$BACKUP_DIR/snippets.backup"
fi
ln -sf "$snippet_src" "$snippet_dest"
echo "  ↪ Linked VS Code snippets/"

# 4) Homebrew package management
if command -v brew &>/dev/null; then
  echo "🍺 Installing Homebrew packages"
  brew bundle --file="$DOTFILES_DIR/Brewfile"
  echo "🧹 Removing unused Homebrew dependencies"
  brew autoremove
  echo "🧹 Cleaning up Homebrew cache and old kegs"
  brew cleanup
else
  echo "⚠️ Homebrew not found; install Homebrew first"
fi

# 5) VS Code extensions installation
ext_file="$DOTFILES_DIR/vscode/vscode_extensions.txt"
if command -v code &>/dev/null && [ -f "$ext_file" ]; then
  echo "📦 Installing VS Code extensions"
  while IFS= read -r ext; do
    code --install-extension "$ext" || true
  done <"$ext_file"
fi

# 6) Python versions via pyenv
versions_file="$DOTFILES_DIR/python_versions.txt"
if command -v pyenv &>/dev/null && [ -f "$versions_file" ]; then
  echo "🐍 Installing Python versions from $versions_file"
  while IFS= read -r ver; do
    pyenv install -s "$ver"
  done <"$versions_file"
  global_ver=$(head -n1 "$versions_file")
  echo "🌐 Setting global Python to $global_ver"
  pyenv global "$global_ver"
fi

echo "✅ install.sh complete!"
