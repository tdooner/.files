#!/usr/bin/env bash
set -e
export DOTDIR="$( cd "$( dirname "$0" )" && pwd )"

backup () {
  local file=$1
  cp -r "$file" "$file.bak"
}

install_symlink() {
  local target_file=$1
  local source_file=$2

  if [ "`readlink $target_file`" = "$source_file" ]; then
    return
  fi

  echo "Installing ${source_file} to ${target_file}..."

  if [ -e "$target_file" ]; then
    backup "$target_file" && rm -rf $target_file
  fi

  ln -sf "$source_file" "$target_file"
}

if [ $(command -v apt-get) ]; then
  deps="zsh git curl"
  echo "Installing $deps with apt-get"
  sudo apt-get install $deps
fi

for dotfile in `ls | grep -v install`; do
  install_symlink "$HOME/.${dotfile}" $DOTDIR/$dotfile
done

if [ $(command -v git) ]; then
  git submodule update --init
else
  # How did you get the dotfiles then?!
  echo "Please install git and run 'git submodule update --init'"
fi

if [ $(command -v zsh) ]; then
  if [ ! $(echo $SHELL | grep 'zsh') ]; then
    sudo chsh -s $(which zsh) $USER
  fi
else
  echo "Please install zsh and run 'chsh -s $(which zsh)'"
fi

if [ ! -e ~/.ssh/id_rsa.pub ]; then
  mkdir ~/.ssh 2>/dev/null
  chmod 700 ~/.ssh
  curl tomdooner.com/id_rsa.pub > ~/.ssh/id_rsa.pub
fi

if [[ ! -d ~/.rbenv ]]; then
  read -n 1 -r -p 'Install rbenv [Y/n]: ' install_rbenv
  echo ''

  if [[ $install_rbenv != "n" ]]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
fi
