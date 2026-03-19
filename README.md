# Ivan Tkachenko's Dotfiles

Personal macOS development environment—built for quick setup on new machines and for others who want a sensible Python/VS Code/Homebrew baseline without the boilerplate.

![CI](https://github.com/FrostWillmott/dotfiles/workflows/Verify%20dotfiles/badge.svg)
![macOS](https://img.shields.io/badge/macOS-ready-blue)
![License](https://img.shields.io/github/license/FrostWillmott/dotfiles)

Bootstrap your macOS development environment with a single installer script. This repository manages:

- **Shell:** `.zshrc`, `.zprofile`
- **Git:** `.gitconfig`
- **Packages:** `Brewfile`
- **VS Code:** user settings, snippets, and extensions
- **iTerm2:** preferences
- **Python:** versions via `python_versions.txt` (pyenv)

## Repo Structure

```
dotfiles/
├── .gitignore
├── .gitconfig
├── .zprofile
├── .zshrc
├── Brewfile
├── install.sh
├── update.sh
├── python_versions.txt
├── .github/
│   └── workflows/verify.yml
├── iterm2/
│   └── com.googlecode.iterm2.plist
├── pycharm/
│   └── settings.zip
└── vscode/
    ├── user_settings.json     # VS Code settings.json
    ├── snippets/              # VS Code snippet files
    └── vscode-extensions.txt  # List of extension IDs, one per line
```

---

## First-Time Setup

On a fresh macOS machine, run:

```bash
git clone git@github.com:FrostWillmott/dotfiles.git "$HOME/dotfiles"
cd "$HOME/dotfiles"

chmod +x install.sh
./install.sh
```

**Under the hood**, `install.sh` will:

1. Back up any existing dotfiles and symlink shell (`.zshrc`, `.zprofile`) and Git (`.gitconfig`) into your home directory.
2. Symlink VS Code user files (`settings.json`, `snippets/`) into `~/Library/Application Support/Code/User/`.
3. Update Homebrew, install packages from `Brewfile`, autoremove and cleanup.
4. Install VS Code extensions listed in `vscode/vscode-extensions.txt`.
5. Install Python versions from `python_versions.txt` via pyenv (if pyenv is available).

---

## Customize

Before or after install, adjust:

- `.gitconfig` — set your name and email
- `Brewfile` — add or remove packages
- `vscode/user_settings.json` — tweak editor settings
- `python_versions.txt` — change which Python versions to install

---

## Keeping Up-to-Date

When you change dotfiles, add brew packages, or update VS Code config:

```bash
cd "$HOME/dotfiles"
./update.sh
```

This updates Homebrew, pulls the latest from GitHub, and re-runs `install.sh`.

---

## VS Code Configuration

VS Code files under `vscode/` are symlinked into:

```
~/Library/Application Support/Code/User/
├── settings.json   ← vscode/user_settings.json
└── snippets/       ← vscode/snippets/
```

- **Settings**: `vscode/user_settings.json`
- **Snippets**: files in `vscode/snippets/`
- **Extensions**: listed in `vscode/vscode-extensions.txt` (one ID per line)

---

## License

MIT License. See [LICENSE](LICENSE) for details.
