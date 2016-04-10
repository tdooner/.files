ZSH=$HOME/.oh-my-zsh
ZSH_CUSTOM="$HOME/.files/oh-my-zsh-custom"
ZSH_THEME="tdooner"

alias be="bundle exec"
alias rr="[[ -e .zeus.sock ]] && zeus rake routes || bundle exec rake routes"
alias dockre="docker"
alias rake="[[ -e .zeus.sock ]] && zeus rake || bundle exec rake"
alias gd="git diff --color"
alias g10="git log --pretty --oneline --graph -10"
alias window="tmux rename-window"
alias z="zeus"
alias vmi="vim"
alias k="bundle exec knife"
alias vi="vim"
alias sca="SKIP=all"
alias migrate="bundle && bin/rake db:migrate && bin/rake db:migrate RAILS_ENV=test"
#alias vvim="$(which vim)"
#alias vim="nvim"

send-xbmc () {
  curl -H "Content-Type: application/json" -XPOST -d $1 http://columbus:8080/jsonrpc > /dev/null
}

play () {
  enqueue=$(echo '{"jsonrpc": "2.0", "method": "Playlist.Insert", "params":{"playlistid":0, "position": 0, "item" : { "file" : "plugin://plugin.video.youtube/?action=play_video&videoid='$1'" }}, "id" : 1}')
  send-xbmc $enqueue
  send-xbmc '{"jsonrpc": "2.0", "method": "Player.Open", "params":{"item":{"playlistid":0, "position" : 0}}, "id": 1}'
}

green() {
  echo "$fg[green]$1$reset_color"
}

red() {
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

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
plugins=(git brew zeus rails colored-man-pages rbenv)

source $ZSH/oh-my-zsh.sh

export EDITOR=`which vim`
export GIT_EDITOR=$EDITOR
export GOPATH=$HOME/dev/go

[ -f ~/.zshrc.local ] && source ~/.zshrc.local

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
export PATH=$HOME/bin:$GOPATH/bin:$PATH

# Sanity check against mulitple rbenv installs:
if [ -d "$HOME/.rbenv" -a -n "$RBENV_ROOT" -a "$RBENV_ROOT" != "$HOME/.rbenv" ]; then
  echo "ERROR: \$RBENV_ROOT points to $RBENV_ROOT, but you also have a ~/.rbenv directory"
fi

[ -d "$HOME/.nodenv" ] && export PATH=$HOME/.nodenv/bin:$PATH
if which nodenv >/dev/null 2>/dev/null; then eval "$(nodenv init -)"; fi

source ~/.zshrc.local
