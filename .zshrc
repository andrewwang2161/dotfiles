# andrewwang2161's zsh config — plain, no framework.

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history share_history hist_ignore_dups hist_reduce_blanks

autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

PROMPT='%F{green}%n@%m%f %F{blue}%~%f %# '

alias ll='ls -lah'
alias la='ls -A'
alias gs='git status --short'
alias gd='git diff'
alias gl='git log --oneline -10'
alias ..='cd ..'
alias ...='cd ../..'

export EDITOR=vim
export PAGER=less
