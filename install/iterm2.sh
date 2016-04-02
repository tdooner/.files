#!/bin/bash
set -euo pipefail
uname | grep -q 'Darwin' || exit

if [ ! -f ~/Library/Fonts/Hack-Regular.ttf ]; then
  wget -O ~/Library/Fonts/Hack-Regular.ttf \
    https://github.com/powerline/fonts/raw/master/Hack/Hack-Regular.ttf
fi
