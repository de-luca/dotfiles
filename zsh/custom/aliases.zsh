if [ "$(command -v exa)" ]; then
    unalias -m 'll'
    unalias -m 'l'
    unalias -m 'la'
    unalias -m 'ls'
    alias l='exa'
    alias ls='exa -G --color auto -a -s type'
    alias ll='exa -l --color auto -a -s type'
fi

alias fig="docker-compose"
alias run="docker-compose run --rm"
alias up="docker-compose up -d"
alias upp="docker-compose up -d --force-recreate"

alias gflr="git fetch origin && git rebase --autostash origin/develop"
