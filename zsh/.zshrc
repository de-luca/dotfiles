eval "$(/opt/homebrew/bin/brew shellenv)"

source $(brew --prefix)/share/antigen/antigen.zsh
antigen init $HOME/.antigenrc

# You may need to manually set your language environment
export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
else
  export EDITOR='nvim'
fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# SSH
# export SSH_KEY_PATH="~/.ssh/rsa_id"

# GPG stuff
export GPG_TTY=$(tty)

eval "$(zoxide init zsh)"
