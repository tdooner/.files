# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="lukerandall"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
alias gd="git diff --color"
alias c="zeus c"
alias rake="zeus rake"
alias g10="git log --pretty --oneline --graph -10"
alias p="git fetch && git rebase origin/master"
alias window="tmux rename-window"
alias z="zeus"

# Set up ssh-reagent to streamline timed-out sessions.
ssh-reagent () {
  for agent in /tmp/ssh-*/agent.*; do
    export SSH_AUTH_SOCK=$agent
    if ssh-add -l 2>&1 > /dev/null; then
      echo Found working SSH Agent:
      ssh-add -l
      return
    fi
 done
 echo Cannot find ssh agent - maybe you should reconnect and forward it?
}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew zeus rails3)

source $ZSH/oh-my-zsh.sh

export TERM=xterm-256color
export EDITOR=`which vim`
export GIT_EDITOR=`which vim`

# Use Vi key bindings for faster navigation
set -o vi
bindkey -v
bindkey '^R' history-incremental-search-backward

# This line is dedicated to Aaron Neyer:
mesg n

# Customize to your needs...
export PATH=/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:$HOME/bin:$PATH

if [[ -d $HOME/.rbenv/bin ]] ; then
   export PATH=$HOME/.rbenv/bin:$PATH
   eval "$(rbenv init -)"
fi
