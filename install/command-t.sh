#!/bin/bash
set -euo pipefail

COMMAND_T_ROOT="$HOME/.files/vim/bundle/command-t"

build_command_t() {
  ruby_version=$1
  cd "$COMMAND_T_ROOT/ruby/command-t/ext/command-t"
  rbenv local $ruby_version
  make clean
  ruby extconf.rb
  make
}

vim_ruby_link_version() {
  vim -c ':set t_ti= t_te= nomore' -c ':ruby puts "#{RUBY_VERSION}-p#{RUBY_PATCHLEVEL}"' -cqall 2>/dev/null | \
    grep -oE '[0-9\.]*-p[0-9]*'
}

if ! vim --version | grep -q '+ruby'; then
  echo 'ERROR: Could not install command-t -- vim built without ruby'
fi

if [ ! -d "$ruby_link" ]; then
  echo "Vim linked ruby does not exist! Rebuilding Vim..."
  bash ~/.files/install/vim.sh force
fi

# echo "Vim linked against Ruby: $ruby_link_version"
# echo "Current rbenv global: $rbenv_global_version"
if [ -f "$COMMAND_T_ROOT/ruby/command-t/ext.o" ]; then
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
