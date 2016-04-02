#!/bin/bash
set -euo pipefail

COMMAND_T_ROOT="$HOME/.files/vim/bundle/command-t"

build_command_t() {
  ruby_version=$1
  rbenv local $ruby_version
  cd "$COMMAND_T_ROOT/ruby/command-t"
  make clean
  ruby extconf.rb
  make
}

if ! vim --version | grep -q '+ruby'; then
  echo 'ERROR: Could not install command-t -- vim built without ruby'
fi

ruby_link=$(vim --version | grep -oE -- '-L[^ ]+.rbenv[^ ]+' | head -n 1)
ruby_link="${ruby_link:2}"
ruby_link_version=$(echo $ruby_link | grep -oE '[0-9]\.[0-9]\.[0-9]')

if [ ! -d "$ruby_link" ]; then
  echo "Vim linked ruby does not exist! Rebuilding Vim..."
  bash ~/.files/install/vim.sh force
fi
# echo "Vim linked against Ruby: $ruby_link_version"
# echo "Current rbenv global: $rbenv_global_version"
if [ -f "$COMMAND_T_ROOT/ruby/command-t/ext.so" ]; then
  cd "$COMMAND_T_ROOT"
  previous_version=$(git describe --abbrev=0)
  echo 'Updating CommandT...'
  git pull --quiet
  new_version=$(git describe --abbrev=0)
  if [ "$previous_version" == "$new_version" ]; then
    echo '  Same version. Not building again.'
  else
    build_command_t "$ruby_link_version"
  fi
else
  build_command_t "$ruby_link_version"
fi
