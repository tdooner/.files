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
  echo "installing ${source_file} to ${target_file}"

  if [ -e "$target_file" ]; then
    if [ "`readlink $target_file`" = "$source_file" ]; then
      return
    fi
    backup "$target_file" && rm -rf $target_file
  fi

  ln -sf "$source_file" "$target_file"
}

####

for dotfile in `ls | grep -v install`; do
  install_symlink "$HOME/.${dotfile}" $DOTDIR/$dotfile
done
