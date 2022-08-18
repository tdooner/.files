#!/bin/bash
set -euo pipefail

is_on_mac=$(uname | grep -q Darwin && echo "true" || echo "false")
has_brew_installed=$([ -f /opt/homebrew/bin/brew ] && echo "true" || echo "false")

deps=()
! command -v zsh >/dev/null && deps+=('zsh')
! command -v curl >/dev/null && deps+=('curl')
! command -v wget >/dev/null && deps+=('wget')
! command -v envdir >/dev/null && deps+=('daemontools')
! command -v cmake >/dev/null && deps+=('cmake')
! command -v rbenv >/dev/null && deps+=('rbenv')
! command -v tmux >/dev/null && deps+=('tmux')
[ $is_on_mac = "true" ] && deps+=('python@3') # YouCompleteMe dependency
[ $is_on_mac = "true" ] && deps+=('node')     # YouCompleteMe dependency

if [ "${#deps[@]}" -eq 0 ]; then
  echo 'No packages to install.'
  exit
fi

if command -v apt-get >/dev/null; then
  sudo apt-get install "${deps[@]}"
fi

echo "is_on_mac: $is_on_mac / has_brew_installed: $has_brew_installed"
if [ $is_on_mac = "true" -a $has_brew_installed = "false" ]; then
  echo "Installing homebrew package manager..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  eval "$(/opt/homebrew/bin/brew shellenv)"
  has_brew_installed="true"
fi

if [ $has_brew_installed = "true" ]; then
  brew install "${deps[@]}"
  brew bundle
  hash -r # rehash
fi

# set default shell to zsh if necessary
if ! echo $SHELL | grep -q zsh; then
  chsh -s $(which zsh)
fi

# install oh-my-zsh
