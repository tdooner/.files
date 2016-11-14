#!/bin/bash
set -euo pipefail

force=${1:-''}
version="VIM - Vi IMproved 8.0"

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
  else
    echo '  ...from source'
    tmpdir="$(mktemp -d)"
    trap "rm -rf $tmpdir" EXIT
    wget -O- ftp://ftp.vim.org/pub/vim/unix/vim-8.0.tar.bz2 | \
      tar xjC "$tmpdir" --strip-components=1
    pushd $tmpdir
    ./configure --enable-rubyinterp --enable-pythoninterp
    make
    sudo make install
  fi
}

if ! command -v vim >/dev/null; then
  [ -n "$force" ] && install_vim
elif ! vim --version | grep -q "$version"; then
  install_vim
fi

vim +PluginInstall +qall
