# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="agnoster"

# Alias
export XDG_CONFIG_HOME="~/.xdg"
export MYVIMRC="$XDG_CONFIG_HOME/vimrc"
export VIMINIT='source $MYVIMRC'
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
export TERM=screen-256color
export LD_LIBRARY_PATH="/opt/java/jre/lib/i386"
export PATH="$PATH:/usr/share/java/apache-ant/bin/ant"
export PATH="$PATH:/home/lurst/.gem/ruby/1.9.1/bin"
export _JAVA_AWT_WM_NONREPARENTING=1

# Source extra alias
if [ -f ${HOME}/.alias ]; then
    . ${HOME}/.alias
fi

# Load RVM into a shell session *as a function
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
