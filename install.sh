#!/usr/bin/env bash
set -e
export DOTDIR="$( cd "$( dirname "$0" )" && pwd )"

backup() {
  local file=$1
  cp -r "$file" "$file.bak"
}

install_symlink() {
  local target_file=$1
  local source_file=$2

  if [ "`readlink $target_file`" = "$source_file" ]; then
    return
  fi

  echo "Installing ${source_file} to ${target_file}..."

  if [ -e "$target_file" ]; then
    backup "$target_file" && rm -rf $target_file
  fi

  ln -sf "$source_file" "$target_file"
}

bash ~/.files/install/packages.sh
mkdir -p "$HOME/.config"

install_symlink "$HOME/.zshrc" "$DOTDIR/zshrc"
install_symlink "$HOME/.vimrc" "$DOTDIR/vimrc"
install_symlink "$HOME/.vim" "$DOTDIR/vim"
install_symlink "$HOME/.tmux.conf" "$DOTDIR/tmux.conf"
install_symlink "$HOME/.gitconfig" "$DOTDIR/gitconfig"
install_symlink "$HOME/.gitignore" "$DOTDIR/gitignore"
install_symlink "$HOME/.slate" "$DOTDIR/slate"
install_symlink "$HOME/.hammerspoon" "$DOTDIR/hammerspoon"
install_symlink "$HOME/.config/ripgrep" "$DOTDIR/ripgrep"
install_symlink "$HOME/.gemrc" "$DOTDIR/gemrc"
install_symlink "$HOME/.ideavimrc" "$DOTDIR/ideavimrc"
touch "$HOME/.zshrc.local"

bash ~/.files/install/bin.sh
bash ~/.files/install/vundle.sh
bash ~/.files/install/vim.sh
bash ~/.files/install/command-t.sh
bash ~/.files/install/ycm.sh
bash ~/.files/install/oh-my-zsh.sh
bash ~/.files/install/fonts.sh

if command -v zsh >/dev/null; then
  if [ ! $(echo $SHELL | grep 'zsh') ]; then
    sudo chsh -s $(which zsh) $USER
  fi
else
  echo "Please install zsh and run 'chsh -s $(which zsh)'"
fi
