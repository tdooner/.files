#!/usr/bin/env bash
source ./util.sh

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
