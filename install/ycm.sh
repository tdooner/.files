#!/bin/bash
set -euo pipefail

base_path="$HOME/.vim/bundle/YouCompleteMe"

if [ ! -f "${base_path}/third_party/ycmd/ycm_core.so" ]; then
  cd ~/.vim/bundle/YouCompleteMe
  python install.py --tern-completer
fi
