#!/usr/bin/env bash
# This script is meant to be sourced by other install scripts!
set -euo pipefail

export DOTDIR="$( cd -- "$(dirname -- ${BASH_SOURCE[0]})" &>/dev/null && pwd )"
export IS_ON_MAC=$(uname | grep -q Darwin && echo "true" || echo "false")

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
