if [ "$(command -v eza)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias l='eza'
    alias ls='eza -G --color auto -a -s type'
    alias ll='eza -l --color auto -a -s type'
fi

if [ "$(command -v bat)" ]; then
    alias cat='bat'
fi

alias fig="docker-compose"
alias run="docker-compose run --rm"
alias up="docker-compose up -d"
alias upp="docker-compose up -d --force-recreate"

alias gut="git"
alias got="git"
alias gti="git"
alias gtu="git"
alias gto="git"
