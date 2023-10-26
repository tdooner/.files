#!/bin/bash
set -euo pipefail

declare -a tmpfiles
tmpfiles+=($(mktemp))
tmpfiles+=($(mktemp))
tmpfiles+=($(mktemp))
tmpfiles+=($(mktemp))

cleanup() {
  rm ${tmpfiles[@]}
}
trap cleanup EXIT

defaults read > "${tmpfiles[0]}"
defaults -currentHost read > "${tmpfiles[1]}"
echo "Change the thing now..."
read
defaults read > "${tmpfiles[2]}"
defaults -currentHost read > "${tmpfiles[3]}"

git diff --word-diff --no-index "${tmpfiles[0]}" "${tmpfiles[2]}" || true
echo "-currentHost options"
read
git diff --word-diff --no-index "${tmpfiles[1]}" "${tmpfiles[3]}" || true
