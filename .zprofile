eval "$(/opt/homebrew/bin/brew shellenv)"

export PATH="$PATH:$HOME/.local/bin"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init --path)"
