
# Check for an interactive session
[ -z "$PS1" ] && return


PS1='[\u@\e[0;31m\h\e[m \W]\[$(tput setaf 7)\]$ '
#i export PS1="\w \u\$ "
#PS1='\u@\h:\W$(__git_ps1 " (%s)")\$ '

PS1='[\u@\h \W] \j $ '

alias :q='exit'
alias ls='ls --color=auto'
alias gcc='gcc -Werror -Wall -std=C99 -pedantic'
alias ll='ls -lash'
# Open vim in the last position
alias vim="vim +normal\\'\\\""
alias v='vim'
alias g='git'
alias t='sh ~/bin/todo.sh'
alias vi='vim'
alias dropboxd='~/.dropbox-dist/dropboxd'
alias spacechem='cd bin/spacechem; mono SpaceChem.exe'
alias halt='halt -p'


export EDITOR=vim
export HISTCONTROL=ignoredups
#export TERM=xterm-256color
export LD_LIBRARY_PATH="/opt/java/jre/lib/i386"
export PATH="$PATH/usr/share/java/apache-ant/bin/ant"

complete -cf sudo
complete -cf man
complete -cf pacman

setterm -blength 0
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
