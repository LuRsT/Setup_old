# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# Source extra alias
if [ -f ${HOME}/.alias ]; then
    . ${HOME}/.alias
fi

# Check for an interactive session
[ -z "$PS1" ] && return


PS1='[\u@\e[0;31m\h\e[m \W]\[$(tput setaf 7)\] \j$ '
PS1="$PS1"'$([ -n "$TMUX" ] && tmux setenv TMUXPWD_$(tmux display -p "#I_#P") "$PWD")'

alias vim="vim +normal\\'\\\""
alias v='vim'
alias vi='vim'
alias :q='exit'
alias ls='ls --color=auto'
alias gcc='gcc -Werror -Wall -std=C99 -pedantic'
alias cnetworkmanager='/home/lurst/bin/cnetworkmanager/cnetworkmanager'
alias ll='ls -lash'
alias g='git'
alias gcheck='git diff | grep "Dumper "'
alias t='sh ~/bin/todo.sh'
alias dropboxd='~/.dropbox-dist/dropboxd'
alias mountserver='sshfs gfgoncalves@alien-11.isp.ip.pt:/servers /servers'
alias tmux="TERM=screen-256color-bce tmux"
alias mocp='mocp -A'
alias spacechem='cd bin/spacechem; mono SpaceChem.exe'
alias halt='halt -p'
alias ducks='du -cms * | sort -rn | head'

export EDITOR=vim
export HISTCONTROL=ignoredups
export HISTFILESIZE=10000 # Record last 10,000 commands
export HISTSIZE=10000 # Record last 10,000 commands per session
export PATH=$PATH:/$HOME/bin/
export LD_LIBRARY_PATH="/opt/java/jre/lib/i386"
export PATH="$PATH:/usr/share/java/apache-ant/bin/ant"
export PATH="$PATH:/home/lurst/.gem/ruby/1.9.1/bin"


complete -cf sudo
complete -cf man
complete -cf pacman

setterm -blength 0

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
