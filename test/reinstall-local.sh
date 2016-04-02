#!/bin/bash
set -euo pipefail

echo 'DANGER: This will remove your local dotfiles configuration and install'
echo 'again from scratch.'
echo ''
read -n 1 -r -p 'Proceed [y/N]: ' really_do_it

if [ "$really_do_it" != "y" ]; then
  if [ "$really_do_it" != "Y" ]; then
    exit
  fi
fi

set -x
