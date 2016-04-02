#!/bin/bash
set -euo pipefail

force=${1:-''}

install_vim() {
  if command -v vim >/dev/null; then
    # No need to uninstall on linux, the subsequent `make` will clobber it.
    if command -v brew >/dev/null; then
      echo 'Uninstalling Vim...'
      brew unlink vim
    fi
  fi

  echo 'Installing Vim...'
  if command -v brew >/dev/null; then
    brew install vim
  fi
}

if command -v vim >/dev/null; then
  [ -n "$force" ] && install_vim
fi

vim +PluginInstall +qall
