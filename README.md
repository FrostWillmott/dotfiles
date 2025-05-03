# 🛠 Ivan Tkachenko’s Dotfiles

Bootstrap your macOS development environment with a single script. This repo manages:

- **Shell**: `.zshrc`, `.zprofile`
- **Git**: `.gitconfig`
- **Packages**: `Brewfile`
- **Custom scripts**: `bin/`
- **VS Code**: user settings, keybindings, snippets, and extensions

## Repo Structure

```
dotfiles/
├── .gitignore
├── .gitconfig
├── .zprofile
├── .zshrc
├── Brewfile
├── bin/
│   └── custom_script.sh
├── install.sh
├── update.sh
├── .github/
│   └── workflows/verify.yml
└── vscode/
    ├── user_settings.json     # VS Code settings.json
    ├── keybindings.json       # VS Code keybindings.json
    ├── snippets/              # VS Code snippet files
    └── vscode_extensions.txt # List of extension IDs, one per line
```

---

## 🚀 First-Time Setup

On a new Mac, run:

```bash
# Clone your dotfiles
git clone https://github.com/yourusername/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

# Make the installer executable
chmod +x install.sh

# Run the installer (symlinks, brew, VS Code extensions)
./install.sh
```

After this, your shell config, Homebrew packages, and VS Code user files (settings, keybindings, snippets, extensions) will be in place.

---

## 🔄 Keeping Up-to-Date

Whenever you modify this repo (add dotfiles, brew packages, or VS Code settings/extensions), simply:

```bash
cd "$HOME/dotfiles"
chmod +x update.sh
./update.sh
```

This will pull the latest commits, re-run `install.sh`, and keep everything in sync.

---

## ⚙️ VS Code Configuration

All VS Code user files live in `vscode/` and are symlinked into the app’s user folder:

```
~/Library/Application Support/Code/User/
├── settings.json      ← vscode/user_settings.json
├── keybindings.json   ← vscode/keybindings.json
└── snippets/          ← vscode/snippets/
```

The file `vscode/vscode_extensions.txt` lists extensions to install (one ID per line).

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
