#!/usr/bin/env bash
source ./util.sh

bash ~/.files/install/packages.sh
mkdir -p "$HOME/.config"

bash ~/.files/install/symlinks.sh
touch "$HOME/.zshrc.local"

bash ~/.files/install/bin.sh
bash ~/.files/install/vundle.sh
bash ~/.files/install/command-t.sh
bash ~/.files/install/ycm.sh
bash ~/.files/install/oh-my-zsh.sh
bash ~/.files/install/fonts.sh
bash ~/.files/install/nvim.sh

if command -v zsh >/dev/null; then
  if [ ! $(echo $SHELL | grep 'zsh') ]; then
    sudo chsh -s $(which zsh) $USER
  fi
else
  echo "Please install zsh and run 'chsh -s $(which zsh)'"
fi
