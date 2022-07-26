#!/bin/bash
set -euo pipefail

force=${1:-''}
version="VIM - Vi IMproved 8.0"

install_vim() {
  if command -v vim >/dev/null; then
    # No need to uninstall on linux, the subsequent `make` will clobber it.
    if command -v brew >/dev/null; then
      echo 'Uninstalling Vim...'
      brew uninstall --force vim
    fi
  fi

  echo 'Installing Vim...'
  if command -v brew >/dev/null; then
    brew install --build-from-source vim
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

compile_plugins() {
  if [ ! -f ~/.vim/bundle/YouCompleteMe/third_party/ycmd/ycm_core.so ]; then
    echo 'Building YCM shared object...'
    pushd ~/.vim/bundle/YouCompleteMe
    ./install.py
    popd
  fi
}

if ! command -v vim >/dev/null; then
  # If vim is not installed, install it
  will_install=true
elif [ -n "$force" ]; then
  # If the script is called with a second argument, force the install anyway
  will_install=true
elif ! vim --version | grep -q "$version"; then
  # If the wrong version of vim is installed, upgrade!
  will_install=true
else
  will_install=false
fi

if $will_install; then
  install_vim
fi

hash -r
vim +PluginInstall +qall
