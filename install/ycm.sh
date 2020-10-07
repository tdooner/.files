#!/bin/bash
set -euo pipefail

base_path="$HOME/.vim/bundle/YouCompleteMe"

if [ ! -f "${base_path}/third_party/ycmd/ycm_core.so" ]; then
  cd ~/.vim/bundle/YouCompleteMe
  python3 install.py --tern-completer
else
  echo "YCM .so file appears to already exist!"
fi
