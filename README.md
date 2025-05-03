# 🛠 Ivan Tkachenko’s Dotfiles

Bootstrap your macOS development environment with a single installer script. This repository manages:

- **Shell:** `.zshrc`, `.zprofile`
- **Git:** `.gitconfig`
- **Packages:** `Brewfile`
- **Custom scripts:** `bin/`
- **VS Code:** user settings, keybindings, snippets, and extensions

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
    └── vscode_extensions.txt  # List of extension IDs, one per line
```

---

## 🚀 First-Time Setup

On a fresh macOS machine, run:

```bash
# Clone your dotfiles repository
git clone https://github.com/yourusername/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

# Make the installer executable
chmod +x install.sh

# Run the installer
./install.sh
```

**Under the hood**, `install.sh` will:

1. Determine the repo location and back up any existing dotfiles.
2. **Update Homebrew** and **upgrade** any installed formulae (`brew update && brew upgrade`).
3. **Install** all packages declared in your `Brewfile`.
4. **Autoremove** and **clean up** unused Homebrew dependencies.
5. **Symlink** your shell (`.zshrc`, `.zprofile`) and Git (`.gitconfig`) files into your home directory.
6. **Symlink** VS Code user files (`settings.json`, `keybindings.json`, `snippets/`).
7. **Install** all VS Code extensions listed in `vscode/vscode_extensions.txt`.

---

## 🔄 Keeping Up-to-Date

When you change any dotfiles, add new brew packages, or update VS Code config, simply:

```bash
cd "$HOME/dotfiles"
chmod +x update.sh
./update.sh
```

This will:

1. **Update Homebrew** and **upgrade** installed formulae.
2. **Pull** the latest commits from GitHub.
3. **Re-run** `install.sh` to apply any new dotfiles, packages, or extensions.

---

## ⚙️ VS Code Configuration

All VS Code user files live under the `vscode/` directory and are symlinked into:

```
~/Library/Application Support/Code/User/
├── settings.json      ← vscode/user_settings.json
├── keybindings.json   ← vscode/keybindings.json
└── snippets/          ← vscode/snippets/
```

- **Settings**: `vscode/user_settings.json`
- **Keybindings**: `vscode/keybindings.json`
- **Snippets**: files in `vscode/snippets/`
- **Extensions**: listed, one per line, in `vscode/vscode_extensions.txt`

---

## 📄 License

This project is licensed under the MIT License. See [LICENSE](LICENSE) for details.
