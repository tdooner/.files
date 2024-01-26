#!/bin/bash
source $(dirname $0)/../util.sh

if [ $IS_ON_MAC = "true" ]; then
  brew install neovim
fi

mkdir -p ~/.config/nvim/
install_symlink "$HOME/.config/nvim/init.lua" "$DOTDIR/neovim/init.lua"
