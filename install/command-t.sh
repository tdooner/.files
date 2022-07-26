#!/bin/bash
set -x
set -euo pipefail

COMMAND_T_ROOT="$HOME/.files/vim/bundle/command-t"

build_command_t() {
  ruby_version=$1
  cd "$COMMAND_T_ROOT/ruby/command-t/ext/command-t"
  export PATH="$(brew --prefix)/opt/ruby/bin:${PATH}" # ruby is installed here by homebrew
  if [ -f Makefile ]; then
    make clean # if extconf.rb has been run already
  fi
  ruby extconf.rb
  make
}

vim_ruby_link_version() {
  vim -c ':set t_ti= t_te= nomore' -c ':ruby puts "#{RUBY_VERSION}"' -cqall 2>/dev/null | \
    grep -oE '[0-9]+\.[0-9]+\.[0-9]+(-p[0-9]*)?'
}

if ! vim --version | grep -q '+ruby'; then
  echo 'ERROR: Could not install command-t -- vim built without ruby'
  exit 1
fi

# echo "Vim linked against Ruby: $ruby_link_version"
# echo "Current rbenv global: $rbenv_global_version"
ruby_link_version=$(vim_ruby_link_version)
echo "Vim linked to Ruby: ${ruby_link_version}"
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
