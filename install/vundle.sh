#!/bin/bash
set -euo pipefail

if [ -d ~/.vim/bundle/Vundle.vim ]; then
  echo 'Updating Vundle...'
  cd ~/.vim/bundle/Vundle.vim && git pull origin master --quiet
else
  echo 'Installing Vundle...'
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
fi
