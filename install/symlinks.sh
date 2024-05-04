#!/usr/bin/env bash

source $(dirname $0)/../util.sh

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
install_symlink "$HOME/.rgignore" "$DOTDIR/rgignore"
touch "$HOME/.zshrc.local"

