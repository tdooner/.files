#!/bin/bash
set -euo pipefail

deps=()
! command -v zsh >/dev/null && deps+=('zsh')
! command -v curl >/dev/null && deps+=('curl')
! command -v wget >/dev/null && deps+=('wget')
! command -v envdir >/dev/null && deps+=('daemontools')
! command -v cmake >/dev/null && deps+=('cmake')
! command -v rbenv >/dev/null && deps+=('rbenv')
! command -v tmux >/dev/null && deps+=('tmux')

if [ "${#deps[@]}" -eq 0 ]; then
  echo 'No packages to install.'
  exit
fi

if command -v apt-get >/dev/null; then
  sudo apt-get install "${deps[@]}"
fi

if command -v brew >/dev/null; then
  brew install "${deps[@]}"
fi

# set default shell to zsh if necessary
chsh -s $(which zsh)

# install oh-my-zsh
