#!/bin/bash
set -euo pipefail

mkdir -p ~/bin
for SRC in $(find ~/.files/bin -type f); do
  dest=~/bin/$(basename $SRC)

  [ -L "$dest" ] && continue

  echo "Linking $SRC -> $dest"
  ln -sf $SRC ~/bin
done
