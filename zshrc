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
alias be="bundle exec"
alias rr="[[ -e .zeus.sock ]] && zeus rake routes || bundle exec rake routes"
alias c="[[ -e .zeus.sock ]] && zeus console || bundle exec rails console"
alias rake="[[ -e .zeus.sock ]] && zeus rake || bundle exec rake"
alias gd="git diff --color"
alias g10="git log --pretty --oneline --graph -10"
alias window="tmux rename-window"
alias z="zeus"
alias vmi="vim"
alias k="knife"

send-xbmc () {
  curl -H "Content-Type: application/json" -XPOST -d $1 http://turgon:8080/jsonrpc > /dev/null
}

play () {
  enqueue=$(echo '{"jsonrpc": "2.0", "method": "Playlist.Insert", "params":{"playlistid":0, "position": 0, "item" : { "file" : "plugin://plugin.video.youtube/?action=play_video&videoid='$1'" }}, "id" : 1}')
  send-xbmc $enqueue
  send-xbmc '{"jsonrpc": "2.0", "method": "Player.Open", "params":{"item":{"playlistid":0, "position" : 0}}, "id": 1}'
}

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

green () {
  echo "$fg[green]$1$reset_color"
}

red () {
  echo "$fg[red]$1$reset_color"
}

update () {
  local remote_sha1=$(cd ~/.files && git ls-remote origin refs/heads/master 2>/dev/null | cut -f1)
  local local_sha1=$(cd ~/.files && git sha1)
  if [[ ! $local_sha1 = $remote_sha1 ]]; then
    cd ~/.files && git fetch && git rebase origin/master
  fi
}

if [ $TMUX ]; then
  export SSH_AUTH_SOCK=$HOME/.ssh/auth
else
  ln -sf $SSH_AUTH_SOCK $HOME/.ssh/auth
fi

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
plugins=(git brew zeus rails)

source $ZSH/oh-my-zsh.sh

export EDITOR=`which vim`
export GIT_EDITOR=`which vim`
export GOPATH=$HOME/dev/go

# Causes Stuff:
# TODO: Come up with a more resilient way to branch based on host.
if [[ -n $(hostname | grep causes) ]]; then
  source ~/.files/zshrc.causes
fi

# Use Vi key bindings for faster navigation
set -o vi
bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey '^A' beginning-of-line
bindkey '^E' end-of-line

# This line is dedicated to Aaron Neyer:
mesg n
stty -ixon  # disable ctrl+s

# Customize to your needs...
export PATH=/usr/kerberos/bin:/usr/local/bin:/bin:/usr/bin:$GOPATH/bin:$HOME/bin:$PATH

if [[ -d $HOME/.rbenv/bin ]] ; then
   export PATH=$HOME/.rbenv/bin:$HOME/.rbenv/shims:$PATH
   eval "$(rbenv init -)"
fi
