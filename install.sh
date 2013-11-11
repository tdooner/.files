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

for dotfile in `ls | grep -v install`; do
  install_symlink "$HOME/.${dotfile}" $DOTDIR/$dotfile
done

if which git > /dev/null; then
  git submodule update --init
else
  echo "Please install git and run 'git submodule update --init'"
fi

if [[ ! -d ~/.rbenv ]]; then
  read -n 1 -r -p 'Install rbenv [Y/n]: ' install_rbenv

  if [[ $install_rbenv != "n" ]]; then
    git clone https://github.com/sstephenson/rbenv.git ~/.rbenv
    git clone https://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
  fi
fi
