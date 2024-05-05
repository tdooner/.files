#!/bin/bash
source $(dirname $0)/../util.sh

if [ $IS_ON_MAC = "true" ]; then
  brew install neovim
else
  sudo apt-get install -y neovim
fi

mkdir -p ~/.config/nvim/
install_symlink "$HOME/.config/nvim" "$DOTDIR/neovim"
